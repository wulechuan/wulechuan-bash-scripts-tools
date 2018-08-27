function allow-non-root-user-to-skip-all-passwords {
	if [ -z "$1" ]; then
		return 1
	fi

	local userNameToImpartPrivilege=$1
	local statementToAppendToSudersFile="${userNameToImpartPrivilege} ALL=(ALL) NOPASSWD: ALL"

	echo
	echo -e "${darkline60}"

	local zeroMeansAlreadySet=$(echo $(</etc/sudoers) | grep -q "$statementToAppendToSudersFile" ; echo $?)
	if [ $zeroMeansAlreadySet = 0 ]; then
		if [ "$copywritingLanguage" = "zh_CN" ]; then
			echo -e "${green}  用户${blue}${userNameToImpartPrivilege}${green}早已被许可${dimmedRed}免输密码${green}。${noColor}"
		fi
		if [ "$copywritingLanguage" = "en_US" ]; then
			echo -e "${green}  Already allowed ${blue}${userNameToImpartPrivilege}${green} to ${dimmedRed}SKIP ALL PASSWORDS${green}.${noColor}"
		fi
	else
		if [ "$copywritingLanguage" = "zh_CN" ]; then
			echo -e -n "${blue}  向 /etc/sudoers 文件内追加：“${pink}$statementToAppendToSudersFile${blue}”……${noColor}"
		fi
		if [ "$copywritingLanguage" = "en_US" ]; then
			echo -e -n "${blue}  Appending \"${pink}$statementToAppendToSudersFile${blue}\"... ${noColor}"
		fi

		echo ${statementToAppendToSudersFile} >> /etc/sudoers

		if [ "$copywritingLanguage" = "zh_CN" ]; then
			echo -e "${green}完毕。${noColor}"
		fi
		if [ "$copywritingLanguage" = "en_US" ]; then
			echo -e "${green}Done.${noColor}"
		fi
	fi

	echo -e "${darkline60}"
	echo
}
