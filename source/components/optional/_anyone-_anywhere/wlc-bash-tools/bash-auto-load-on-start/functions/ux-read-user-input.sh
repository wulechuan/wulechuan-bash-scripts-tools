# function wlc-read {
# 	local tipStringAsIntroduction="$1"
# 	local tipStringPerConfirmation="$2"

# 	local options="$3"
# 	local timeoutInSeconds="$4"
# 	local defaultOptionWhenTimeIsOut="$5"

# 	local errorCountToRePrintIntroduction="$6"
# 	local maxErrorCountAllowed="$7"

# 	local result='yes'
# 	local userDecision=''
# 	local option1="[yY]"
# 	local option2="[nN]"

# 	while true; do
# 		echo -en "Shall we also start \"\e[32mpktminer\e[0m\" (30 seconds; default=y)? [\e[32my\e[0m/n] "
# 		read -t 30  -n 1   userDecision
# 		if [ $? -gt 0 ]; then
# 			echo
# 			echo 'Time is out.'
# 			result='yes'
# 			break
# 		fi

# 		if [ ! -z "$userDecision" ]; then
# 			echo
# 		fi

# 		case $userDecision in
# 			$option1)
# 				result='yes'
# 				break
# 				;;

# 			$option2)
# 				result='no'
# 				break
# 				;;
# 		esac
# 	done

# 	echo

# 	if [ "$result" == 'yes' ]; then
# 		echo
# 		colorful -n "Starting pktminer..." textGreen
# 		bpc start pktminer
# 	fi
# }