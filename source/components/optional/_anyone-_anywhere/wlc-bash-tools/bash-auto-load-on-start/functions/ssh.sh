wlc_ssh_tools__example_ssh_id='wulechuan@live.com'

mkdir    -p    ~/.ssh/
mkdir    -p    ~/.ssh/backup/


function wlc--ssh_keygen {
    function print-help {
        colorful -n $VE_line_60

        if [ "$copywritingLanguage" = "zh_CN" ]; then
            colorful -n "欲创建一个ssh密钥，请指明完整的用户ID。用户ID应依次包含用户名和域名两部分，以@符号连接。"    textRed
            colorful -n $VE_line_30
            colorful -- "范例："
        else
            colorful -n "Please provide an ID."    textRed
            colorful -n $VE_line_30
            colorful -- "Example: "
        fi

        colorful -- 'sshkg '                textGreen
        colorful -- '"'                     textBrightBlack
        colorful -- "wulechuan@live.com"    textCyan
        colorful -n '"'                     textBrightBlack

        colorful -n $VE_line_60
    }


    local newId=$1
    local newIdHumanReadableName=$2

    if [ -z "$newId" ]; then
        print-help
        return 1
    fi

    if [ -z "$newIdHumanReadableName" ]; then
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
    



    wlc--ssh_copy_id    "$backupKeyFilePath"    $newId
    echo
}


function wlc--ssh_copy_id {
    function print-help-1 {
        local example1="~/.ssh/backup/${wlc_ssh_tools__example_ssh_id}.sshky"
        local example2="~/.ssh/id_rsa"

        if [ "$copywritingLanguage" = "zh_CN" ]; then
            colorful -n '请指明ssh密钥文件。'    textRed

            colorful -- '  范例1：'
            colorful -n "${example1}"    textCyan

            colorful -- '  范例2：'
            colorful -n "${example2}"    textCyan
        else
            colorful -n 'Please provide an ssh key file.'    textRed

            colorful -- '  Example 1: '
            colorful -n "${example1}"    textCyan

            colorful -- '  Example 2: '
            colorful -n "${example2}"    textCyan
        fi
    }

    function print-help-2 {
        if [ "$copywritingLanguage" = "zh_CN" ]; then
            colorful -n '请指明完整的用户ID。用户ID应依次包含用户名和域名两部分，以@符号连接。'    textRed
            colorful -- '  范例：'
        else
            colorful -n 'Please provide an ID.'    textRed
            colorful -- '  Example: '
        fi
        colorful -n "${wlc_ssh_tools__example_ssh_id}"    textBlue
    }






    local sshKeyFile=$1
    local remoteHost=$2

    if [ -z "$sshKeyFile" ]; then
        print-help-1
        return 1
    fi

    if [ -z "$remoteHost" ]; then
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
    ssh-copy-id -i $sshKeyFile ${remoteHost}
}
