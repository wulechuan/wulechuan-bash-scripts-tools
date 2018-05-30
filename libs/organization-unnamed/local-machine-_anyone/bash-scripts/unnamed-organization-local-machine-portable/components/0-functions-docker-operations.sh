function __unnamed_organization_print_docker_operation_example_on_error_ {
	local argumentsAreCorrect=0

	if [ ! -z "$1" ]; then
		if [ ! -z "$2" ]; then
			echo
			if [ "$2" = "only-single-argument-valid" ]; then
				argumentsAreCorrect=1

				if [ "$copywritingLanguage" = "zh_CN" ]; then
					echo -e "${dimmedRed}缺少必要参数。"
				fi
				if [ "$copywritingLanguage" = "en_US" ]; then
					echo -e "${dimmedRed}Too few arguments provided."
				fi

			elif [ "$2" = "username-needed" ]; then
				argumentsAreCorrect=1

				if [ "$copywritingLanguage" = "zh_CN" ]; then
				echo -e "${dimmedRed}请指明远程主机的用户名。"
				fi

				if [ "$copywritingLanguage" = "en_US" ]; then
				echo -e "${dimmedRed}Remote user name needed for ssh connection."
				fi
			fi
		fi
	fi

	if [ $argumentsAreCorrect = 1 ]; then
		echo

		if [ "$copywritingLanguage" = "zh_CN" ]; then
			echo -e "${noColor}请依次给出${brown}docker的IP末项${noColor}，和${blue}远程主机的用户名${noColor}。"
		fi
		if [ "$copywritingLanguage" = "en_US" ]; then
			echo -e -n "${noColor}Please provide both ${brown}docker ip suffix"
			echo -e -n "${noColor} and ${blue}remote user name${noColor},"
			echo -e    "${noColor} in the mentioned order.${noColor}"
		fi

		echo

		if [ "$copywritingLanguage" = "zh_CN" ]; then
			echo -e "${noColor}范例"
		fi
		if [ "$copywritingLanguage" = "en_US" ]; then
			echo -e "${noColor}Example"
		fi

		echo -e "    ${green}$1 ${brown}66 ${blue}${myLDPAUserName}${noColor}"
		echo -e "${noColor}"
	fi

	echo
}





function __unnamed_organization_ssh_keygen_for_a_docker_core_ {
	echo
	__ssh_keygen_ "${remoteUserName}@${dockerIPPrefix}${remoteIPSuffix}"
}





function __unnamed_organization_scopy_bash_scripts_to_docker_core_ {
	echo

	if [ "$copywritingLanguage" = "zh_CN" ]; then
	echo -e "${green}将 ${blue}.bashrc${green} 和 ${blue}$wlcBashScriptsFolderName/*${green}复制到 docker[${brown}${dockerIPPrefix}$remoteIPSuffix${green}] 中……${noColor}"
	fi
	if [ "$copywritingLanguage" = "en_US" ]; then
	echo -e "${green}copying ${blue}.bash_profile${green} and ${blue}$wlcBashScriptsFolderName/*${green} to docker[${brown}${dockerIPPrefix}$remoteIPSuffix${green}]...${noColor}"
	fi

	scp -rq \
		"${__wlcLocalMachineFolderOfBashScriptsForDockers}/unnamed-organization-docker-non-root-user/.bashrc" \
		"${__wlcLocalMachineFolderOfBashScriptsForDockers}/unnamed-organization-docker-non-root-user/.bash_profile" \
		"${__wlcLocalMachineFolderOfBashScriptsForDockers}/unnamed-organization-docker-non-root-user/$wlcBashScriptsFolderName" \
		"${remoteUserName}@${dockerIPPrefix}${remoteIPSuffix}:~"
}



function __unnamed_organization_ssh_pick_key_files_for_a_docker_ {
    local remoteIPSuffix=$1
    local remoteUserName=$2
    local foundKey="${sshBackupFolder}/${remoteUserName}_at_${dockerIPPrefix}${remoteIPSuffix}.sshkey"

	__ssh_pick_one_files_under_backup_folder_to_use_ $foundKey
}

