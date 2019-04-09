function wlc_bash_tools--detect_signal_file_on_remote_machine {
    # $5: --print-signal-file-content

	if [ -z "$1" ] || [ -z "$2" ] || [ -z "$3" ] || [ -z "$4" ]; then
        wlc-print-message-of-source    'function'    'wlc_bash_tools--detect_signal_file_on_remote_machine'
		wlc-print-error    -1    "\$1, \$2, \$3 and \$4 are all required."
		return 1
	fi


	local __wlcDetectSignalFileRemotely_remoteID="$1"
	local __wlcDetectSignalFileRemotely_signalFile_remoteLocationPath="$2"
	local __wlcDetectSignalFileRemotely_signalFileName="$3"
	local __wlcDetectSignalFileRemotely_signalFile_localCacheLocationPath="$4"


	local shouldEchoFullContentOfLocalTempFileAndThenDeleteIt='no'
	if [ ! -z "$5" ]; then
        if [ "$5" == '--print-signal-file-content' ]; then
            shouldEchoFullContentOfLocalTempFileAndThenDeleteIt='yes'
        else
            colorful -- 'Invalid $5 ("'    textYellow
            colorful -- "$5"               textMagenta
            colorful -n '"). Ignored.'     textYellow

            colorful -- 'By the way, a valid value of $5, if provided, should be "'
            colorful -- '--print-signal-file-content'    textGreen
            colorful -n '"'
        fi
	fi

	local __wlcDetectSignalFileRemotely_signalFile_localCacheFullPath="$__wlcDetectSignalFileRemotely_signalFile_localCacheLocationPath/$__wlcDetectSignalFileRemotely_signalFileName"




	scp    -q    "$__wlcDetectSignalFileRemotely_remoteID:$__wlcDetectSignalFileRemotely_signalFile_remoteLocationPath/$__wlcDetectSignalFileRemotely_signalFileName"    "$__wlcDetectSignalFileRemotely_signalFile_localCacheLocationPath/"

	if [ -f "$__wlcDetectSignalFileRemotely_signalFile_localCacheFullPath" ]; then

		if [ "$shouldEchoFullContentOfLocalTempFileAndThenDeleteIt" == 'yes' ]; then
			cat    "$__wlcDetectSignalFileRemotely_signalFile_localCacheFullPath"
			rm     "$__wlcDetectSignalFileRemotely_signalFile_localCacheFullPath"
		else
            echo
            colorful -- 'The signal file "'                                               textGreen
            colorful -- "$__wlcDetectSignalFileRemotely_signalFileName"                   textBrightCyan
            colorful -- '" exists at "'                                                   textGreen
            colorful -- "$__wlcDetectSignalFileRemotely_remoteID"                         textMagenta
            colorful -- ':'                                                               textGreen
            colorful -- "$__wlcDetectSignalFileRemotely_signalFile_remoteLocationPath"    textBrightCyan
            colorful -- '".'                                                              textGreen
		fi
	else
		if [ "$shouldEchoFullContentOfLocalTempFileAndThenDeleteIt" != 'yes' ]; then
            echo
            colorful -- 'The signal file "'                                               textRed
            colorful -- "$__wlcDetectSignalFileRemotely_signalFileName"                   textYellow
            colorful -- " doesn't exist at \""                                            textRed
            colorful -- "$__wlcDetectSignalFileRemotely_remoteID"                         textMagenta
            colorful -- ':'                                                               textRed
            colorful -- "$__wlcDetectSignalFileRemotely_signalFile_remoteLocationPath"    textYellow
            colorful -- '".'                                                              textRed
		fi

        return 1
	fi
}


