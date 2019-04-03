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

function print-error {
	local allInfoSegments="$*"

	echo


	echo -en "\e[97;41m"
	if [ "$copywritingLanguage" = "zh_CN" ]; then
		echo -en "错误："
	else
		echo -en "ERROR:"
	fi
	echo -e "\e[0m "



	echo -en "\e[31m"
	if [ -z "${allInfoSegments// /}" ]; then
		echo -e "Details not provided.\e[0m"
	else
		echo -e "$*\e[0m"
	fi
}
alias console.error='print-error'

function print-DONE {
	echo -en "\e[30;42m"
	if [ "$copywritingLanguage" = "zh_CN" ]; then
		echo -e "完毕\e[0m"
	else
		echo -e "DONE\e[0m"
	fi
}

function print-header {
	# examples:
	#    print-header --colors="textBlack bgndMagenta" 你好！
	#    print-header "I love you!"

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
