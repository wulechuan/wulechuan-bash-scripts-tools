mkdir    -p    ~/.ssh/backup/

function wlc-validate-host-name-or-ip-address-with-optional-user-name {
    local __validatingSSHHostID_nameOfThisFunction__='wlc-validate-host-name-or-ip-address-with-optional-user-name'
    # $1: --should-not-print-help-after-printing-error
    # $2: the string to check
    # $3: --default-user-name="..."
    # $4: <output> the resolved host id
    # $5: <output> the resolved host name or ip address (IPv4)
    # $6: <output> the decided user name
    # $7: <output> host format: 'name' or 'IPv4' or 'IPv6'. ** IPv6 IS NOT IMPLEMENTED!**
    #
    # Example:
    #     remoteID=
    #     remoteHost=
    #     remoteUser=
    #     remoteHostFormat=
    #     <this function>    "wulechuan@19.79.3.19"    remoteID    remoteHost    remoteUser    remoteHostFormat
    #     # remoteID should be "wulechuan@19.79.3.19"
    #     # remoteHost should be "19.79.3.19"
    #     # remoteUser should be "wulechuan"
    #     # remoteHostFormat should be "IPv4"
    #     # Note that there are NO $ signs before either remoteHoost or remoteUser in the invocation line.

    function wlc-validate-host-name-or-ip-address-with-optional-user-name--print_help {
        local __validatingSSHHostID_colorOfArgumentName__='textGreen'
        local __validatingSSHHostID_colorOfArgumentValue__='textMagenta'
        local __validatingSSHHostID_colorOfMarkers__='textBlue'

        echo

        if [ "$1" == '--should-print-separation-line' ]; then
            colorful -n "$VE_line_60"
            echo
        fi

        colorful -n 'Usage:'

        colorful -- "    $__validatingSSHHostID_nameOfThisFunction__"
        colorful -n ' \\'

        colorful -- "        [ "                                              $__validatingSSHHostID_colorOfMarkers__
        colorful -- "--should-not-print-help-after-printing-error"            $__validatingSSHHostID_colorOfArgumentName__
        colorful -- " ]"                                                      $__validatingSSHHostID_colorOfMarkers__
        colorful -n ' \\'

        colorful -- "        <remote accessing id, user name is optional>"    $__validatingSSHHostID_colorOfArgumentValue__
        colorful -n ' \\'

        colorful -- "        [ "                                              $__validatingSSHHostID_colorOfMarkers__
        colorful -- "--default-user-name="                                    $__validatingSSHHostID_colorOfArgumentName__
        colorful -- "<the default user name>"                                 $__validatingSSHHostID_colorOfArgumentValue__
        colorful -- " ]"                                                      $__validatingSSHHostID_colorOfMarkers__
        colorful -n ' \\'

        colorful -- "        [ "                                              $__validatingSSHHostID_colorOfMarkers__
        colorful -- "<ref var for accepting the resolved id>"                 $__validatingSSHHostID_colorOfArgumentValue__
        colorful -- " ]"                                                      $__validatingSSHHostID_colorOfMarkers__
        colorful -n ' \\'

        colorful -- "        [ "                                                          $__validatingSSHHostID_colorOfMarkers__
        colorful -- "<ref var for accepting the resolved host name or IP address>"        $__validatingSSHHostID_colorOfArgumentValue__
        colorful -- " ]"                                                                  $__validatingSSHHostID_colorOfMarkers__
        colorful -n ' \\'

        colorful -- "        [ "                                              $__validatingSSHHostID_colorOfMarkers__
        colorful -- "<ref var for accepting the resolved user name>"          $__validatingSSHHostID_colorOfArgumentValue__
        colorful -- " ]"                                                      $__validatingSSHHostID_colorOfMarkers__
        colorful -n ' \\'

        colorful -- "        [ "                                              $__validatingSSHHostID_colorOfMarkers__
        colorful -- "<ref var for accepting the resolved host format>"        $__validatingSSHHostID_colorOfArgumentValue__
        colorful -- " ]"                                                      $__validatingSSHHostID_colorOfMarkers__
        echo
        echo



        if [ "$copywritingLanguage" == "zh_CN" ]; then
            colorful -n '例 1：'
        else
            colorful -n 'Example 1:'
        fi

        colorful -- "    local "                 $__validatingSSHHostID_colorOfMarkers__
        colorful -n "my-resolved-full-id"        $__validatingSSHHostID_colorOfArgumentValue__
        colorful -- "    local "                 $__validatingSSHHostID_colorOfMarkers__
        colorful -n "my-resolved-host"           $__validatingSSHHostID_colorOfArgumentValue__
        colorful -- "    local "                 $__validatingSSHHostID_colorOfMarkers__
        colorful -n "my-resolved-user"           $__validatingSSHHostID_colorOfArgumentValue__
        colorful -- "    local "                 $__validatingSSHHostID_colorOfMarkers__
        colorful -n "my-resolved-host-format"    $__validatingSSHHostID_colorOfArgumentValue__

        colorful -- "    $__validatingSSHHostID_nameOfThisFunction__"
        colorful -n ' \\'

        colorful -- "        --should-not-print-help-after-printing-error"    $__validatingSSHHostID_colorOfArgumentValue__
        colorful -n ' \\'
        colorful -- "        wulechuan@19.79.3.19"                            $__validatingSSHHostID_colorOfArgumentValue__
        colorful -n ' \\'
        colorful -- "        my-resolved-full-id"                             $__validatingSSHHostID_colorOfArgumentName__
        colorful -n ' \\'
        colorful -- "        my-resolved-host"                                $__validatingSSHHostID_colorOfArgumentName__
        colorful -n ' \\'
        colorful -- "        my-resolved-user"                                $__validatingSSHHostID_colorOfArgumentName__
        colorful -n ' \\'
        colorful -- "        my-resolved-host-format"                         $__validatingSSHHostID_colorOfArgumentName__
        echo
        echo

        if [ "$copywritingLanguage" == "zh_CN" ]; then
            colorful -n '例 2：'
        else
            colorful -n 'Example 2:'
        fi

        colorful -- "    local "             $__validatingSSHHostID_colorOfMarkers__
        colorful -n "the-resolved-ssh-id"    $__validatingSSHHostID_colorOfArgumentValue__

        colorful -- "    $__validatingSSHHostID_nameOfThisFunction__"
        colorful -n ' \\'

        colorful -- "        \"\$1\""                 $__validatingSSHHostID_colorOfArgumentValue__
        colorful -n ' \\'

        colorful -- "        --default-user-name="    $__validatingSSHHostID_colorOfArgumentName__
        colorful -- "'root'"                          $__validatingSSHHostID_colorOfArgumentValue__
        colorful -n ' \\'

        colorful -- "        the-resolved-ssh-id"     $__validatingSSHHostID_colorOfArgumentName__
        echo
        echo
    }

    function wlc-validate-host-name-or-ip-address-with-optional-user-name--print_error_of_invalid_id {
        if [ "$copywritingLanguage" == "zh_CN" ]; then
            wlc-print-error    --    "【连接 ID】无效。 "

            colorful -- "给出的值为“"    textRed
            colorful -- "${1}"    textYellow
            colorful -n "”。"    textRed

            colorful -n '有效的【连接 ID】形如：'
        else
            wlc-print-error    --    "Invalid host ID. "
            colorful -- "The provided value was \""    textRed
            colorful -- "${1}"    textYellow
            colorful -n '".'    textRed

            colorful -n 'A valid ID should look like any of:'    textRed
        fi

        colorful -n '    19.79.3.19'                       textBrightCyan
        colorful -n '    @19.79.3.19'                      textBrightCyan

        colorful -n '    lovely-computer.com'              textBrightCyan
        colorful -n '    @lovely-computer.com'             textBrightCyan

        colorful -n '    wulechuan@19.79.3.19'             textBrightCyan
        colorful -n '    wulechuan@lovely-computer.com'    textBrightCyan
    }

    if [ $# -eq 0 ] || [ -z "$1" ]; then
        wlc-print-message-of-source    'function'    $__validatingSSHHostID_nameOfThisFunction__
        if [ "$copywritingLanguage" == "zh_CN" ]; then
            wlc-print-error    -1    '第 1 个参数，或“--should-not-print-help-after-printing-error”之后的第 1 个参数，必须指明要检验的 SSH ID。注：用户名可省略。'
        else
            wlc-print-error    -1    "The 1st argument, or the 1st argument comes after '--should-not-print-help-after-printing-error', must provide the SSH ID to validate."
        fi

        wlc-validate-host-name-or-ip-address-with-optional-user-name--print_help    --should-print-separation-line
        return 31
    fi


    local __validatingSSHHostID_shouldNotPrintHelpOnError__=0
    if [ "$1" == '--should-not-print-help-after-printing-error' ]; then
        __validatingSSHHostID_shouldNotPrintHelpOnError__=1
        shift
    fi

    if [ $# -eq 1 ]; then
        wlc-print-message-of-source    'function'    $__validatingSSHHostID_nameOfThisFunction__

        if [ "$copywritingLanguage" == "zh_CN" ]; then
            colorful -n '调用语句仅给出了 1 个参数。解析好的 SSH ID 无从传递到外界。'    textYellow
        else
            colorful -n "Only 1 argument was provided. The resolved ID and its 2 components can not be passed to outside of this function."    textYellow
        fi

        echo
    fi

    local __validatingSSHHostID_hostIDRawValue__="$1"
    shift


    local __validatingSSHHostID_defaultUserName__

    if [[ "$1" =~ ^--default-user-name= ]]; then
        __validatingSSHHostID_defaultUserName__=${1:20}

        if [ -z "$__validatingSSHHostID_defaultUserName__" ]; then
            wlc-print-message-of-source    'function'    $__validatingSSHHostID_nameOfThisFunction__

            if [ "$copywritingLanguage" == "zh_CN" ]; then
                colorful -- '参数“'                  textYellow
                colorful -- '--default-user-name'    textGreen
                colorful -- '”的取值“'                textYellow
                colorful -- "$__validatingSSHHostID_defaultUserName__"    textBrightCyan
                colorful -- '”无效。'                 textYellow
            else
                colorful -- 'Invalid value "'        textYellow
                colorful -- "$__validatingSSHHostID_defaultUserName__"    textBrightCyan
                colorful -- '" for argument "'       textYellow
                colorful -- '--default-user-name'    textGreen
                colorful -- '".'                     textYellow
            fi
            echo

            echo
        fi

        shift
    fi


    local __validatingSSHHostID_hostFormat__

    if   [[ "$__validatingSSHHostID_hostIDRawValue__" =~ ^(([_a-zA-Z]+[\._a-zA-Z0-9@]*)?@)?[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}$ ]]
    then
        __validatingSSHHostID_hostFormat__='IPv4'
    elif [[ "$__validatingSSHHostID_hostIDRawValue__" =~ ^(([_a-zA-Z]+[\._a-zA-Z0-9@]*)?@)?([_a-zA-Z0-9]+\.)*[_a-zA-Z]+[_a-zA-Z0-9]*$      ]]
    then
        __validatingSSHHostID_hostFormat__='name'
    else
        wlc-print-message-of-source    'function'    $__validatingSSHHostID_nameOfThisFunction__
        wlc-validate-host-name-or-ip-address-with-optional-user-name--print_error_of_invalid_id    "$__validatingSSHHostID_hostIDRawValue__"
        if [ $__validatingSSHHostID_shouldNotPrintHelpOnError__ -eq 0 ]; then
            wlc-validate-host-name-or-ip-address-with-optional-user-name--print_help    --should-print-separation-line
        fi
        echo

        return 1
    fi



    local __validatingSSHHostID_resolvedHostNameOrIPAddress__
    local __validatingSSHHostID_resolvedUserName__

    if [[ "$__validatingSSHHostID_hostIDRawValue__" =~ @ ]]; then
        __validatingSSHHostID_resolvedUserName__=${__validatingSSHHostID_hostIDRawValue__%@*}
        __validatingSSHHostID_resolvedHostNameOrIPAddress__=${__validatingSSHHostID_hostIDRawValue__##*@}
    else
        __validatingSSHHostID_resolvedHostNameOrIPAddress__="$__validatingSSHHostID_hostIDRawValue__"
    fi


    if [ -z "$__validatingSSHHostID_resolvedUserName__" ]; then

        if [ ! -z "$__validatingSSHHostID_defaultUserName__" ]; then
            __validatingSSHHostID_resolvedUserName__=$__validatingSSHHostID_defaultUserName__

            colorful -- 'The '                                          textGreen
            colorful -- 'user name'                                     textBrightCyan
            colorful -- ' was not provided. Thus "'                     textGreen
            colorful -- "'$__validatingSSHHostID_defaultUserName__'"    textMagenta
            colorful -n '" is assumed.'                                 textGreen
            echo

        else
            wlc-print-message-of-source    'function'    $__validatingSSHHostID_nameOfThisFunction__
            wlc-print-error    "The \e[33muser name\e[31m was not included in the \e[96m\$1\e[31m, while the \e[96m--default-user-name\e[31m was not provided either."
            if [ $__validatingSSHHostID_shouldNotPrintHelpOnError__ -eq 0 ]; then
                wlc-validate-host-name-or-ip-address-with-optional-user-name--print_help    --should-print-separation-line
            fi
            return 15
        fi

    fi


    if [ $# -ge 1 ]; then
        eval "$1=$__validatingSSHHostID_resolvedUserName__@$__validatingSSHHostID_resolvedHostNameOrIPAddress__"
    fi

    if [ $# -ge 2 ]; then
        eval "$2=$__validatingSSHHostID_resolvedHostNameOrIPAddress__"
    fi

    if [ $# -ge 3 ]; then
        eval "$3=$__validatingSSHHostID_resolvedUserName__"
    fi

    if [ $# -ge 4 ]; then
        eval "$4=$__validatingSSHHostID_hostFormat__"
    fi

    # echo -e "\e[30;42mDEBUG\e[0m
    #     __validatingSSHHostID_resolvedHostNameOrIPAddress__=\"\e[33m${__validatingSSHHostID_resolvedHostNameOrIPAddress__}\e[0m\"
    #     __validatingSSHHostID_resolvedUserName__=\"\e[33m${__validatingSSHHostID_resolvedUserName__}\e[0m\"
    #     __validatingSSHHostID_hostFormat__=\"\e[33m${__validatingSSHHostID_hostFormat__}\e[0m\"
    # "

    return 0
}

function wlc-ssh-keygen {
    local nameOfThisFunction='wlc-ssh-keygen'

    function wlc-ssh-keygen--print_help {
        local nameOfThisFunction='wlc_bash_tools--deploy_to_remote'
        local colorOfArgumentName='textGreen'
        local colorOfArgumentValue='textMagenta'
        local colorOfMarkers='textBlue'

        echo

        if [ "$1" == '--should-print-separation-line' ]; then
            colorful -n "$VE_line_60"
            echo
        fi

        if [ "$copywritingLanguage" == "zh_CN" ]; then
            colorful -n "用法： "
        else
            colorful -n "Usage: "
        fi

        colorful -- "    $nameOfThisFunction"

        colorful -n ' \\'

        colorful -- "        \"<A descriptive name for the computer your are using now>\""    $colorOfArgumentValue

        colorful -n ' \\'

        colorful -- "        [ "                  $colorOfMarkers
        colorful -- "--should-create-backups"     $colorOfArgumentName
        colorful -- " | "                         $colorOfMarkers
        colorful -- "--key-file-names-prefix="    $colorOfArgumentName
        colorful -- "\"<file name prefix>\""      $colorOfArgumentValue
        colorful -- " ]"                          $colorOfMarkers

        colorful -n ' \\'

        colorful -- "        [ "                                        $colorOfMarkers
        colorful -- "--should-generate-new-ones-even-if-files-exist"    $colorOfArgumentName
        colorful -- " ]"                                                $colorOfMarkers

        echo
        echo




        if [ "$copywritingLanguage" == "zh_CN" ]; then
            colorful -n "范例： "
        else
            colorful -n "Examples: "
        fi

        colorful -- "    $nameOfThisFunction"
        colorful -- "    my-home-i7-8700"             $colorOfArgumentValue
        echo
        echo

        colorful -- "    $nameOfThisFunction"
        colorful -n ' \\'
        colorful -- "        my-home-i7-8700"                                   $colorOfArgumentValue
        colorful -n ' \\'
        colorful -- "        --should-generate-new-ones-even-if-files-exist"    $colorOfArgumentName
        echo
        echo

        colorful -- "    $nameOfThisFunction"
        colorful -- "    my-bedroom-i7-8700"          $colorOfArgumentValue
        colorful -- "    --key-file-names-prefix="    $colorOfArgumentName
        colorful -- "home-i7-8700-default"            $colorOfArgumentValue
        echo
        echo

        colorful -- "    $nameOfThisFunction"
        colorful -n ' \\'
        colorful -- "        my-htpc-intel-pentium"       $colorOfArgumentValue
        colorful -n ' \\'
        colorful -- "        --should-create-backups"     $colorOfArgumentName
        colorful -n ' \\'
        colorful -- "        --should-generate-new-ones-even-if-files-exist"    $colorOfArgumentName
        echo
        echo
    }


    if [ $# -eq 0 ]; then
        wlc-ssh-keygen--print_help
        return 0
    fi

    local newId


    if [[ ! "$1" =~ ^-- ]] && [[ ! "$1" =~ ^-.$ ]] && [ "$1" != - ]; then
        newId="$1"
        shift
    fi

    if [ -z "$newId" ]; then
        if [ "$copywritingLanguage" == "zh_CN" ]; then
            wlc-print-error    -1    "\e[33m【参数 1】\e[31m 必须为新 SSH 的 ID 或描述名称。"
        else
            wlc-print-error    -1    "The \e[33m\$1\e[31m must be the new SSH ID or desciptive name."
        fi

        wlc-ssh-keygen--print_help    --should-print-separation-line

        return 1
    fi







    local duplicatedArgumentEncountered

    local switchOfUsingAutoBackupFileIsProvided=0
    local backupFileNamesPrefixIsProvided=0
    local switchOfSkippingExistingIsProvided=0

    local shouldCreateCustomBackupFiles=0
    local keyFileNamesPrefix
    local shouldNotGenerateNewKeysIfFilesAlreadyExist=1

    local currentArgument

    while true; do
        if [ $# -eq 0 ]; then
            break
        fi

        currentArgument="$1"
        shift

        case "$currentArgument" in
            --should-create-backups)
                if [ $switchOfUsingAutoBackupFileIsProvided -gt 0 ]; then
                    duplicatedArgumentEncountered='--should-create-backups'
                    break
                fi
                shouldCreateCustomBackupFiles=1
                switchOfUsingAutoBackupFileIsProvided=1
                ;;

            --key-file-names-prefix=*)
                if [ $backupFileNamesPrefixIsProvided -gt 0 ]; then
                    duplicatedArgumentEncountered='--key-file-names-prefix='
                    break
                fi
                keyFileNamesPrefix=${currentArgument:24}
                shouldCreateCustomBackupFiles=1
                backupFileNamesPrefixIsProvided=1
                ;;

            --should-generate-new-ones-even-if-files-exist)
                if [ $switchOfSkippingExistingIsProvided -gt 0 ]; then
                    duplicatedArgumentEncountered='--should-generate-new-ones-even-if-files-exist'
                    break
                fi
                shouldNotGenerateNewKeysIfFilesAlreadyExist=0
                switchOfSkippingExistingIsProvided=1
                ;;

            *)
                if [ "$copywritingLanguage" == "zh_CN" ]; then
                    colorful -- 'Unknow argument "'    textYellow
                    colorful -- "$currentArgument"     textRed
                    colorful -n '" is skipped'         textYellow
                else
                    colorful -- '未知参数“'             textYellow
                    colorful -- "$currentArgument"     textRed
                    colorful -n '”已被忽略。'            textYellow
                fi
                ;;
        esac
    done


    echo


    if [ $switchOfUsingAutoBackupFileIsProvided -gt 0 ] && [ $backupFileNamesPrefixIsProvided -gt 0 ]; then
        wlc-print-message-of-source    'function'    "$nameOfThisFunction"
        wlc-print-error    "Both \"\e[33m--should-create-backups\e[31m\" and \"\e[33m--key-file-names-prefix\e[31m\" were provided."
        wlc-ssh-keygen--print_help    --should-print-separation-line
        return 20
    fi



    if [ $switchOfUsingAutoBackupFileIsProvided -gt 0 ]; then
        keyFileNamesPrefix="$newId"
        keyFileNamesPrefix=${keyFileNamesPrefix// /_}
        # keyFileNamesPrefix=${keyFileNamesPrefix//@/_at_}
    else
        if [ $backupFileNamesPrefixIsProvided -gt 0 ] && [ -z "$keyFileNamesPrefix" ]; then
            wlc-print-message-of-source    'function'    "$nameOfThisFunction"
            wlc-print-error    -1    "Invalid file name provided by \"\e[33m--key-file-names-prefix\e[31m\"."
            wlc-ssh-keygen--print_help    --should-print-separation-line
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


    if [ $shouldCreateCustomBackupFiles -gt 0 ]; then
        privateKeyFilePath=~/.ssh/backup/${keyFileNamesPrefix}
        publicKeyFilePath_=~/.ssh/backup/${keyFileNamesPrefix}'.pub'
    else
        privateKeyFilePath=~/.ssh/id_rsa
        publicKeyFilePath_=~/.ssh/id_rsa.pub
    fi


    if     [ $shouldNotGenerateNewKeysIfFilesAlreadyExist -gt 0 ] \
        && [ -f "$privateKeyFilePath" ] \
        && [ -f "$publicKeyFilePath_" ]
    then

        if [ "$copywritingLanguage" == "zh_CN" ]; then
            colorful -n "以下密钥文件均已存在。不必重新创建 SSH 密钥对。"
        else
            colorful -- 'Both key files already exist. '
            colorful -n 'No new keys will be generated.'    textGreen
        fi

        colorful -n "    $privateKeyFilePath"    textMagenta
        colorful -n "    $publicKeyFilePath_"    textMagenta

    else

        if [ "$copywritingLanguage" == "zh_CN" ]; then
            colorful -n "将会创建或覆盖以下密钥文件："
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

    fi


    if [ $shouldCreateCustomBackupFiles -gt 0 ]; then
        echo
        set-echo-color    textYellow
        if [ "$copywritingLanguage" == "zh_CN" ]; then
            echo "提醒："
            echo "    新创建的 SSH ID 并不在默认的文件中。"
            echo "    使用时须额外指明其密钥文件路径。"
        else
            echo "Remember that:"
            echo "    The new SSH IDs are NOT stored in the default key files."
            echo "    You have to explictly provide the private key file path while using them."
        fi
        clear-echo-color
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

    function print-tip-that-the-default-ssh-key-file-is-used {
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


    local __sshCopyID_remoteID__
    local __sshCopyID_remoteHost__
    local __sshCopyID_remoteUser__


    wlc-validate-host-name-or-ip-address-with-optional-user-name \
        --should-not-print-help-after-printing-error \
        "$_remoteHostRawValue_" \
        --default-user-name='root' \
        __sshCopyID_remoteID__ \
        __sshCopyID_remoteHost__ \
        __sshCopyID_remoteUser__

    stageReturnCode=$?



    wlc-print-message-of-source    'function'    "$nameOfThisFunction"
    echo -e "    remote id:   \"\e[33m${__sshCopyID_remoteID__}\e[0m\""
    echo -e "    remote host: \"\e[33m${__sshCopyID_remoteHost__}\e[0m\""
    echo -e "    remote user: \"\e[33m${__sshCopyID_remoteUser__}\e[0m\""

    if [ $stageReturnCode -gt 0 ] || [ -z "$__sshCopyID_remoteHost__" ] || [ -z "$__sshCopyID_remoteUser__" ]; then

        if [ -z "$__sshCopyID_remoteHost__" ]; then
            colorful -n '    Remote host name or ip address is absent.'    textRed
        fi

        if [ -z "$__sshCopyID_remoteUser__" ]; then
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

        print-tip-that-the-default-ssh-key-file-is-used

    elif [ ! -f "$localSSHKeyFile" ]; then
        wlc-ssh-copy-id--print-help-2
        return 22
    fi





    echo3
    if [ "$copywritingLanguage" == "zh_CN" ]; then
        wlc-print-header    "将 SSH 公开密钥复制到远程主机“\e[96m${__sshCopyID_remoteUser__}\e[32m@\e[35m${__sshCopyID_remoteHost__}\e[32m”……"
    else
        wlc-print-header    "Copying SSH public key to \"\e[96m${__sshCopyID_remoteUser__}\e[32m@\e[35m${__sshCopyID_remoteHost__}\e[32m\"..."
    fi

    if [ -z "$localSSHKeyFile" ]; then
        ssh-copy-id                             "${__sshCopyID_remoteID__}"
    else
        ssh-copy-id    -i "$localSSHKeyFile"    "${__sshCopyID_remoteID__}"
    fi
}

# function wlc-ssh-try-to-pick-one-key-from-backup {
    # local __wlcSSHPickOneKeyFromBackup_privateKeyFilePath__=$1
    # local __wlcSSHPickOneKeyFromBackup_publicKeyFilePath___="${__wlcSSHPickOneKeyFromBackup_privateKeyFilePath__}.pub"

    # function wlc-ssh-try-to-pick-one-key-from-backup--print_error {
    #     if [ ! -f "$__wlcSSHPickOneKeyFromBackup_privateKeyFilePath__" ]; then
    #         if [ "$copywritingLanguage" == 'zh_CN' ]; then
    #             colorful -- "未找到【私钥】文件："    textRed
    #         else
    #             colorful -- "Private key file is missing: "    textRed
    #         fi
    #         colorful -n "    $__wlcSSHPickOneKeyFromBackup_privateKeyFilePath__"    textGreen
    #     fi

    #     if [ ! -f "$__wlcSSHPickOneKeyFromBackup_publicKeyFilePath___" ]; then
    #         if [ "$copywritingLanguage" == 'zh_CN' ]; then
    #             colorful -- "未找到【公钥】文件："    textRed
    #         else
    #             colorful -- "Public key file is missing: "    textRed
    #         fi
    #         colorful -n "    $__wlcSSHPickOneKeyFromBackup_publicKeyFilePath___"    textGreen
    #     fi
    # }

    # function wlc-ssh-try-to-pick-one-key-from-backup--report_success {
    #     local messageColors='textBrightBlue'
    #     if [ "$copywritingLanguage" == 'zh_CN' ]; then
    #         colorful -- '位于“'                        $messageColors
    #         colorful -- '~/.ssh/backup'                textGreen
    #         colorful -- '”文件夹内的一对 SSH 密钥文件“'   $messageColors
    #         colorful -- "$__wlcSSHPickOneKeyFromBackup_privateKeyFilePath__"   textBrightCyan
    #         colorful -- '”和“'                         $messageColors
    #         colorful -- "$__wlcSSHPickOneKeyFromBackup_publicKeyFilePath___"   textBrightCyan
    #         colorful -- '”已被复制到“'                  $messageColors
    #         colorful -- "~/.ssh"                      textMagenta
    #         colorful -- '”文件夹下，并分别更名为“'        $messageColors
    #         colorful -- 'id_rsa'                      textMagenta
    #         colorful -n '”和“'                        $messageColors
    #         colorful -- 'id_rsa.pub'                  textMagenta
    #         colorful -n '”。'                         $messageColors

    #         colorful -- '且复制品“'                    $messageColors
    #         colorful -- 'id_rsa'                      textMagenta
    #         colorful -- '”和“'                        $messageColors
    #         colorful -- 'id_rsa.pub'                  textMagenta
    #         colorful -- '”两个文件的权限模式均被设为 '    $messageColors
    #         colorful -- '700'                         textGreen
    #         colorful -n '。'                          $messageColors
    #     else
    #         colorful -- 'The ssh key files "'                                  $messageColors
    #         colorful -- "$__wlcSSHPickOneKeyFromBackup_privateKeyFilePath__"   textBrightCyan
    #         colorful -- '" and "'                                              $messageColors
    #         colorful -- "$__wlcSSHPickOneKeyFromBackup_publicKeyFilePath___"   textBrightCyan
    #         colorful -- '" under the folder "'                                 $messageColors
    #         colorful -- '~/.ssh/backup'                                        textGreen
    #         colorful -- '" folder have been copied into "'                     $messageColors
    #         colorful -- "~/.ssh"                                               textMagenta
    #         colorful -n '" folder.'                                            $messageColors

    #         colorful -- 'And modes of both duplications, aka, the "'           $messageColors
    #         colorful -- 'id_rsa'                                               textMagenta
    #         colorful -- '" and the "'                                          $messageColors
    #         colorful -- 'id_rsa.pub'                                           textMagenta
    #         colorful -- '" have been set to '                                  $messageColors
    #         colorful -- '700'                                                  textGreen
    #         colorful -n '.'                                                    $messageColors
    #     fi
    # }




	# echo

    # if [ ! -f "$__wlcSSHPickOneKeyFromBackup_privateKeyFilePath__" ] || [ ! -f "$__wlcSSHPickOneKeyFromBackup_publicKeyFilePath___" ]; then
    #     wlc-ssh-try-to-pick-one-key-from-backup--print_error
    #     return 7
    # fi

    # cp    "$__wlcSSHPickOneKeyFromBackup_privateKeyFilePath__"    ~/.ssh/id_rsa
    # cp    "$__wlcSSHPickOneKeyFromBackup_publicKeyFilePath___"    ~/.ssh/id_rsa.pub

    # chmod    700    ~/.ssh/id_rsa
    # chmod    700    ~/.ssh/id_rsa.pub

    # wlc-ssh-try-to-pick-one-key-from-backup--report_success
# }