function wlc_bash_tools--set_signal_file_on_remote_machine {
    local ___setSignalFile_nameOfThisFunction___='wlc_bash_tools--set_signal_file_on_remote_machine'

    function wlc_bash_tools--set_signal_file_on_remote_machine--print_help {
        local ___setSignalFile_colorOfArgumentName='textGreen'
        local colorOfArgumentValue1='textMagenta'
        local colorOfArgumentValue2='textYellow'
        local colorOfArgumentValue3='textGray'
        local ___setSignalFile_colorOfMarkers___='textBlue'

        echo

        if [ "$1" == '--should-print-separation-line' ]; then
            colorful -n "$VE_line_60"
            echo
        fi

        colorful -n 'Usage:'

        colorful -- "    $___setSignalFile_nameOfThisFunction___"
        colorful -n ' \\'
        colorful -- "        <remote accessing id, user name is optional>"    $colorOfArgumentValue1
        colorful -n ' \\'
        colorful -- "        \"<signal file name to set at remote>\""         $colorOfArgumentValue2
        colorful -n ' \\'
        colorful -- "        [ "                                              $___setSignalFile_colorOfMarkers___
        colorful -- "\"<signal file full content string>\""                   $colorOfArgumentValue3
        colorful -- " ]"                                                      $___setSignalFile_colorOfMarkers___
        echo
        echo

        colorful -- "    $___setSignalFile_nameOfThisFunction___"
        colorful -n ' \\'
        colorful -- "        --to-host="                              $___setSignalFile_colorOfArgumentName
        colorful -- "<remote accessing id, user name is optional>"    $colorOfArgumentValue1
        colorful -n ' \\'
        colorful -- "        --name-of-signal-file-to-create="        $___setSignalFile_colorOfArgumentName
        colorful -- "\"<signal file name to set at remote>\""         $colorOfArgumentValue2
        colorful -n ' \\'
        colorful -- "        [ "                                      $___setSignalFile_colorOfMarkers___
        colorful -- "--content-of-signal-file="                       $___setSignalFile_colorOfArgumentName
        colorful -- "\"<signal file full content string>\""           $colorOfArgumentValue3
        colorful -- " ]"                                              $___setSignalFile_colorOfMarkers___
        echo
        echo


        colorful -n 'Examples:'

        colorful -- "    $___setSignalFile_nameOfThisFunction___"
        colorful -- "    19.79.3.19"                      $colorOfArgumentValue1
        colorful -- "    personal--should-install-git"    $colorOfArgumentValue2
        echo
        echo

        colorful -- "    $___setSignalFile_nameOfThisFunction___"
        colorful -- "    20.13.5.15"               $colorOfArgumentValue1
        colorful -- "    should-install-nodejs"    $colorOfArgumentValue2
        colorful -- "    v10.15.3-LTS"             $colorOfArgumentValue3
        echo
        echo

        colorful -- "    $___setSignalFile_nameOfThisFunction___"
        colorful -n ' \\'
        colorful -- "        --to-host="                          $___setSignalFile_colorOfArgumentName
        colorful -- "20.13.5.15"                                  $colorOfArgumentValue1
        colorful -n ' \\'
        colorful -- "        --name-of-signal-file-to-create="    $___setSignalFile_colorOfArgumentName
        colorful -- "should-install-nodejs"                       $colorOfArgumentValue2
        colorful -n ' \\'
        colorful -- "        --content-of-signal-file="           $___setSignalFile_colorOfArgumentName
        colorful -- "v10.15.3-LTS"                                $colorOfArgumentValue3
        echo
        echo
    }

    if [ $# -eq 0 ]; then
        wlc_bash_tools--set_signal_file_on_remote_machine--print_help
        return 0
    fi

    if [ $# -lt 2 ]; then
        wlc-print-message-of-source    'function'    $___setSignalFile_nameOfThisFunction___
        wlc-print-error    -1    "At least 2 arguments should be provided."
        wlc_bash_tools--set_signal_file_on_remote_machine--print_help    --should-print-separation-line
        return 7
    fi

    local ___setSignalFile_rawArg1="$1"
    local ___setSignalFile_rawArg2="$2"
    local ___setSignalFile_rawArg3="$3"


    local ___setSignalFile_stageReturnCode___

    local ___setSignalFile_duplicatedArgumentEncountered

    local ___setSignalFile_remoteIDIsProvided=0
    local ___setSignalFile_signalFileNameIsProvided=0
    local ___setSignalFile_signalFileContentIsProvided=0

    local ___setSignalFile_rawRemoteID___
    local ___setSignalFile_signalFileName___
    local ___setSignalFile_signalFileContent___

    local ___setSignalFile_currentArgument


    while true; do
        if [ $# -eq 0 ]; then
            break
        fi

        currentArgument="$1"
        shift

        case "$currentArgument" in
            --to-host=*)
                if [ $___setSignalFile_remoteIDIsProvided -gt 0 ]; then
                    duplicatedArgumentEncountered='--to-host='
                    break
                fi
                ___setSignalFile_rawRemoteID___=${currentArgument:10}
                ___setSignalFile_remoteIDIsProvided=1
                ;;

            --name-of-signal-file-to-create=*)
                if [ $___setSignalFile_signalFileNameIsProvided -gt 0 ]; then
                    duplicatedArgumentEncountered='--name-of-signal-file-to-create='
                    break
                fi
                ___setSignalFile_signalFileName___=${currentArgument:32}
                ___setSignalFile_signalFileNameIsProvided=1
                ;;

            --content-of-signal-file=*)
                if [ $___setSignalFile_signalFileContentIsProvided -gt 0 ]; then
                    duplicatedArgumentEncountered='--content-of-signal-file='
                    break
                fi
                ___setSignalFile_signalFileContent___=${currentArgument:29}
                ___setSignalFile_signalFileContentIsProvided=1
                ;;

            # *)
            #     colorful -- 'Unknow argument "'    textYellow
            #     colorful -- "$currentArgument"     textRed
            #     colorful -n '" is skipped'         textYellow
            #     ;;

        esac
    done

    echo


    if    [ $___setSignalFile_remoteIDIsProvided -eq 0 ] \
       && [ $___setSignalFile_signalFileNameIsProvided -eq 0 ] \
       && [ $___setSignalFile_signalFileContentIsProvided -eq 0 ]
    then
        ___setSignalFile_rawRemoteID___="$___setSignalFile_rawArg1"
        ___setSignalFile_signalFileName___="$___setSignalFile_rawArg2"
        ___setSignalFile_signalFileContent___="$___setSignalFile_rawArg3"
    fi



    if [ -z "$___setSignalFile_rawRemoteID___" ]; then
        wlc-print-message-of-source    'function'    $___setSignalFile_nameOfThisFunction___
        wlc-print-error    -1    "SSH connection ID to target machine was not specified."
        wlc_bash_tools--set_signal_file_on_remote_machine--print_help    --should-print-separation-line
        return 1
    fi


    if [ -z "$___setSignalFile_signalFileName___" ]; then
        wlc-print-message-of-source    'function'    $___setSignalFile_nameOfThisFunction___
        wlc-print-error    -1    "Signal file was not sepcified."
        wlc_bash_tools--set_signal_file_on_remote_machine--print_help    --should-print-separation-line
        return 2
    fi


    local ___setSignalFile_resolvedRemoteID___
    # local ___setSignalFile_resolvedRemoteHost__
    # local ___setSignalFile_resolvedRemoteUser__

    wlc-validate-host-name-or-ip-address-with-optional-user-name \
        --should-not-print-help-after-printing-error \
        "$___setSignalFile_rawRemoteID___" \
        --default-user-name='root' \
        ___setSignalFile_resolvedRemoteID___ # \
        # ___setSignalFile_resolvedRemoteHost__ \
        # ___setSignalFile_resolvedRemoteUser__

    ___setSignalFile_stageReturnCode___=$?
	if [ $___setSignalFile_stageReturnCode___ -gt 0 ]; then
        # wlc-print-message-of-source    'function'    $___setSignalFile_nameOfThisFunction___
        # wlc_bash_tools--set_signal_file_on_remote_machine--print_help    --should-print-separation-line
		return 11
	fi



    # local ___setSignalFile_localTempWorkingFolderName___
    local ___setSignalFile_localTempWorkingFolderPath___
    create-folder-with-random-number-suffix \
        --folder-name-prefix="signal-file-for-${___setSignalFile_resolvedRemoteID___}" \
        ___setSignalFile_localTempWorkingFolderPath___ #   ___setSignalFile_localTempWorkingFolderName___

    ___setSignalFile_stageReturnCode___=$?
    if [ $___setSignalFile_stageReturnCode___ -gt 0 ]; then
        return $___setSignalFile_stageReturnCode___
    fi



    local ___setSignalFile_signalFileParentFolderPathAtLocal___="$___setSignalFile_localTempWorkingFolderPath___/$WLC_BASH_TOOLS___FOLDER_NAME___OF_SIGNALS"
    mkdir    -p    "$___setSignalFile_signalFileParentFolderPathAtLocal___"




    local ___setSignalFile_signalFilePathAtLocal___="$___setSignalFile_signalFileParentFolderPathAtLocal___/$___setSignalFile_signalFileName___"
    touch    "$___setSignalFile_signalFilePathAtLocal___"
    if [ ! -z "$___setSignalFile_signalFileContent___" ]; then
        echo "$___setSignalFile_signalFileContent___" > "$___setSignalFile_signalFilePathAtLocal___"
    fi

    # echo -e "from=\"$___setSignalFile_signalFileParentFolderPathAtLocal___\""
    # echo -e "  to=$___setSignalFile_resolvedRemoteID___:~/\"$WLC_BASH_TOOLS___FOLDER_NAME___OF_SIGNALS\""
    scp    -qr    "$___setSignalFile_signalFileParentFolderPathAtLocal___"    "$___setSignalFile_resolvedRemoteID___:~"
    ___setSignalFile_stageReturnCode___=$?
    if [ $___setSignalFile_stageReturnCode___ -gt 0 ]; then
        wlc-print-message-of-source    'function'    $___setSignalFile_nameOfThisFunction___
        wlc-print-error    -1    "Scopy failed. Return code: $___setSignalFile_stageReturnCode___"
        return $___setSignalFile_stageReturnCode___
    fi
}
