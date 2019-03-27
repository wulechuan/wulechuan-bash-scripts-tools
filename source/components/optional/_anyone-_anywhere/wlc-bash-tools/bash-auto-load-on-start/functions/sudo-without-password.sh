function allow-non-root-user-to-skip-all-passwords {
	if [ -z "$1" ]; then
		return 1
	fi

	local userNameToImpartPrivilege=$1
	local statementToAppendToSudersFile="${userNameToImpartPrivilege} ALL=(ALL) NOPASSWD: ALL"

	echo
	colorful -n "$VE_line_60"

	local zeroMeansAlreadySet=`echo $(</etc/sudoers) | grep -q "$statementToAppendToSudersFile"; echo $?`

	if [ $zeroMeansAlreadySet = 0 ]; then
		if [ "$copywritingLanguage" = "zh_CN" ]; then
			colorful -- '用户'                          textGreen
			colorful -- "$userNameToImpartPrivilege"    textBlue
			colorful -- '早已被许可'                     textGreen
			colorful -- '免输密码'                       textRed
			colorful -n '。'                            textGreen
		else
			colorful -- 'Already allowed '              textGreen
			colorful -- "$userNameToImpartPrivilege"    textBlue
			colorful -- ' to '                          textGreen
			colorful -- 'SKIP ALL PASSWORDS'            textRed
			colorful -n '.'                             textGreen
		fi
	else
		if [ "$copywritingLanguage" = "zh_CN" ]; then
			colorful -- '向 "'                              textBlue
			colorful -- '/etc/sudoers'                      textGreen
			colorful -- '" 文件内追加：“'                     textBlue
			colorful -- "$statementToAppendToSudersFile"    textMagenta
			colorful -n '”……'                               textBlue
		else
			colorful -- 'Appending "'                       textBlue
			colorful -- "$statementToAppendToSudersFile"    textMagenta
			colorful -- '" to "'                            textBlue
			colorful -- '/etc/sudoers'                      textGreen
			colorful -n '"...'                              textBlue
		fi

		echo "$statementToAppendToSudersFile" >> /etc/sudoers

		print-DONE
	fi

	colorful -n "$VE_line_60"
	echo
}
