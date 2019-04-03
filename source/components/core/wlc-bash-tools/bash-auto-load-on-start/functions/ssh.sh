mkdir    -p    ~/.ssh/
mkdir    -p    ~/.ssh/backup/

function wlc-validate-host-id-or-ip-address-with-optional-user-name {
    # $1: the string to check
    # $2: <output> the host name or ip address (IPv4)
    # $3: <output> the user name
    #
    # Example:
    #     remoteHost=
    #     remoteUser=
    #     <this function>    "wulechuan@19.79.3.19"    remoteHost    remoteUser
    #     # remoteHost should be "19.79.3.19"
    #     # remoteUser should be "wulechuan"
    #     # Note that there are NO $ signs before either remoteHoost or remoteUser in the invocation line.

    function wlc-validate-host-id-or-ip-address-with-optional-user-name--print-help {
        if [ "$copywritingLanguage" == "zh_CN" ]; then
            colorful -n '有效的【连接 ID】形如：'
        else
            colorful -n 'A valid ID should look like any of:'    textRed
        fi

        colorful -n '    19.79.3.19'     textBrightCyan
        colorful -n '    @19.79.3.19'    textBrightCyan

        colorful -n '    lovely-computer.com'     textBrightCyan
        colorful -n '    @lovely-computer.com'    textBrightCyan

        colorful -n '    wulechuan@19.79.3.19'    textBrightCyan
        colorful -n '    wulechuan@lovely-computer.com'    textBrightCyan
    }



    local __remoteHostRawValue__="$1"
    local __is_invalid__=0

    local __hostNameOrIPAddress__
    local __userName__

    if     [[ ! "$__remoteHostRawValue__" =~ ^([_a-zA-Z]+[\._a-zA-Z0-9@]*)?@?[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}$ ]] \
		&& [[ ! "$__remoteHostRawValue__" =~ ^([_a-zA-Z]+[\._a-zA-Z0-9@]*)?@?[_a-zA-Z]+[\._a-zA-Z0-9]*$                      ]]; then

		__is_invalid__=1

        wlc-print-message-of-source    'function'    'wlc-validate-host-id-or-ip-address-with-optional-user-name'

        if [ "$copywritingLanguage" == "zh_CN" ]; then
            wlc-print-error    --    "【连接 ID】无效。 "

            colorful -- "给出的值为“"    textRed
            colorful -- "${remoteHost}"    textYellow
            colorful -n "”。"    textRed
        else
            wlc-print-error    --    "Invalid host ID. "
            colorful -- "The provided value was \""    textRed
            colorful -- "${remoteHost}"    textYellow
            colorful -n '".'    textRed
        fi

        wlc-validate-host-id-or-ip-address-with-optional-user-name--print-help
        echo

    else

        if [[ "$__remoteHostRawValue__" =~ @ ]]; then
            __userName__=${__remoteHostRawValue__%@*}
            __hostNameOrIPAddress__=${__remoteHostRawValue__##*@}
        else
            __hostNameOrIPAddress__="$__remoteHostRawValue__"
        fi

	fi



    if [ $# -ge 2 ]; then
        eval "$2=$__hostNameOrIPAddress__"
    fi

    if [ $# -ge 3 ]; then
        eval "$3=$__userName__"
    fi



    return $__is_invalid__
}

function wlc--ssh_keygen {
    local nameOfThisFunction='wlc--ssh_keygen'

    function wlc--ssh_keygen--print-help {
        echo
        if [ "$copywritingLanguage" == "zh_CN" ]; then
            colorful -n "范例： "
        else
            colorful -n "Example: "
        fi

        colorful -- "    $nameOfThisFunction"    textGreen
        colorful -- "    wulechuan@live.com"     textBrightCyan
        echo

        colorful -- "    $nameOfThisFunction"    textGreen
        colorful -- "    wulechuan@live.com"     textBrightCyan
        colorful -- "    my-home-computer"       textMagenta
        echo
    }


    if [ $# -eq 0 ]; then
        wlc--ssh_keygen--print-help
        return 0
    fi



    local newId="$1"
    local newIdHumanReadableName="$2"


    local stageReturnCode


    wlc-validate-host-id-or-ip-address-with-optional-user-name    "$newId"
    stageReturnCode=$?

    if [ $stageReturnCode -gt 1 ]; then
        wlc--ssh_keygen--print-help
        return 1
    fi



    if [ -z "$newIdHumanReadableName" ]; then
        newIdHumanReadableName="$newId"

        colorful -- "\$2, aka the human readable name is not provided. "    textYellow
        colorful -- "The \$1 \""     textYellow
        colorful -- "$newId"         textMagenta
        colorful -n "\" is used."    textYellow
    fi



    local backupKeyFilePath=~/.ssh/backup/${newId//@/_at_}'.sshkey'




    echo

    if [ "$copywritingLanguage" == "zh_CN" ]; then
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

    if [ "$copywritingLanguage" == "zh_CN" ]; then
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
}

function wlc--ssh_copy_id {
    local nameOfThisFunction='wlc--ssh_copy_id' # for printing messages

    function wlc--ssh_copy_id--print-examples {
        # local exampleFile1="~/.ssh/id_rsa                          "
        local exampleFile2="~/.ssh/backup/wulechuan-for-all-dockers.sshkey"
        local exampleHost="wulechuan@19.79.3.19"

        echo

        if [ "$copywritingLanguage" == "zh_CN" ]; then
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

    function wlc--ssh_copy_id--print-help-2 {
        echo
        wlc-print-message-of-source    'function'    "$nameOfThisFunction"

        if [ "$copywritingLanguage" == "zh_CN" ]; then
            wlc-print-error    "【参数2】所指文件不存在。"
            colorful -- "【参数2】得到的值为“"    textRed
            colorful -- "${localSSHKeyFile}"    textYellow
            colorful -n "”。"    textRed
        else
            wlc-print-error    "\$2 mentioned an invalid file."
            colorful -- "The value of \$2 was \""    textRed
            colorful -- "${localSSHKeyFile}"    textYellow
            colorful -n "\"."    textRed
        fi
        echo
    }

    function wlc--ssh_copy_id--print-help-3 {
        echo
        wlc-print-message-of-source    'function'    "$nameOfThisFunction"

        if [ "$copywritingLanguage" == "zh_CN" ]; then
            colorful -n "    命令中未指明密钥文件。而默认的 SSH 密钥文件"    textRed

            colorful -- '        “'             textRed
            colorful -- "${localSSHKeyFile}"    textYellow
            colorful -n '”'                     textRed

            colorful -n "    亦不存在。"          textRed
        else
            colorful -n "    The command didn't specified any SSH key file."    textRed
            colorful -n "    while the default SSH key file"                    textRed

            colorful -- '        "'             textRed
            colorful -- "${localSSHKeyFile}"    textYellow
            colorful -n '"'                     textRed

            colorful -n "    does not exist either."          textRed
        fi
        echo
    }

    function print-tip-of-default-ssh-key-file-used {
        echo
        wlc-print-message-of-source    'function'    "$nameOfThisFunction"

        if [ "$copywritingLanguage" == "zh_CN" ]; then
            colorful -- '    【参数2】'    textBrightCyan
            colorful -n '未给出。'    textGreen

            colorful -- '    故采用默认的 SSH 密钥文件，即“'    textGreen
            colorful -- "~/.ssh/id_rsa"    textMagenta
            colorful -n '”。'    textGreen
        else
            colorful -- '    \$2'    textBrightCyan
            colorful -n ' was not provided.'    textGreen
            colorful -- '    Thus the default key file "'    textGreen
            colorful -- "~/.ssh/id_rsa"    textMagenta
            colorful -- '" is used instead.'    textGreen
        fi
        echo
    }



    if [ $# -eq 0 ]; then
        wlc--ssh_copy_id--print-examples
        return 0
    fi



    local _remoteHostRawValue_="$1"
    local localSSHKeyFile="$2"

    local stageReturnCode


    local _remoteHost_scid_
    local _remoteUser_scid_


    wlc-validate-host-id-or-ip-address-with-optional-user-name    "$_remoteHostRawValue_"    _remoteHost_scid_    _remoteUser_scid_
    stageReturnCode=$?



    wlc-print-message-of-source    'function'    "$nameOfThisFunction"
    echo -e "    remote host: \"\e[33m${_remoteHost_scid_}\e[0m\""
    echo -e "    remote user: \"\e[33m${_remoteUser_scid_}\e[0m\""

    if [ $stageReturnCode -gt 0 ] || [ -z "$_remoteHost_scid_" ] || [ -z "$_remoteUser_scid_" ]; then

        if [ -z "$_remoteHost_scid_" ]; then
            colorful -n '    Remote host name or ip address is absent.'    textRed
        fi

        if [ -z "$_remoteUser_scid_" ]; then
            colorful -n '    Remote user name is absent.'    textRed
        fi

        wlc--ssh_copy_id--print-examples

        return 1
    fi




    if [ -z "$localSSHKeyFile" ]; then

        localSSHKeyFile=~/.ssh/id_rsa

        if [ ! -f $localSSHKeyFile ]; then
            wlc--ssh_copy_id--print-help-3
            return 3
        fi

        print-tip-of-default-ssh-key-file-used

    elif [ ! -f "$localSSHKeyFile" ]; then
        wlc--ssh_copy_id--print-help-2
        return 2
    fi





    echo3
    if [ "$copywritingLanguage" == "zh_CN" ]; then
        wlc-print-header "将 SSH 公钥复制到远程主机“\e[96m${_remoteUser_scid_}\e[32m@\e[35m${_remoteHost_scid_}\e[32m”……"
    else
        wlc-print-header "Copying SSH pub key to \"\e[96m${_remoteUser_scid_}\e[32m@\e[35m${_remoteHost_scid_}\e[32m\"..."
    fi
    ssh-copy-id    -i "$localSSHKeyFile"    "${_remoteUser_scid_}@${_remoteHost_scid_}"
}
