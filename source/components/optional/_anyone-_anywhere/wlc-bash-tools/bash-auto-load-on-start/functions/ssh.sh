__exampleUserName__=wulechuan
__exampleDomainName__=live.com

if [ ! -d ~/.ssh/ ]; then
    mkdir ~/.ssh/
fi

if [ ! -d ~/.ssh/backup/ ]; then
    mkdir ~/.ssh/backup/
fi

function __ssh_keygen_ {
    if [ -z "$1" ]; then
        if [ "$copywritingLanguage" = "zh_CN" ]; then
            echo -e $darkline50
            colorful -n "欲创建一个ssh密钥，请指明完整的用户ID。用户ID应依次包含用户名和域名两部分，以@符号连接。" textRed
            echo -e $darkline50
            echo -en "范例："
        else
            echo -e $darkline50
            colorful -n "Please provide an ID." textRed
            echo -e $darkline50
            echo -en "Example: "
        fi

        colorful -- 'sshkg '                                           textGreen
        colorful -- '"'                                                textBrightBlack
        colorful -- "${__exampleUserName__}@${__exampleDomainName__}"  textCyan
        colorful -n '"'                                                textBrightBlack

        echo -e $darkline50

        return
    fi

    local newId=$1
    local newIdHumanReadableName=$2

    echo
    if [ "$copywritingLanguage" = "zh_CN" ]; then
        echo -n "针对ID"
        colorful -- "${newIdHumanReadableName}($newId)" textMagenta
        echo "："
    fi

    if [ "$copywritingLanguage" = "en_US" ]; then
        echo -n "For "
        colorful -- "${newIdHumanReadableName}($newId)" textMagenta
        echo ": "
    fi

    local newKeyFile=${sshBackupFolder}/$newId.sshkey

    newKeyFile=${newKeyFile//@/_at_}

    if [ -f "$newKeyFile" ]; then
        yes "n" | ssh-keygen -q -f $newKeyFile -C $newId
    else
        ssh-keygen -q -f $newKeyFile -C $newId
    fi


    __ssh_copy_id_ $newKeyFile $newId

    echo
    echo -e $darkline60
    if [ "$copywritingLanguage" = "zh_CN" ]; then
        colorful -- '人类易读版本为：“'                 textBlue
        colorful -- "${newIdHumanReadableName:=$1}"  textMagenta
        colorful -n '”'                              textBlue
    else
        colorful -- 'Human readable name will be "'  textBlue
        colorful -- "${newIdHumanReadableName:=$1}"  textMagenta
        colorful -n '".'                             textBlue
    fi
    echo -e $darkline60
    echo
}



function __ssh_copy_id_ {
    echo

    if [ "$copywritingLanguage" = "zh_CN" ]; then
        colorful -n '尝试将ssh公钥复制到远程主机……'            textCyan
    else
        colorful -n 'Try copying ssh pub key to remote...' textCyan
    fi

    local example1=`colorful -n "~/.ssh/backup/${__exampleUserName__}@${__exampleDomainName__}.sshky" textCyan`
    local example2=`colorful -n "~/.ssh/id_rsa"                                                       textCyan`
    local exampleMessage

    if [ -z "$1" ]; then
        if [ "$copywritingLanguage" = "zh_CN" ]; then
            exampleMessage=`colorful -n '请指明ssh密钥文件。' textRed`

            exampleMessage=$exampleMessage'  范例1：'
            exampleMessage=$exampleMessage`colorful -- "'" textBrightBlack`
            exampleMessage=$exampleMessage${example1}
            exampleMessage=$exampleMessage`colorful -- "'" textBrightBlack`

            exampleMessage=$exampleMessage'\n  范例2：'
            exampleMessage=$exampleMessage`colorful -- "'" textBrightBlack`
            exampleMessage=$exampleMessage${example2}
            exampleMessage=$exampleMessage`colorful -- "'" textBrightBlack`
        else
            exampleMessage=`colorful -n 'Please provide an ssh key file.' textRed`

            exampleMessage=$exampleMessage'  Example1: '
            exampleMessage=$exampleMessage`colorful -- "'" textBrightBlack`
            exampleMessage=$exampleMessage${example1}
            exampleMessage=$exampleMessage`colorful -- "'" textBrightBlack`

            exampleMessage=$exampleMessage'\n  Example2: '
            exampleMessage=$exampleMessage`colorful -- "'" textBrightBlack`
            exampleMessage=$exampleMessage${example2}
            exampleMessage=$exampleMessage`colorful -- "'" textBrightBlack`
        fi

        echo -e $exampleMessage

        return
    fi

    local exampleID=`colorful "${__exampleUserName__}@${__exampleDomainName__}" textBlue`

    if [ -z "$2" ]; then
       if [ "$copywritingLanguage" = "zh_CN" ]; then
            colorful -n '请指明完整的用户ID。用户ID应依次包含用户名和域名两部分，以@符号连接。' textRed
            echo    '  范例：'
            colorful -- \' textBrightBlack
            echo -n $exampleID
            colorful -n \' textBrightBlack
        else
            colorful -n 'Please provide an ID.' textRed
            echo    '  Example: '
            colorful -- \' textBrightBlack
            echo -n $exampleID
            colorful -n \' textBrightBlack
        fi
        return
    fi

    local sshKeyFile=$1
    local sshId=$2
    local messageColor=${blue}

    if [ "$copywritingLanguage" = "zh_CN" ]; then
        echo -e "${messageColor}将ID${dark}【${noColor}${brown}${sshId}${dark}】${noColor}${messageColor}对应的${pink}ssh公钥${messageColor}复制到远程主机……${noColor}"
    else
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
        else
            echo -e "${messageColor}The ssh keys under ${brown}backup${messageColor} folder have been"
            echo -e "${messageColor} copied into \"${pink}~/.ssh${messageColor}\" folder.${noColor}"
        fi

        chmod 700 ~/.ssh/id_rsa
        chmod 700 ~/.ssh/id_rsa.pub

        if [ "$copywritingLanguage" = "zh_CN" ]; then
            echo -e "${pink}id_rsa${messageColor}和${pink}id_rsa.pub${messageColor}两个文件的权限模式均被设为${green}700${messageColor}。${noColor}"
        else
            echo -e "${messageColor} Mode of both ${pink}id_rsa${messageColor} and ${pink}id_rsa.pub${messageColor} has been set to ${green}700${messageColor}.${noColor}"
        fi
    else
        if [ "$copywritingLanguage" = "zh_CN" ]; then
            echo -e "${dimmedRed}未找到以下密钥文件：${noColor}"
        else
            echo -e "${dimmedRed}Key or pub key file missing:${noColor}"
        fi
        echo -e "${green}    ${keyFile}"
        echo -e "${noColor}"
    fi

    echo
}
