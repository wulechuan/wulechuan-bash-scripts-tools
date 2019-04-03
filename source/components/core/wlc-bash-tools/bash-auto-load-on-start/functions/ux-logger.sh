function echo3 {
	echo
	echo
	echo
}

function echo4 {
	echo
	echo
	echo
	echo
}

function echo5 {
	echo
	echo
	echo
	echo
	echo
}

function echo6 {
	echo
	echo
	echo
	echo
	echo
	echo
}

function echo7 {
	echo
	echo
	echo
	echo
	echo
	echo
	echo
}

function print-date {
	date +"%Y-%m-%d"
}

function print-date-without-year {
	date +"%m-%d"
}

function print-time {
	date +"%H:%M:%S"
}

function print-time-without-seconds {
	date +"%H:%M:%S"
}

function print-date-and-time {
	date +"%Y-%m-%d %H:%M:%S"
}

function wlc-print-error {
	local shouldPrintInOneLine=0
	local shouldPrintLineFeedAtEnd=1

	if [ "$1" == '-1' ]; then
		shouldPrintInOneLine=1
		shift
	fi

	if [ "$1" == '--' ]; then
		shouldPrintInOneLine=1
		shouldPrintLineFeedAtEnd=0
		shift
	fi

	local allInfoSegments="$*"


	echo -en "\e[97;41m"
	if [ "$copywritingLanguage" = "zh_CN" ]; then
		echo -en "错误："
	else
		echo -en "ERROR:"
	fi

	echo -en "\e[0m "
	if [ $shouldPrintInOneLine -eq 0 ]; then
		echo
	fi



	echo -en "\e[31m"
	if [ -z "${allInfoSegments// /}" ]; then
		echo -en "Details not provided.\e[0m"
	else
		echo -en "$*\e[0m"
	fi

	if [ $shouldPrintLineFeedAtEnd -eq 1 ]; then
		echo
	fi
}

function wlc-print-DONE {
	echo -en "\e[30;42m"
	if [ "$copywritingLanguage" = "zh_CN" ]; then
		echo -e "完毕\e[0m"
	else
		echo -e "DONE\e[0m"
	fi
}
alias print-DONE='wlc-print-DONE'

function wlc-print-message-of-source {
	local sourceType="$1" # function, .sh file, etc.
	local sourceName="$2" # functionName, filePath, fileName, etc.

	echo -en "\e[30;47mMessage\e[0m "

	if [ $# -eq 0 ]; then
		echo -e "Message source unspecificied:"
		return 1
	fi

	if [ $# -eq 1 ]; then
		sourceName="$1"
		echo -e "\e[96m${sourceName}\e[0m:"
		return
	fi

	echo -e "\e[32m${sourceType} \e[96m${sourceName}\e[0m:"

	if [ $# -gt 2 ]; then
		echo -e $*
	fi
}

function wlc-print-header {
	# examples:
	#    wlc-print-header --colors="textBlack bgndMagenta" 你好！
	#    wlc-print-header "I love you!"

	local fisrtArgument="$1"
	local colors='textGreen'

	if [[ "$fisrtArgument" =~ ^--colors= ]]; then
		colors=${fisrtArgument:9}
		shift
	fi

	echo
	colorful -n "$VE_line_60"    "$colors"
	colorful -n "$*"             "$colors"
	colorful -n "$VE_line_60"    "$colors"
	echo
}

function wlc-print-direct-children {
	local pathOfFolderToListChildrenOf="$1"

	if [ -z "$pathOfFolderToListChildrenOf" ] || [ ! -d "$pathOfFolderToListChildrenOf" ]; then
		wlc-print-message-of-source    'function'    'print-direct-children'
		wlc-print-error    -1    "Folder not found: \"\e[33m$pathOfFolderToListChildrenOf\e[31m\""
		return 1
	fi

	local __itemName__
	local __itemPath__

	echo "$VE_line_60"
	for __itemName__ in `ls -A "$pathOfFolderToListChildrenOf"`; do
		__itemPath__="$_sourceFolderPath/$__itemName__"
		echo "\"__itemPath__=$__itemPath__\""

		if   [ -f "$__itemPath__" ]; then
			echo -e "  File: \e[32m$__itemName__\e[0m"
		elif [ -d "$__itemPath__" ]; then
			echo -e "Folder: \e[35m$__itemName__\e[0m"
		fi
	done
	echo "$VE_line_60"
}