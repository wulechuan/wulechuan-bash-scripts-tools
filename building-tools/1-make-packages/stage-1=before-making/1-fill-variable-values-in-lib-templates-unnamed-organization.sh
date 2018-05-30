function ___fill_variable_values_in_lib_templates_for_organization_senarios {
    local copywritingLanguage="zh_CN"

	if [ -z "$1" ]; then
        echo

		if [ "$copywritingLanguage" = "zh_CN" ]; then
			echo -e     `colorful "必须在第一个参数给出用于 Docker 的【非 root】用户名。"           textRed`
			echo -e     `colorful "第二个参数可以省略。如果给出，则作为 Docker 的 【IP 地址前缀】。"  textYellow`
            echo
			echo -e "  "`colorful "示例："           textBlue`
		fi
		if [ "$copywritingLanguage" = "en_US" ]; then
			echo -e     `colorful "You MUST provide the user name for the non-root user of the docker, in the first argument."  textRed`
			echo -e     `colorful "The second argument is optional, which means the IP prefix of the dockers."                  textYellow`
			echo
            echo -e "  "`colorful "Examples:"       textBlue`
		fi

        echo -en "    "`colorful "./install-org"    textBlue`
        echo -e        `colorful "  duanduan"       textGreen`

        echo -en "    "`colorful "./install-org"    textBlue`
        echo -en       `colorful "  duanduan"       textGreen`
        echo -e        `colorful "  172.16.13."     textCyan`

        echo

		# return 1
        exit 1
	fi


    local _myLDPAUserName=$1
    local _dockerIpPrefix="172.16.13."

	if [ -z "$2" ]; then
		if [ "$copywritingLanguage" = "zh_CN" ]; then
			echo -e  `colorful "你未给出 Docker 的 【IP 地址前缀】。"  textBlue`
			echo -en `colorful "将使用默认值："                      textBlue`
			echo -e  `colorful "${_dockerIpPrefix}"                textGreen`
            echo -n  `colorful "现在可按任意键继续 "                  textYellow`
		fi
		if [ "$copywritingLanguage" = "en_US" ]; then
			echo -e  `colorful "You omitted the second argument."      textBlue`
			echo -en `colorful "Thus the default IP Prefix is used: "  textBlue`
			echo -e  `colorful "${_dockerIpPrefix}"                    textGreen`
            echo -n  `colorful "Press any key to continue "            textYellow`
		fi

        read -n 1 -t 5

        echo
    else
        _dockerIpPrefix=$2
    fi


    local libPath="$___here/$___wlcBashScriptsSourceLibFolderName"
    local templatesNearestParentPath="$libPath/organization-unnamed"

    local currentSenarioDistPath
    local currentFileWithoutExt


    currentSenarioDistPath="$templatesNearestParentPath/_anyone-_anywhere/$wlcBashScriptsRunningFolderName/unnamed-organization-_anyone-_anywhere"

    currentFileWithoutExt="${currentSenarioDistPath}/define-variables"
    cp "${currentFileWithoutExt}.template" "${currentFileWithoutExt}.filled-template"
    sed -i "s/dummyValueMyLDPAUserName/$_myLDPAUserName/g"  "${currentFileWithoutExt}.filled-template"
    sed -i "s/dummyValueDockerIpPrefix/$_dockerIpPrefix/g"  "${currentFileWithoutExt}.filled-template"



    currentSenarioDistPath="$templatesNearestParentPath/local-machine-_anyone/$wlcBashScriptsRunningFolderName/unnamed-organization-local-machine-portable"

    currentFileWithoutExt="${currentSenarioDistPath}/define-variables-dynamic"
    cp "${currentFileWithoutExt}.template"                  "${currentFileWithoutExt}.filled-template"
    sed -i "s/dummyValueMyLDPAUserName/$_myLDPAUserName/g"  "${currentFileWithoutExt}.filled-template"

    currentFileWithoutExt="${currentSenarioDistPath}/define-variables"
    cp "${currentFileWithoutExt}.template"                                                                                 "${currentFileWithoutExt}.filled-template"
    sed -i "s/dummyValueLocalMachineFolderNameOfBashScriptsForDockers/$wlcLocalMachineFolderNameOfBashScriptsForDockers/g" "${currentFileWithoutExt}.filled-template"
}

# $0 是初始入口脚本的路径。
# 不可以执行 shift 命令。否则会影响后续其他脚本的运行。
# echo dollar0=$0
# echo
# echo dollar1=$1
# echo
# echo dollar2=$2
# echo

___fill_variable_values_in_lib_templates_for_organization_senarios  $1  $2