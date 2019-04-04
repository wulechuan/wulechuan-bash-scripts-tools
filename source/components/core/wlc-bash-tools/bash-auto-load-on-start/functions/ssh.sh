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

function wlc-ssh-keygen {
    local nameOfThisFunction='wlc-ssh-keygen'

    function wlc-ssh-keygen--print-help {
        echo
        if [ "$copywritingLanguage" == "zh_CN" ]; then
            colorful -n "范例： "
        else
            colorful -n "Example: "
        fi

        colorful -- "    $nameOfThisFunction"    textGreen
        colorful -- "    my-home-computer"       textMagenta
        echo
    }


    if [ $# -eq 0 ]; then
        wlc-ssh-keygen--print-help
        return 0
    fi


    local newId="$1"

    if [ -z "$newId" ]; then
        wlc-ssh-keygen--print-help
        return 1
    fi

    local shouldCreateBackupFiles=0
    local keyFileNamesPrefix

    if [ ! -z "$2" ]; then
        shouldCreateBackupFiles=1

        if   [  "$2" == '--should-create-backups' ]; then
            keyFileNamesPrefix="$newId"

            keyFileNamesPrefix=${keyFileNamesPrefix// /_}
            # keyFileNamesPrefix=${keyFileNamesPrefix//@/_at_}

        elif [[ "$2" =~ ^--key-file-names-prefix=.* ]]; then
            keyFileNamesPrefix="${2:24}" # --key-file-names-prefix="..."

            if [ -z "$keyFileNamesPrefix" ]; then
                wlc-print-message-of-source    'function'    "$nameOfThisFunction"
                wlc-print-error    -1    "Invalid file name provided by \"\e[33m--key-file-names-prefix\e[31m\""
                return 21
            fi
        else
            wlc-print-message-of-source    'function'    "$nameOfThisFunction"
            wlc-print-error    -1    "Invalid \$2."
            return 21
        fi
    fi



    local privateKeyFilePath
    local publicKeyFilePath_


    echo

    if [ "$copywritingLanguage" == "zh_CN" ]; then
        colorful -- "创建名为“"
        colorful -- "$newId"    textMagenta
        colorful -n "”的 SSH 密钥对："
    else
        colorful -- 'Create SSH key pair for ID "'
        colorful -- "$newId"    textMagenta
        colorful -n '": '
    fi


    if [ $shouldCreateBackupFiles -gt 0 ]; then
        privateKeyFilePath=~/.ssh/backup/${keyFileNamesPrefix}
        publicKeyFilePath_=~/.ssh/backup/${keyFileNamesPrefix}'.pub'
    else
        privateKeyFilePath=~/.ssh/id_rsa
        publicKeyFilePath_=~/.ssh/id_rsa.pub
    fi


    if [ "$copywritingLanguage" == "zh_CN" ]; then
        colorful -n "将会创建或覆盖以下密钥文件： “"
    else
        colorful -n 'Will create or overwrite these 2 files:'
    fi
    colorful -n "    $privateKeyFilePath"    textMagenta
    colorful -n "    $publicKeyFilePath_"    textMagenta


    if [   -f "$privateKeyFilePath" ]; then
        rm -f "$privateKeyFilePath"

        if [ "$copywritingLanguage" == "zh_CN" ]; then
            colorful -- '已删除旧有文件“'          textYellow
            colorful -- "$privateKeyFilePath"    textRed
            colorful -n '”。'                    textYellow
        else
            colorful -- 'Deleted an old file: "'    textYellow
            colorful -- "$privateKeyFilePath"       textRed
            colorful -n '"'                         textYellow
        fi
    fi

    if [   -f "$publicKeyFilePath_" ]; then
        rm -f "$publicKeyFilePath_"

        if [ "$copywritingLanguage" == "zh_CN" ]; then
            colorful -- '已删除旧有文件“'          textYellow
            colorful -- "$publicKeyFilePath_"    textRed
            colorful -n '”。'                    textYellow
        else
            colorful -- 'Deleted an old file: "'    textYellow
            colorful -- "$publicKeyFilePath_"       textRed
            colorful -n '"'                         textYellow
        fi
    fi

    echo
    colorful -n "$VE_line_60"
    echo
    if [ "$copywritingLanguage" == "zh_CN" ]; then
        colorful -n "现在开始创建密钥对"    textGreen
    else
        colorful -n "Now creating SSH key pair"    textGreen
    fi

    ssh-keygen    -C "$newId"    -f "$privateKeyFilePath"
    local stageReturnCode=$?
    echo "stageReturnCode=$stageReturnCode"
    if [ $stageReturnCode -gt 0 ]; then
        return $stageReturnCode
    fi

    echo
    colorful -n "${VE_line_30:6} PUBLIC KEY ${VE_line_30:6}"
    set-echo-color    textGreen
    cat "$publicKeyFilePath_"
    clear-echo-color
    colorful -n "$VE_line_60"
}

function wlc-ssh-copy-id {
    local nameOfThisFunction='wlc-ssh-copy-id' # for printing messages
    local defaultSSHPrivateKeyFile=~/.ssh/id_rsa
    local defaultSSHPublicKeyFile=${defaultSSHPrivateKeyFile}'.pub'

    function wlc-ssh-copy-id--print-examples {
        # local exampleFile1="~/.ssh/id_rsa                          "
        local exampleFile2="~/.ssh/backup/wulechuan-for-all-dockers.sshkey"
        local exampleHost="wulechuan@19.79.3.19"

        echo

        if [ "$copywritingLanguage" == "zh_CN" ]; then
            colorful -n "范例："
        else
            colorful -n "Examples:"
        fi

        colorful -- "    wlc-ssh-copy-id"    textGreen
        colorful -- "    $exampleHost"        textMagenta
        # colorful -- "    $exampleFile1"       textBlue
        echo

        colorful -- "    wlc-ssh-copy-id"    textGreen
        colorful -- "    $exampleHost"        textMagenta
        colorful -- "    $exampleFile2"       textBlue
        echo
    }

    function wlc-ssh-copy-id--print-help-2 {
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

    function wlc-ssh-copy-id--print-help-3 {
        echo
        wlc-print-message-of-source    'function'    "$nameOfThisFunction"

        if [ "$copywritingLanguage" == "zh_CN" ]; then
            colorful -n "    命令中未指明 SSH 公开密钥文件。而默认的 SSH 公开密钥文件"    textRed

            colorful -- '        “'                   textRed
            colorful -- "$defaultSSHPublicKeyFile"    textYellow
            colorful -n '”'                           textRed

            colorful -n "    亦不存在。"               textRed
        else
            colorful -n "    The command didn't specified any SSH public key file."    textRed
            colorful -n "    while the default SSH public key file"                    textRed

            colorful -- '        "'                    textRed
            colorful -- "$defaultSSHPublicKeyFile"     textYellow
            colorful -n '"'                            textRed

            colorful -n "    doesn't exist either."    textRed
        fi
        echo
    }

    function print-tip-of-default-ssh-key-file-used {
        echo
        wlc-print-message-of-source    'function'    "$nameOfThisFunction"

        if [ "$copywritingLanguage" == "zh_CN" ]; then
            colorful -- '    【参数2】'    textBrightCyan
            colorful -n '未给出。'    textGreen

            colorful -- '    故采用默认的 SSH 公开密钥文件，即“'    textGreen
            colorful -- "$defaultSSHPublicKeyFile"    textMagenta
            colorful -n '”。'    textGreen
        else
            colorful -- '    \$2'                      textBrightCyan
            colorful -n ' was not provided.'           textGreen
            colorful -- '    Thus the default SSH public key file "'    textGreen
            colorful -- "$defaultSSHPublicKeyFile"     textMagenta
            colorful -- '" is used instead.'           textGreen
        fi
        echo
    }



    if [ $# -eq 0 ]; then
        wlc-ssh-copy-id--print-examples
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

        wlc-ssh-copy-id--print-examples

        return 21
    fi




    if [ -z "$localSSHKeyFile" ]; then

        # localSSHKeyFile=$defaultSSHPrivateKeyFile

        if [ ! -f $defaultSSHPrivateKeyFile ] || [ ! -f $defaultSSHPublicKeyFile ]; then
            wlc-ssh-copy-id--print-help-3
            return 23
        fi

        print-tip-of-default-ssh-key-file-used

    elif [ ! -f "$localSSHKeyFile" ]; then
        wlc-ssh-copy-id--print-help-2
        return 22
    fi





    echo3
    if [ "$copywritingLanguage" == "zh_CN" ]; then
        wlc-print-header    "将 SSH 公开密钥复制到远程主机“\e[96m${_remoteUser_scid_}\e[32m@\e[35m${_remoteHost_scid_}\e[32m”……"
    else
        wlc-print-header    "Copying SSH public key to \"\e[96m${_remoteUser_scid_}\e[32m@\e[35m${_remoteHost_scid_}\e[32m\"..."
    fi

    if [ -z "$localSSHKeyFile" ]; then
        ssh-copy-id                             "${_remoteUser_scid_}@${_remoteHost_scid_}"
    else
        ssh-copy-id    -i "$localSSHKeyFile"    "${_remoteUser_scid_}@${_remoteHost_scid_}"
    fi
}
