function ___fill_variable_values_in_lib_templates_for_unnamed_organization_senarios {
    local logString


	if [ -z "$1" ]; then
        logString='\n'

		if [ "$___copywritingLanguageDuringBuilding" = "en_US" ]; then
            append-colorful-string-to logString -n 'You MUST provide the user name for the non-root user of the docker, in the first argument.'  textRed
            append-colorful-string-to logString -n 'The second argument is optional, which means the IP prefix of the dockers.'                  textYellow
            logString=$logString'\n'
            append-colorful-string-to logString -n 'Examples:'  textGray
        else
            append-colorful-string-to logString -n '必须在第一个参数给出用于 Docker 的【非 root】用户名。'  textRed
            append-colorful-string-to logString -n '第二个参数可以省略。如果给出，则作为 Docker 的 【IP 地址前缀】。'                  textYellow
            logString=$logString'\n'
            append-colorful-string-to logString -n '示例：'  textGray
		fi

        append-colorful-string-to logString -- '    ./install-org'    textBlue
        append-colorful-string-to logString -n '  shirly.hu'          textGreen

        append-colorful-string-to logString -- '    ./install-org'    textBlue
        append-colorful-string-to logString -- '  shirly.hu'          textGreen
        append-colorful-string-to logString -n '  172.16.13.'         textCyan

        echo -e "$logString"

        exit 1
	fi


    local _myLDPAUserName=$1
    local _dockerIpPrefix="172.16.13."

	if [ -z "$2" ]; then

		if [ "$___copywritingLanguageDuringBuilding" = "zh_CN" ]; then
            logString=''
        	append-colorful-string-to logString -n "你未给出 Docker 的【IP 地址前缀】。" textBlue
        	append-colorful-string-to logString -- "将使用默认值："                    textBlue
        	append-colorful-string-to logString -- "${_dockerIpPrefix}"              textGreen
        	append-colorful-string-to logString -- "现在可按任意键继续 "                textYellow
            echo -e "$logString"
		fi

		if [ "$___copywritingLanguageDuringBuilding" = "en_US" ]; then
            logString=''
        	append-colorful-string-to logString -n "You omitted the second argument."      textBlue
        	append-colorful-string-to logString -- "Thus the default IP prefix is used: "  textBlue
        	append-colorful-string-to logString -- "${_dockerIpPrefix}"                    textGreen
        	append-colorful-string-to logString -- "Press any key to continue "            textYellow
            echo -e "$logString"
		fi

        read -s -n 1 -t 5

        echo
    else
        _dockerIpPrefix=$2
    fi

    if [ "$___copywritingLanguageDuringBuilding" = "zh_CN" ]; then
        logString=''
        append-colorful-string-to logString -- "             LDPA 用户名："  textBlue
        append-colorful-string-to logString -n "${_myLDPAUserName}"         textGreen
        append-colorful-string-to logString -- "Docker 的【IP 地址前缀】："    textBlue
        append-colorful-string-to logString -n "${_dockerIpPrefix}"         textGreen
        append-colorful-string-to logString -- "现在可按任意键继续 "           textYellow
        echo -e "$logString"
    fi

    if [ "$___copywritingLanguageDuringBuilding" = "en_US" ]; then
        logString=''
        append-colorful-string-to logString -- "  LDPA user name: "          textBlue
        append-colorful-string-to logString -n "${_myLDPAUserName}"          textGreen
        append-colorful-string-to logString -- "Docker IP prefix: "          textBlue
        append-colorful-string-to logString -n "${_dockerIpPrefix}"          textGreen
        append-colorful-string-to logString -- "Press any key to continue "  textYellow
        echo -e "$logString"
    fi

    read -s -n 1 -t 3

    local libPath="$___here/$___wlcBashScriptsSourceLibFolderName"
    local templatesNearestParentPath="$libPath/organization/unnamed"

    local currentSenarioDistPath
    local currentFileWithoutExt


    currentSenarioDistPath="$templatesNearestParentPath/_anyone-_anywhere/$wlcBashScriptsRunningFolderName/_default-module"

    currentFileWithoutExt="${currentSenarioDistPath}/define-variables"
    cp "${currentFileWithoutExt}.template" "${currentFileWithoutExt}.filled-template"
    sed -i "s/dummyValuemyCompanyLDPAUserName/$_myLDPAUserName/g"  "${currentFileWithoutExt}.filled-template"
    sed -i "s/dummyValueDockerIpPrefix/$_dockerIpPrefix/g"       "${currentFileWithoutExt}.filled-template"



    currentSenarioDistPath="$templatesNearestParentPath/local-machine-_anyone/$wlcBashScriptsRunningFolderName/_default-module"

    currentFileWithoutExt="${currentSenarioDistPath}/define-variables-dynamic"
    cp "${currentFileWithoutExt}.template"                       "${currentFileWithoutExt}.filled-template"
    sed -i "s/dummyValuemyCompanyLDPAUserName/$_myLDPAUserName/g"  "${currentFileWithoutExt}.filled-template"

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

___fill_variable_values_in_lib_templates_for_unnamed_organization_senarios  $myCompanyLDPAUserName  '12.34.56.'