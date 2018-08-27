
function __unnamed_organization_ssh_keygen_for_a_docker_ {
	local remoteUserName=$1
	local remoteIPAddress=$2

	if [ -z "$remoteIPAddress" ]; then
		__unnamed_organization_print_docker_operation_example_on_error_ "sshkeygen-docker" "only-single-argument-valid"
		return
	fi

	if [ -z "$remoteUserName" ]; then
		__unnamed_organization_print_docker_operation_example_on_error_ "sshkeygen-docker" "username-needed"
		return
	fi

	echo
	__ssh_keygen_ "${remoteUserName}@${remoteIPAddress}"
}






function __unnamed_organization_ssh_pick_key_file_for_a_docker_ {
    local remoteUserName=$1
    local remoteIPAddress=$2

    local foundKey="${sshBackupFolder}/${remoteUserName}_at_${remoteIPAddress}.sshkey"

	echo
	__ssh_pick_one_files_under_backup_folder_to_use_ $foundKey
}







function __unnamed_organization_ssh_connect_to_docker_ {
	local remoteUserName=$1
	local remoteIPAddress=$2

	__unnamed_organization_ssh_pick_key_file_for_a_docker_ $remoteUserName $remoteIPAddress

	colorful -- 'ssh '              textGreen
	colorful -- "$remoteUserName"   textBlue
	colorful -- @                   textGray
	colorful -- "$remoteIPAddress"  textMagenta
	colorful -- ' -'                textGray
	colorful -- 't'                 textYellow
	colorful -- ' "'                textGray
	colorful -- "bash -l"           textGreen
	colorful -- '"...'              textGray

	ssh "${remoteUserName}@${remoteIPAddress}" -t "bash -l"
}



function __unnamed_organization_find_dist_folder_full_path_via_source_folder_name_ {
	local sourceFolderName=$1
	local foundFolderFullPath=`find "$wlcBashScriptsFolderPath" -name "*-$sourceFolderName" -type d`
	echo "$foundFolderFullPath"
}




function __unnamed_organization_print_docker_operation_example_on_error_ {
	local involvedCommand=$1
	local errorTypeString=$2

	local argumentsIncorrect=0

	if [ ! -z "$involvedCommand" ]; then
		if [ ! -z "$errorTypeString" ]; then
			echo
			if [ "$errorTypeString" = "only-single-argument-valid" ]; then
				argumentsIncorrect=1

				if [ "$copywritingLanguage" = "zh_CN" ]; then
					echo -e "${dimmedRed}缺少必要参数。"
				fi
				if [ "$copywritingLanguage" = "en_US" ]; then
					echo -e "${dimmedRed}Too few arguments provided."
				fi

			elif [ "$errorTypeString" = "username-needed" ]; then
				argumentsIncorrect=1

				if [ "$copywritingLanguage" = "zh_CN" ]; then
				echo -e "${dimmedRed}请指明远程主机的【用户名】。"
				fi

				if [ "$copywritingLanguage" = "en_US" ]; then
				echo -e "${dimmedRed}Remote user name needed for ssh connection."
				fi
			fi
		fi
	fi

	if [ $argumentsIncorrect = 1 ]; then
		echo

		if [ "$copywritingLanguage" = "zh_CN" ]; then
			echo -e "${noColor}请依次给出${brown}远程主机的用户名${noColor}，和${blue}docker的IP地址${noColor}。"
		fi
		if [ "$copywritingLanguage" = "en_US" ]; then
			echo -e -n "${noColor}Please provide both ${brown}remote user name"
			echo -e -n "${noColor} and ${blue}docker ip address${noColor},"
			echo -e    "${noColor} in the mentioned order.${noColor}"
		fi

		echo

		if [ "$copywritingLanguage" = "zh_CN" ]; then
			echo -e "${noColor}范例"
		fi
		if [ "$copywritingLanguage" = "en_US" ]; then
			echo -e "${noColor}Example"
		fi

		echo -e "    ${green}${involvedCommand} ${brown}${myCompanyLDPAUserName} ${blue}67${noColor}"
		echo -e "${noColor}"
	fi

	echo
}
