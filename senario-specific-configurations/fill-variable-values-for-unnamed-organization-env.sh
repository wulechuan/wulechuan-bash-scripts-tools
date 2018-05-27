function ___build_variables_from_tempaltes_for_unnamedOrg_env {
    local copywritingLanguage="zh_CN"

	if [ -z "$1" ]; then
        echo

		if [ "$copywritingLanguage" = "zh_CN" ]; then
			echo -e "${red}  必须在第一个参数给出用于 Docker 的【非 root】用户名${noColor}。第二个参数可以省略，它作为 Docker 的 【IP 地址前缀】。"
			echo -e "${light}      例如：${noColor}"
		fi
		if [ "$copywritingLanguage" = "en_US" ]; then
			echo -e "${red}  You MUST provide the user name for the non-root user of the docker, in the first argument. The second argument is optional, which means the IP prefix of the dockers.${noColor}"
			echo -e "${light}      Examples: ${noColor}"
		fi

        echo -e "      ${green}setup-wulechuan-bash-scripts  ${brown}duanduan${noColor}"
        echo -e "      ${green}setup-wulechuan-bash-scripts  ${brown}duanduan${noColor}  ${light}172.16.13.${noColor}"

        echo

		return 1
	fi


    local _myLDPAUserName=$1
    local _dockerIpPrefix="172.16.13."

	if [ -z "$2" ]; then
		if [ "$copywritingLanguage" = "zh_CN" ]; then
			echo -e "${brown}你未给出 Docker 的 【IP 地址前缀】。将使用默认值：\"${green}${_dockerIpPrefix}\"${noColor}"
            echo -n "现在可按任意键继续 "
		fi
		if [ "$copywritingLanguage" = "en_US" ]; then
			echo -e "${borwn}Default IP Prefix is used: ${green}${_dockerIpPrefix}${noColor}"
            echo -n "Press any key to continue "
		fi

        read

        echo
    else
        _dockerIpPrefix=$2
    fi


    local libPath="$___here/lib"
    local templatesNearestParentPath="$libPath/organization-unnamed"

    local currentSenarioDistPath
    local currentFileWithoutExt


    currentSenarioDistPath="$templatesNearestParentPath/_anyone-_anywhere/$___wlcBashScriptsFolderName/unnamedOrg-_anyone-_anywhere"

    currentFileWithoutExt="${currentSenarioDistPath}/define-variables"
    cp "${currentFileWithoutExt}.template" "${currentFileWithoutExt}.filled-template"
    sed -i "s/dummyValueMyUnnamedOrgLDPAUserName/$_myLDPAUserName/g"  "${currentFileWithoutExt}.filled-template"
    sed -i "s/dummyValueDockerIpPrefix/$_dockerIpPrefix/g"       "${currentFileWithoutExt}.filled-template"



    currentSenarioDistPath="$templatesNearestParentPath/local-machine-_anyone/$___wlcBashScriptsFolderName/unnamedOrg-local-machine-portable"

    currentFileWithoutExt="${currentSenarioDistPath}/define-variables-dynamic"
    cp "${currentFileWithoutExt}.template"                       "${currentFileWithoutExt}.filled-template"
    sed -i "s/dummyValueMyUnnamedOrgLDPAUserName/$_myLDPAUserName/g"  "${currentFileWithoutExt}.filled-template"
}