function __unnamed_organization_ssh_connect_to_docker_core_ {
	echo

	__unnamed_organization_ssh_pick_key_files_for_a_docker_ $remoteIPSuffix $remoteUserName

	# echo -e "${blue}ssh${green} connecting to docker[${brown}${dockerIPPrefix}$remoteIPSuffix${green}]...${noColor}"
	# ssh "${remoteUserName}@${dockerIPPrefix}${remoteIPSuffix}" -t "bash -l";

	echo -e "${blue}ssh${green} "${pink}${remoteUserName}@${dockerIPPrefix}${remoteIPSuffix}" -t \"bash -l\"${noColor}..."
	                ssh                "${remoteUserName}@${dockerIPPrefix}${remoteIPSuffix}" -t  "bash -l"
}





function __unnamed_organization_init_docker_core_ {
    local remoteIPSuffix=$1
    local remoteUserName=$2

	if [ ! -d ~/.ssh/backup ]; then
		mkdir ~/.ssh/backup
	fi;

	__unnamed_organization_ssh_keygen_for_a_docker_core_         $remoteIPSuffix $remoteUserName
	__unnamed_organization_scopy_bash_scripts_to_docker_core_    $remoteIPSuffix $remoteUserName
	__unnamed_organization_ssh_connect_to_docker_core_           $remoteIPSuffix $remoteUserName
}





function __unnamed_organization_ssh_keygen_for_a_docker_ {
	source "${wlcBashScriptsFolderPath}/unnamed-organization-local-machine-portable/define-variables-dynamic.sh"


	local remoteIPSuffix=$1
	[ ${remoteIPSuffix:=$defaultDockerIPSuffix} ]

	if [ -z "$remoteIPSuffix" ]; then
		__unnamed_organization_print_docker_operation_example_on_error_ "sshkeygen-docker" "only-single-argument-valid"
		return
	fi


	local remoteUserName=$2
	[ ${remoteUserName:=$myLDPAUserName} ]

	if [ -z "$remoteUserName" ]; then
		__unnamed_organization_print_docker_operation_example_on_error_ "sshkeygen-docker" "username-needed"
		return
	fi


	__unnamed_organization_ssh_keygen_for_a_docker_core_ $remoteIPSuffix $remoteUserName
}



function __unnamed_organization_ssh_connect_to_docker_ {
	source "${wlcBashScriptsFolderPath}/unnamed-organization-local-machine-portable/define-variables-dynamic.sh"


	local remoteIPSuffix=$1
	[ ${remoteIPSuffix:=$defaultDockerIPSuffix} ]

	if [ -z "$remoteIPSuffix" ]; then
		__unnamed_organization_print_docker_operation_example_on_error_ "ssh-docker" "only-single-argument-valid"
		return
	fi


	local remoteUserName=$2
	[ ${remoteUserName:=$myLDPAUserName} ]

	if [ -z "$remoteUserName" ]; then
		__unnamed_organization_print_docker_operation_example_on_error_ "ssh-docker" "username-needed"
		return
	fi


	__unnamed_organization_ssh_connect_to_docker_core_ $remoteIPSuffix $remoteUserName
}



function __unnamed_organization_init_docker_ {
	source "${wlcBashScriptsFolderPath}/unnamed-organization-local-machine-portable/define-variables-dynamic.sh"


	local remoteIPSuffix=$1
	[ ${remoteIPSuffix:=$defaultDockerIPSuffix} ]

	if [ -z "$remoteIPSuffix" ]; then
		__unnamed_organization_print_docker_operation_example_on_error_ "init-docker" "only-single-argument-valid"
		return
	fi


	local remoteUserName=$2
	[ ${remoteUserName:=$myLDPAUserName} ]

	if [ -z "$remoteUserName" ]; then
		__unnamed_organization_print_docker_operation_example_on_error_ "init-docker" "username-needed"
		return
	fi


	__unnamed_organization_init_docker_core_ $remoteIPSuffix $remoteUserName
}

