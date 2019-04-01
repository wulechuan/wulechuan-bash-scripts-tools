mkdir    -p    ~/.ssh/
mkdir    -p    ~/.ssh/backup/

function wlc--ssh_keygen {
    function print-help {
        echo
        if [ "$copywritingLanguage" = "zh_CN" ]; then
            colorful -n "欲创建一个ssh密钥，请指明完整的用户ID。用户ID应依次包含用户名和域名两部分，以 @ 符号连接。"    textRed
            colorful -n "范例： "
        else
            colorful -n "Please provide an ID."    textRed
            colorful -n "Example: "
        fi

        colorful -- '    wlc--ssh_keygen'   textGreen
        colorful -- '    "'                 textBrightBlack
        colorful -- "wulechuan@live.com"    textCyan
        colorful -n '"'                     textBrightBlack
        echo
    }


    local newId=$1
    local newIdHumanReadableName=$2

    if [ -z "$newId" ]; then
        console.error    "Invalid \$1. The provided value was \"\e[33m${newId}\e[31m\"."
        print-help
        return 1
    fi

    if [ -z "$newIdHumanReadableName" ]; then
        colorful -- "\$2, aka the human readable name is not provided. "    textYellow
        colorful -- "The default value \""    textYellow
        colorful -- "$newId"                  textMagenta
        colorful -n "\" is used."             textYellow
        newIdHumanReadableName="$newId"
    fi



    local backupKeyFilePath=~/.ssh/backup/${newId//@/_at_}'.sshkey'




    echo

    if [ "$copywritingLanguage" = "zh_CN" ]; then
        colorful -- "针对ID"
        colorful -- "${newIdHumanReadableName}($newId)"    textMagenta
        colorful -n "："
    else
        colorful -- "For "
        colorful -- "${newIdHumanReadableName}($newId)"    textMagenta
        colorful -n ": "
    fi

    if [ -f "$backupKeyFilePath" ]; then
        yes "n"  |  ssh-keygen    -q    -f  "$backupKeyFilePath"    -C  $newId
    else
        echo -n ''; ssh-keygen    -q    -f  "$backupKeyFilePath"    -C  $newId
    fi





    echo
    colorful -n $VE_line_60

    if [ "$copywritingLanguage" = "zh_CN" ]; then
        colorful -- '人类易读版本为：“'                   textBlue
        colorful -- "$newIdHumanReadableName"          textMagenta
        colorful -n '”'                                textBlue
    else
        colorful -- 'Human readable name will be "'    textBlue
        colorful -- "$newIdHumanReadableName"          textMagenta
        colorful -n '".'                               textBlue
    fi

    colorful -n $VE_line_60
    echo




    wlc--ssh_copy_id    $newId    "$backupKeyFilePath"
    echo
}


function wlc--ssh_copy_id {
    function print-examples {
        # local exampleFile1="~/.ssh/id_rsa                          "
        local exampleFile2="~/.ssh/backup/wulechuan@live.com.sshkey"
        local exampleHost="wulechuan@github.com"

        echo

        if [ "$copywritingLanguage" = "zh_CN" ]; then
            colorful -n "范例：${example1}"
        else
            colorful -n "Examples:${example2}"
        fi

        colorful -- "    wlc--ssh_copy_id"    textGreen
        colorful -- "    $exampleHost"        textMagenta
        # colorful -- "    $exampleFile1"       textBlue
        echo

        colorful -- "    wlc--ssh_copy_id"    textGreen
        colorful -- "    $exampleHost"        textMagenta
        colorful -- "    $exampleFile2"       textBlue
        echo
    }

    function print-help-1 {
        echo
        if [ "$copywritingLanguage" = "zh_CN" ]; then
            console.error    "函数 wlc--ssh_copy_id: 无效的【参数1】。得到的值为“\e[33m${remoteHost}\e[31m”"
            colorful -n '请指明完整的用户ID。用户ID应依次包含用户名和域名两部分，以 @ 符号连接。'    textRed
        else
            console.error    "function wlc--ssh_copy_id: Invalid \$1. The provided value was \"\e[33m${remoteHost}\e[31m\"."
            colorful -n 'Please provide an ID.'    textRed
        fi
        print-examples
        echo
    }

    function print-help-2 {
        echo
        if [ "$copywritingLanguage" = "zh_CN" ]; then
            console.error    "函数 wlc--ssh_copy_id："

            colorful -- "    【参数2】得到的值为“"    textRed
            colorful -- "${localSSHKeyFile}"       textYellow
            colorful -n "”。该文件不存在。"           textRed
        else
            console.error    "function wlc--ssh_copy_id:"

            colorful -- "    \$2 was \""    textRed
            colorful -- "${localSSHKeyFile}"    textYellow
            colorful -n "\", which is invalid."    textRed
        fi
        echo
    }

    function print-help-3 {
        echo
        if [ "$copywritingLanguage" = "zh_CN" ]; then
            console.error    "函数 wlc--ssh_copy_id："

            colorful -- "    默认的 SSH 密钥文件“"    textRed
            colorful -- "${localSSHKeyFile}"       textYellow
            colorful -n "”亦不存在。"                textRed
        else
            console.error    "function wlc--ssh_copy_id:"

            colorful -- "    The default SSH key file \""    textRed
            colorful -- "${localSSHKeyFile}"                 textYellow
            colorful -n "\" does not exist either."          textRed
        fi
        echo
    }

    function print-tip-of-default-ssh-key-file-used {
        echo
        if [ "$copywritingLanguage" = "zh_CN" ]; then
            colorful -n "函数 wlc--ssh_copy_id："    textYellow

            colorful -- "    【参数2】未给出。故将采用默认的 SSH 密钥文件，即“"    textYellow
            colorful -- "~/.ssh/id_rsa"    textMagenta
            colorful -n "”。"    textYellow
        else
            colorful -n "function wlc--ssh_copy_id:"    textYellow

            colorful -- "    \$2 was not provided. Thus the default \""    textYellow
            colorful -- "~/.ssh/id_rsa"    textMagenta
            colorful -- "\" will be used instead."    textYellow
        fi
        echo
    }






    local remoteHost="$1"
    local localSSHKeyFile="$2"

    if [ -z "$remoteHost" ]; then
        print-help-1
        return 1
    fi

    if [ -z "$localSSHKeyFile" ]; then
        print-tip-of-default-ssh-key-file-used
        localSSHKeyFile=~/.ssh/id_rsa

        if [ ! -f $localSSHKeyFile ]; then
            print-help-3
            return 3
        fi
    elif [ ! -f "$localSSHKeyFile" ]; then
        print-help-2
        return 2
    fi





    echo
    echo
    echo
    if [ "$copywritingLanguage" = "zh_CN" ]; then
        print-header "将 SSH 公钥复制到远程主机“${remoteHost}”……"
    else
        print-header "Copying SSH pub key to \"${remoteHost}\"..."
    fi
    ssh-copy-id    -i "$localSSHKeyFile"    "$remoteHost"
}
