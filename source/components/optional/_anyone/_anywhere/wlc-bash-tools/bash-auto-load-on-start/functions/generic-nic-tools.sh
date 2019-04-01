function show-machine-nics {
	local regExpKnownNICNamesToSkip=''
	local columnWidthOfNICsName=16


	function printHelp {
		colorful -n 'Usage:'

		colorful -- '    machine-nics'                          textGreen
		colorful -n '    [ -p | --promisc-only ]'               textMagenta

		colorful -- '    machine-nics'                          textGreen
		colorful -n '    [ -P | --non-promisc-only ]'           textMagenta

		colorful -- '    machine-nics'                          textGreen
		colorful -n '    [ -n | --name-only | --names-only ]'   textYellow
	}


	local shouldShowPromiscNICsOnly='no'
	local shouldShowNonPromiscNICsOnly='no'
	local shouldShowNICsNameOnly='no'

	if [ "$1" == '-p' ] || [ "$1" == '--promisc-only' ]; then
		shouldShowPromiscNICsOnly='yes'
	elif [ "$1" == '-P' ] || [ "$1" == '--non-promisc-only' ]; then
		shouldShowNonPromiscNICsOnly='yes'
	elif [ "$1" == '-n' ] || [ "$1" == '--name-only' ] || [ "$1" == '--names-only' ]; then
		shouldShowNICsNameOnly='yes'
	elif [ ! -z "$1" ]; then
		colorful -- 'Invalid argument $1: "'  textRed
		colorful -- "$1"                      textYellow
		colorful -n '"'                       textRed

		printHelp

		return 1
	fi

	local duplicatedArgumentsMet='no'
	local conflictArgumentsMet='no'

	if [ "$2" == '-p' ] || [ "$2" == '--promisc-only' ]; then

		if [ "$shouldShowPromiscNICsOnly" == 'yes' ]; then
			duplicatedArgumentsMet='yes'
		elif [ "$shouldShowNonPromiscNICsOnly" == 'yes' ]; then
			conflictArgumentsMet='yes'
		else
			shouldShowPromiscNICsOnly='yes'
		fi

	elif [ "$2" == '-P' ] || [ "$2" == '--non-promisc-only' ]; then
		if [ "$shouldShowNonPromiscNICsOnly" == 'yes' ]; then
			duplicatedArgumentsMet='yes'
		elif [ "$shouldShowPromiscNICsOnly" == 'yes' ]; then
			conflictArgumentsMet='yes'
		else
			shouldShowNonPromiscNICsOnly='yes'
		fi

	elif [ "$2" == '-n' ] || [ "$2" == '--name-only' ] || [ "$2" == '--names-only' ]; then

		if [ "$shouldShowNICsNameOnly" == 'yes' ]; then
			duplicatedArgumentsMet='yes'
		else
			shouldShowNICsNameOnly='yes'
		fi

	elif [ ! -z "$2" ]; then
		colorful -- 'Invalid argument $2: "'  textRed
		colorful -- "$2"                      textYellow
		colorful -n '"'                       textRed

		printHelp

		return 2
	fi

	if [ "$duplicatedArgumentsMet" == 'yes' ]; then
		colorful -- 'Duplicated arguments "'  textRed
		colorful -- "$1"                      textYellow
		colorful -- '" and "'                 textRed
		colorful -- "$2"                      textYellow
		colorful -n '" met.'                  textRed

		printHelp

		return 16
	fi

	if [ "$conflictArgumentsMet" == 'yes' ]; then
		colorful -- 'Conflict arguments "'  textRed
		colorful -- "$1"                    textYellow
		colorful -- '" and "'               textRed
		colorful -- "$2"                    textYellow
		colorful -n '" met.'                textRed

		printHelp

		return 17
	fi


	# echo "DEBUG: shouldShowPromiscNICsOnly=$shouldShowPromiscNICsOnly"
	# echo "DEBUG: shouldShowNICsNameOnly=$shouldShowNICsNameOnly"



	local enoughSpacebars='                                 '

	local awkSnippetRemoveHeading="{ if (NR == 1) next }"
	local awkSnippetBEGINSetupSeparators='BEGIN { FS=" |:"; RS="\n\n"; ORS="\n" }'
	local awkSnippetPrepare="{ nicName=\$1 }"
	local awkSnippetSkipLOOPBACK="{ if (\$0 ~ /LOOPBACK/) next }"
	local awkSnippetSkipSomeNICsByName="{ if (length(\"$regExpKnownNICNamesToSkip\") > 0 && nicName ~ /$regExpKnownNICNamesToSkip/) next }"
	local awkSnippetAlignFirstColumn="{
		paddingWidth=$columnWidthOfNICsName - length(nicName) - 1;
		if (paddingWidth > 0)
			padding=substr(\"$enoughSpacebars\", 0, paddingWidth);
		else
			padding=\"\"
	}"

	if [ "$shouldShowPromiscNICsOnly" == 'yes' ]; then
		ifconfig | awk "
			$awkSnippetBEGINSetupSeparators
			$awkSnippetPrepare
			$awkSnippetSkipLOOPBACK
			$awkSnippetSkipSomeNICsByName
			{ if (\$0 !~ /PROMISC/) next }
			{ print nicName }
		"
	elif [ "$shouldShowNonPromiscNICsOnly" == 'yes' ]; then
		ifconfig | awk "
			$awkSnippetBEGINSetupSeparators
			$awkSnippetPrepare
			$awkSnippetSkipLOOPBACK
			$awkSnippetSkipSomeNICsByName
			{ if (\$0  ~ /PROMISC/) next }
			{ print nicName }
		"
	else
		if [ "$shouldShowNICsNameOnly" == 'yes' ]; then
		ifconfig | awk "
			$awkSnippetBEGINSetupSeparators
			$awkSnippetPrepare
			$awkSnippetSkipLOOPBACK
			$awkSnippetSkipSomeNICsByName
			{ print nicName }
		"
		else
			ifconfig | awk "
				$awkSnippetBEGINSetupSeparators
				$awkSnippetPrepare
				$awkSnippetSkipLOOPBACK
				$awkSnippetSkipSomeNICsByName
				$awkSnippetAlignFirstColumn
				{
					printf(\"%s %s\", nicName, padding);
					if (\$0 ~ /PROMISC/)
						print \"\\033[32mPROMISC\\033[0;0m\";
					else
						print \"\\033[31mNON-PROMISC\\033[0;0m\"
				}
			"
		fi
	fi
}


function __batch-process-nics-promisc-mode-single-action-type__ {
	local isToDisablePromiscModeForNICs='no'
	local shouldPrintSplashes='yes'

	if [ -z "$1" ]; then
		return
	fi

	local _nicsList="$1"

	if     [ "$2" == '--no-splashes' ] \
	    || [ "$3" == '--no-splashes' ]
	then
		shouldPrintSplashes='no'
	fi

	if     [ "$2" == '--is-to-disable-promisc-mode' ] \
	    || [ "$2" == '-d' ] \
	    || [ "$3" == '--is-to-disable-promisc-mode' ] \
	    || [ "$3" == '-d' ]
	then
		isToDisablePromiscModeForNICs='yes'
	fi

	local theVerb='promisc'
	local theVerbName1='Enable'
	local theVerbName2='Enabled'
	local colorChief='Green'
	local colorOfSkippedInfo='Red'

	if [ "$isToDisablePromiscModeForNICs" == 'yes' ]; then
		theVerb='-promisc'
		theVerbName1='Disable'
		theVerbName2='Disabled'
		colorChief='Red'
		colorOfSkippedInfo='Green'
	fi

	if [ "$shouldPrintSplashes" == 'yes' ]; then
		colorful -n "$VE_line_40"
		show-machine-nics
		colorful -n "$VE_line_40"
	fi

	local nicName
	local shouldTakeAction
	local userInput
	local stageReturnCode

	for nicName in $_nicsList; do
		shouldTakeAction='no'

		echo
		echo

	 	while true; do
			colorful -- "$theVerbName1 "   text"$colorChief"
			colorful -- "promisc"          textBlack   bgndYellow
			colorful -- " mode for \""     text"$colorChief"
			colorful -- "$nicName"         textMagenta
			colorful -- "\"? [y/n] "       text"$colorChief"

			read    -t 20   userInput
			stageReturnCode=$?
			if [ "$stageReturnCode" -eq 0 ]; then
				case $userInput in
					[yY])
						shouldTakeAction='yes'
						break
						;;

					[nN])
						shouldTakeAction='no'
						break
						;;
				esac
			else
				echo
				break
			fi
		done


		if [ "$shouldTakeAction" == 'yes' ]; then
			ifconfig  "$nicName"  "$theVerb"

			colorful -- "$nicName "       textMagenta
			colorful -n "$theVerbName2"   textBlack  bgnd"$colorChief"
		else
			colorful -- "$nicName "       textMagenta
			colorful -n 'Skipped'         textBlack  bgnd"$colorOfSkippedInfo"
		fi
	done

	echo
	echo

	if [ "$shouldPrintSplashes" == 'yes' ]; then
		colorful -n "$VE_line_40"
		show-machine-nics
		colorful -n "$VE_line_40"
	fi
}


function batch-process-nics-promisc-mode {
	local nicsListToEnable=` show-machine-nics   --non-promisc-only`
	local nicsListToDisable=`show-machine-nics       --promisc-only`

	if [ -z "$nicsListToEnable" ] && [ -z "$nicsListToDisable" ]; then
		return
	fi

	colorful -n "$VE_line_40"
	show-machine-nics
	colorful -n "$VE_line_40"

	__batch-process-nics-promisc-mode-single-action-type__    "$nicsListToEnable"    '--no-splashes'
	__batch-process-nics-promisc-mode-single-action-type__    "$nicsListToDisable"   '--no-splashes'    '--is-to-disable-promisc-mode'

	colorful -n "$VE_line_40"
	show-machine-nics
	colorful -n "$VE_line_40"
}

function batch-enable-nics-promisc-mode {
	local nicsList=`show-machine-nics    --non-promisc-only`
	__batch-process-nics-promisc-mode-single-action-type__    "$nicsList"
}

function batch-disable-nics-promisc-mode {
	local nicsList=`show-machine-nics    --promisc-only`
	__batch-process-nics-promisc-mode-single-action-type__    "$nicsList"    '--is-to-disable-promisc-mode'
}