function __unnamed_organization_docker_allow_non_root_user_skip_all_password_ {
	echo
	echo -e "${darkline60}"

	local _myLDPAUserName="${myLDPAUserName}"
	local statementToAppend="${_myLDPAUserName} ALL=(ALL) NOPASSWD: ALL"

	local zeroMeansAlreadySet=$(echo $(</etc/sudoers) | grep -q "$statementToAppend" ; echo $?)
	if [ $zeroMeansAlreadySet = 0 ]; then
		if [ "$copywritingLanguage" = "zh_CN" ]; then
			echo -e "${green}  用户${blue}${_myLDPAUserName}${green}早已被许可${dimmedRed}在docker环境免输除Git账户外的任何密码${green}。${noColor}"
		fi
		if [ "$copywritingLanguage" = "en_US" ]; then
			echo -e "${green}  Already allowed ${blue}${_myLDPAUserName}${green} to ${dimmedRed}SKIP ALL PASSWORDS${green}.${noColor}"
		fi
	else
		if [ "$copywritingLanguage" = "zh_CN" ]; then
			echo -e -n "${blue}  向/et/sudoers文件内追加：“${pink}$statementToAppend${blue}”……${noColor}"
		fi
		if [ "$copywritingLanguage" = "en_US" ]; then
			echo -e -n "${blue}  Appending \"${pink}$statementToAppend${blue}\"... ${noColor}"
		fi

		echo ${statementToAppend} >> /etc/sudoers

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

function __unnamed_organization_docker_print_beautify_hostname_call_to_action_ {
	local currentHostName=$(hostname)

	if [[ "$currentHostName" =~ ^unnamed-org\-.*docker\- ]]; then
		return;
	fi

	echo
	echo -e "${darkline60}"
	if [ "$copywritingLanguage" = "zh_CN" ]; then
		echo -e "  何不试试这条命令：${blue}beautiful-hostname ${green}your-own-keyword${noColor}"
	fi
	if [ "$copywritingLanguage" = "en_US" ]; then
		echo -e "  Why not try ${blue}beautiful-hostname ${green}your-own-keyword${noColor}?"
	fi
	echo

	__unnamed_organization_docker_beautify_hostname_print_help_

	if [ "$copywritingLanguage" = "zh_CN" ]; then
		echo -e "  ${pink}来吧！试一次，绝错不了！${noColor}"
	fi
	if [ "$copywritingLanguage" = "en_US" ]; then
		echo -e "  ${pink}Come on! Do it!${noColor}"
	fi
}

function __unnamed_organization_docker_beautify_hostname_print_help_ {
	local exampleResult

	if [ "$copywritingLanguage" = "zh_CN" ]; then
		echo -e "  范例"
	fi
	if [ "$copywritingLanguage" = "en_US" ]; then
		echo -e "  Examples"
	fi

	echo -e "  ${darkline20}"

	exampleResult=$(__unnamed_organization_docker_beautify_hostname_core_ Green)
	if [ "$copywritingLanguage" = "zh_CN" ]; then
		echo -e "  ${blue}beautiful-hostname ${green}Green${noColor}     ${dark}# hostname将变更为： ${noColor}${blue}${exampleResult}${noColor}"
	fi
	if [ "$copywritingLanguage" = "en_US" ]; then
		echo -e "  ${blue}beautiful-hostname ${green}Green${noColor}     ${dark}# hostname will be: ${noColor}${blue}${exampleResult}${noColor}"
	fi

	exampleResult=$(__unnamed_organization_docker_beautify_hostname_core_ Gray)
	if [ "$copywritingLanguage" = "zh_CN" ]; then
		echo -e "  ${blue}beautiful-hostname ${green}Gray${noColor}      ${dark}# hostname将变更为： ${noColor}${blue}${exampleResult}${noColor}"
	fi
	if [ "$copywritingLanguage" = "en_US" ]; then
		echo -e "  ${blue}beautiful-hostname ${green}Gray${noColor}      ${dark}# hostname will be: ${noColor}${blue}${exampleResult}${noColor}"
	fi

	exampleResult=$(__unnamed_organization_docker_beautify_hostname_core_ Lovely)
	if [ "$copywritingLanguage" = "zh_CN" ]; then
		echo -e "  ${blue}beautiful-hostname ${green}Lovely${noColor}    ${dark}# hostname将变更为： ${noColor}${blue}${exampleResult}${noColor}"
	fi
	if [ "$copywritingLanguage" = "en_US" ]; then
		echo -e "  ${blue}beautiful-hostname ${green}Lovely${noColor}    ${dark}# hostname will be: ${noColor}${blue}${exampleResult}${noColor}"
	fi

	if [ "$copywritingLanguage" = "zh_CN" ]; then
		exampleResult=$(__unnamed_organization_docker_beautify_hostname_core_ 钢铁侠)
		echo -e "  ${blue}beautiful-hostname ${green}钢铁侠${noColor}   ${dark}# hostname将变更为： ${noColor}${blue}${exampleResult}${noColor}"
	fi
	if [ "$copywritingLanguage" = "en_US" ]; then
		exampleResult=$(__unnamed_organization_docker_beautify_hostname_core_ IronMan)
		echo -e "  ${blue}beautiful-hostname ${green}IronMan${noColor}   ${dark}# hostname will be: ${noColor}${blue}${exampleResult}${noColor}"
	fi

	echo -e "  ${darkline20}"
}

function __unnamed_organization_docker_beautify_hostname_core_ {
	local docker_characteristic_name=$1
	[ ${docker_characteristic_name:="UNKNOWN-WHALE-GROUP"} ]
	echo "unnamed-org-$docker_characteristic_name-docker-$thisDockerIPSuffix"
}

function __unnamed_organization_docker_beautify_hostname_ {
	if [ -z "$1" ]; then
		echo
		__unnamed_organization_docker_beautify_hostname_print_help_
		return
	fi

	if [ "$1" = "--help" ]; then
		echo
		__unnamed_organization_docker_beautify_hostname_print_help_
		return
	fi

	if [ "$1" = "-h" ]; then
		echo
		__unnamed_organization_docker_beautify_hostname_print_help_
		return
	fi

	hostname $(__unnamed_organization_docker_beautify_hostname_core_ $1)

	exec bash -l;
}
