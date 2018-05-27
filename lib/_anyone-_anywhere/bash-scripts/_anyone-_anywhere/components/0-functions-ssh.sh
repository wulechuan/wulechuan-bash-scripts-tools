__exampleUserName__=wulechuan
__exampleDomainName__=live.com

function __ssh_keygen_ {
    if [ -z "$1" ]; then
        if [ "$copywritingLanguage" = "zh_CN" ]; then
            echo -e $darkline50
            echo -e `colorful "欲创建一个ssh密钥，请指明完整的用户ID。用户ID应依次包含用户名和域名两部分，以@符号连接。" textRed`
            echo -e $darkline50
            echo -en "范例："
        fi

        if [ "$copywritingLanguage" = "en_US" ]; then
            echo -e $darkline50
            echo -e `colorful "Please provide an ID." textRed`
            echo -e $darkline50
            echo -en "Example: "
        fi

        echo -en `colorful sshkg textGreen`' '
        echo -en `colorful \" textBrightBlack`
        echo -en `colorful "${__exampleUserName__}@${__exampleDomainName__}" textCyan`
        echo -e  `colorful \" textBrightBlack`
        echo -e $darkline50

        return
    fi

    local newIdHumanReadableName=$2

    echo
    if [ "$copywritingLanguage" = "zh_CN" ]; then
        echo -e "针对ID"`colorful "${newIdHumanReadableName}($1)" textMagenta`"："
    fi
    if [ "$copywritingLanguage" = "en_US" ]; then
        echo -e "For "`colorful "${newIdHumanReadableName}($1)" textMagenta`": "
    fi

    local newId=$1
    local newKeyFile=${sshBackupFolder}/$newId.sshkey

    newKeyFile=${newKeyFile//@/_at_}

    if [ -f "$newKeyFile" ]; then
        yes "n" | ssh-keygen -q -f $newKeyFile -C $newId
    else
        ssh-keygen -q -f $newKeyFile -C $newId
    fi

    # __ssh_create_config_entries_for_all_files_under_backup_folder_

    __ssh_copy_id_ $newKeyFile $newId

    echo
    echo -e $darkline60
    if [ "$copywritingLanguage" = "zh_CN" ]; then
        echo -en `colorful '人类易读版本为：“'                textBlue`
        echo -en `colorful "${newIdHumanReadableName:=$1}" textMagenta`
        echo -e  `colorful '”'                             textBlue`
    fi
    if [ "$copywritingLanguage" = "en_US" ]; then
        echo -en `colorful 'Human readable name will be "' textBlue`
        echo -en `colorful "${newIdHumanReadableName:=$1}" textMagenta`
        echo -e  `colorful '".'                            textBlue`
    fi
    echo -e $darkline60
    echo
}

# function __ssh_create_config_entries_for_all_files_under_backup_folder_ {
    # local allFoundKeyFiles=($(ls ${sshBackupFolder}/*.sshkey))
    # local sshConfigFile=${sshFolder}/config

    # local messageColor=${blue}
    # echo
    # echo -e "${messageColor}Creating ${pink}ssh config entry${messageColor} for "
    # echo -e "each and every ssh keys under ${brown}backup${messageColor} folder "
    # echo -e "into ${brown}${sshConfigFile}${messageColor}...${noColor}"
    # # echo


    # local sshConfigEntries=()
    # local sshConfigEntry=
    # local index=0
    # local keyFile=
    # local pubKeyFile=
    # local keyName=
    # local keyDomainName=
    # local keyDomainNameLastSegment=
    # local keyHumanReadableName=
    # local remoteUserName=${myUnnamedOrgLDPAUserName}

    # local REPureDigits='^[0-9]+$'

    # for keyFile in ${allFoundKeyFiles[@]}; do

    #     keyName=$keyFile
    #     keyName=${keyName//_at_/@}
    #     keyName=${keyName/.sshkey/}
    #     keyName=${keyName/$sshBackupFolder\/}

    #     keyFile=${keyFile//@/\\@}

    #     # Git Bash doesn't support 'rev'
    #     # keyDomainName=$(echo "$keyName" | rev | cut -d'@' -f1 | rev)
    #     # keyDomainNameLastSegment=$(echo "$keyDomainName" | rev | cut -d'.' -f1 | rev)

    #     keyDomainName=${keyName##*@}
    #     keyDomainNameLastSegment=${keyDomainName##*.}
    #     # echo "domain" $keyDomainName
    #     # echo "last" $keyDomainNameLastSegment

    #     if [[ $keyDomainNameLastSegment =~ $REPureDigits ]]; then
    #         keyHumanReadableName="unnamedOrg-docker-$keyDomainNameLastSegment"
    #     else
    #         keyHumanReadableName=$keyDomainName
    #     fi

    #     echo -e "${noColor}  Adding ${pink}${keyHumanReadableName}${dark}(${noColor}${green}${keyName}${dark})${noColor}..."

    #     sshConfigEntry=$'\r'
    #     sshConfigEntry=${sshConfigEntry}'Host '${keyHumanReadableName}
    #     # sshConfigEntry=${sshConfigEntry}'Host '${keyName}
    #     sshConfigEntry=${sshConfigEntry}$'\r'

    #     sshConfigEntry=${sshConfigEntry}' HostName '${keyName}
    #     sshConfigEntry=${sshConfigEntry}$'\r'

    #     sshConfigEntry=${sshConfigEntry}' IdentityFile '${keyFile}
    #     sshConfigEntry=${sshConfigEntry}$'\r'


    #     sshConfigEntry=${sshConfigEntry}" User ${remoteUserName}"
    #     sshConfigEntry=${sshConfigEntry}$'\r'

    #     sshConfigEntries[index]=$sshConfigEntry

    #     let index+=1
    # done

    # local _s='s'
    # if [ ${#sshConfigEntries[@]} = 1 ]; then
    #     _s=''
    # fi

    # echo -e "${pink}${#sshConfigEntries[@]}${blue} key${_s}${blue}(${dark}.sshkey file${_s}${noColor}${blue}) were found.${noColor}"
    # echo ${sshConfigEntries[@]} > ${sshConfigFile}
    # echo
# }




function __ssh_copy_id_ {
    echo

    if [ "$copywritingLanguage" = "zh_CN" ]; then
        echo -e `colorful '尝试将ssh公钥复制到远程主机……' textCyan`
    fi
    if [ "$copywritingLanguage" = "en_US" ]; then
        echo -e `colorful 'Try copying ssh pub key to remote...' textCyan`
    fi

    local example1=`colorful "~/.ssh/backup/${__exampleUserName__}@${__exampleDomainName__}.sshky" textCyan`
    local example2=`colorful "~/.ssh/id_rsa"                                                       textCyan`
    local exampleMessage

    if [ -z "$1" ]; then
        if [ "$copywritingLanguage" = "zh_CN" ]; then
            exampleMessage=`colorful '请指明ssh密钥文件。' textRed`

            exampleMessage=$exampleMessage'\n  范例1：'
            exampleMessage=$exampleMessage`colorful \' textBrightBlack`
            exampleMessage=$exampleMessage${example1}
            exampleMessage=$exampleMessage`colorful \' textBrightBlack`

            exampleMessage=$exampleMessage'\n  范例2：'
            exampleMessage=$exampleMessage`colorful \' textBrightBlack`
            exampleMessage=$exampleMessage${example2}
            exampleMessage=$exampleMessage`colorful \' textBrightBlack`
        fi
        if [ "$copywritingLanguage" = "en_US" ]; then
            exampleMessage=`colorful 'Please provide an ssh key file.' textRed`

            exampleMessage=$exampleMessage'\n  Example1: '
            exampleMessage=$exampleMessage`colorful \' textBrightBlack`
            exampleMessage=$exampleMessage${example1}
            exampleMessage=$exampleMessage`colorful \' textBrightBlack`

            exampleMessage=$exampleMessage'\n  Example2: '
            exampleMessage=$exampleMessage`colorful \' textBrightBlack`
            exampleMessage=$exampleMessage${example2}
            exampleMessage=$exampleMessage`colorful \' textBrightBlack`
        fi

        echo -e $exampleMessage

        return
    fi

    local exampleID=`colorful "${__exampleUserName__}@${__exampleDomainName__}" textBlue`

    if [ -z "$2" ]; then
       if [ "$copywritingLanguage" = "zh_CN" ]; then
            echo -e `colorful '请指明完整的用户ID。用户ID应依次包含用户名和域名两部分，以@符号连接。' textRed`
            echo -e '  范例：'`colorful \' textBrightBlack`$exampleID`colorful \' textBrightBlack`
        fi

        if [ "$copywritingLanguage" = "en_US" ]; then
            echo -e `colorful 'Please provide an ID.' textRed`
            echo -e '  Example: '`colorful \' textBrightBlack`$exampleID`colorful \' textBrightBlack`
        fi
        return
    fi

    local sshKeyFile=$1
    local sshId=$2
    local messageColor=${blue}

    if [ "$copywritingLanguage" = "zh_CN" ]; then
        echo -e "${messageColor}将ID${dark}【${noColor}${brown}${sshId}${dark}】${noColor}${messageColor}对应的${pink}ssh公钥${messageColor}复制到远程主机……${noColor}"
    fi
    if [ "$copywritingLanguage" = "en_US" ]; then
        echo -e "${messageColor}Copying ${pink}ssh pub key${messageColor} of id ${dark}'${noColor}${brown}${sshId}${dark}'${noColor}${messageColor} to remote...${noColor}"
    fi

    echo

    ssh-copy-id -i $sshKeyFile $sshId
}



function __ssh_pick_one_files_under_backup_folder_to_use_ {
    local keyFile=$1
    local pubKeyFile="${keyFile}.pub"
    local bothKeysFound=1

    if [ -f "$keyFile" ]; then
        cat ${keyFile}    > ~/.ssh/id_rsa
    else
        bothKeysFound=0
    fi

    if [ -f "$pubKeyFile" ]; then
        cat ${pubKeyFile} > ~/.ssh/id_rsa.pub
    else
        bothKeysFound=0
    fi


    local messageColor=''

    if [ $bothKeysFound = 1 ]; then
        messageColor=${blue}
        echo
        if [ "$copywritingLanguage" = "zh_CN" ]; then
            echo -e "${messageColor}位于${brown}backup${messageColor}文件夹内的ssh密钥文件"
            echo -e "${messageColor}已被复制到\"${pink}~/.ssh${messageColor}\"文件夹下，并更名为${pink}id_rsa${messageColor}。${noColor}"
        fi
        if [ "$copywritingLanguage" = "en_US" ]; then
            echo -e "${messageColor}The ssh keys under ${brown}backup${messageColor} folder have been"
            echo -e "${messageColor} copied into \"${pink}~/.ssh${messageColor}\" folder.${noColor}"
        fi

        chmod 700 ~/.ssh/id_rsa
        chmod 700 ~/.ssh/id_rsa.pub

        if [ "$copywritingLanguage" = "zh_CN" ]; then
            echo -e "${pink}id_rsa${messageColor}和${pink}id_rsa.pub${messageColor}两个文件的权限模式均被设为${green}700${messageColor}。${noColor}"
        fi
        if [ "$copywritingLanguage" = "en_US" ]; then
            echo -e "${messageColor} Mode of both ${pink}id_rsa${messageColor} and ${pink}id_rsa.pub${messageColor} has been set to ${green}700${messageColor}.${noColor}"
        fi
    else
        if [ "$copywritingLanguage" = "zh_CN" ]; then
            echo -e "${dimmedRed}未找到以下密钥文件：${noColor}"
        fi
        if [ "$copywritingLanguage" = "en_US" ]; then
            echo -e "${dimmedRed}Key or pub key file missing:${noColor}"
        fi
        echo -e "${green}    ${keyFile}"
        echo -e "${noColor}"
    fi

    echo
}
