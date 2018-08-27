function __unnamed_organization_ssh_connect_to_docker_for_developer_ {
	local sourceFolderName='unnamed-organization-local-machine-_anyone'
	local nameOfFileToLoad='define-variables-dynamic.sh'

	local foundFolder=`__unnamed_organization_find_dist_folder_full_path_via_source_folder_name_ "$sourceFolderName"`

	if [ ! -d "$foundFolder" ]; then
		echo "Failed to find folder \"$sourceFolderName\""
		return 1
	fi

	if [ ! -f "$foundFolder/$nameOfFileToLoad" ]; then
		echo "Failed to find file \"$nameOfFileToLoad\""
		return 2
	fi

	source "$foundFolder/$nameOfFileToLoad"

    local remoteIPSuffix=$1
	[ ${remoteIPSuffix:=$defaultIPSuffixForDockerForDeveloper} ]

	local remoteUserName=$2
	[ ${remoteUserName:=$myCompanyLDPAUserName} ]


	if [ -z "$remoteIPSuffix" ]; then
		__unnamed_organization_print_docker_operation_example_on_error_ "ssh-docker-for-developer" "only-single-argument-valid"
		return
	fi

	if [ -z "$remoteUserName" ]; then
		__unnamed_organization_print_docker_operation_example_on_error_ "ssh-docker-for-developer" "username-needed"
		return
	fi


	local remoteIPAddress=${ipSuffixForDockerForDeveloper}${remoteIPSuffix}


	__unnamed_organization_ssh_connect_to_docker_                        $remoteUserName $remoteIPAddress
}


function __unnamed_organization_scopy_bash_scripts_to_docker_for_developer_ {
    local remoteUserName=$1
    local remoteIPAddress=$2

	echo

	if [ "$copywritingLanguage" = "zh_CN" ]; then
	echo -e "${green}将 ${blue}.bashrc${green} 和 ${blue}$wlcBashScriptsFolderName/*${green}复制到 docker[${brown}$remoteIPAddress${green}] 中……${noColor}"
	fi
	if [ "$copywritingLanguage" = "en_US" ]; then
	echo -e "${green}copying ${blue}.bash_profile${green} and ${blue}$wlcBashScriptsFolderName/*${green} to docker[${brown}$remoteIPAddress${green}]...${noColor}"
	fi

	scp -rq \
		"${__wlcLocalMachineFolderOfBashScriptsForDockers}/unnamed-organization-docker-for-developer-non-root-user/.bashrc" \
		"${__wlcLocalMachineFolderOfBashScriptsForDockers}/unnamed-organization-docker-for-developer-non-root-user/.bash_profile" \
		"${__wlcLocalMachineFolderOfBashScriptsForDockers}/unnamed-organization-docker-for-developer-non-root-user/$wlcBashScriptsFolderName" \
		"${__wlcLocalMachineFolderOfBashScriptsForDockers}/unnamed-organization-docker-for-developer-root-user" \
		"${remoteUserName}@${remoteIPAddress}:~"
}
