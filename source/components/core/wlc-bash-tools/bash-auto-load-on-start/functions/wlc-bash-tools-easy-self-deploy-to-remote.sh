function wlc_bash_tools--easy_self_deploy_to_remote {
    # Usage:
    #     <this function>    --to-host="<remote host name or ip>"    [ --source-package-folder-name="<package folder name>" | --source-package-folder-path="<package folder path>" ]    [ --remote-user-name="<user name used at remote>" ]
    #
    # Examples:
    #     <this function>    --to-host="192.168.3.19"
    #     <this function>    --to-host="wulechuan@192.168.3.19"
    #     <this function>    --to-host="192.168.3.19"    --remote-user-name="wulechaun"
    #     <this function>    --to-host="192.168.3.19"    --source-package-folder-name="my-personal-data-server"
    #     <this function>    --to-host="192.168.3.19"    --source-package-folder-path="/d/backup/my-old-data-server-in-1979"

    local duplicatedArgumentEncountered

    local remoteHostNameOrIPAddressIsProvided=0
    local remoteUserNameIsProvededSeparately=0
    local sourceFolderNameIsProvided=0
    local sourceFolderPathIsProvided=0

    local remoteHostRawValue
    local remoteUserName
    local sourceFolderName
    local sourceFolderPath

    local currentArgument

    while true; do
        if [ $# -eq 0 ]; then
            break
        fi

        currentArgument="$1"
        shift

        case "$currentArgument" in
            --to-host=*)
                if [ $remoteHostNameOrIPAddressIsProvided -gt 0 ]; then
                    duplicatedArgumentEncountered='--to-host='
                    break
                fi
                remoteHostRawValue=${currentArgument:10}
                remoteHostNameOrIPAddressIsProvided=1
                ;;

            --remote-user-name=*)
                if [ $remoteUserNameIsProvededSeparately -gt 0 ]; then
                    duplicatedArgumentEncountered='--remote-user-name='
                    break
                fi
                remoteUserName=${currentArgument:19}
                remoteUserNameIsProvededSeparately=1
                ;;

            --source-package-folder-name=*)
                if [ $sourceFolderNameIsProvided -gt 0 ]; then
                    duplicatedArgumentEncountered='--source-package-folder-name='
                    break
                fi
                sourceFolderName=${currentArgument:29}
                sourceFolderNameIsProvided=1
                ;;

            --source-package-folder-path=*)
                if [ $sourceFolderPathIsProvided -gt 0 ]; then
                    duplicatedArgumentEncountered='--source-package-folder-path='
                    break
                fi
                sourceFolderPath=${currentArgument:29}
                sourceFolderPathIsProvided=1
                ;;

        esac
    done


    # echo -e "\e[30;42mDEBUG\e[0m\n    remoteHostRawValue=\"\e[33m${remoteHostRawValue}\e[0m\"\n    remoteUserName=\"\e[33m${remoteUserName}\e[0m\"\n    sourceFolderName=\"\e[33m${sourceFolderName}\e[0m\"\n    sourceFolderPath=\"\e[33m${sourceFolderPath}\e[0m\""

    if [ ! -z "$duplicatedArgumentEncountered" ]; then
        echo
        print-error    "Duplicated argument \"\e[33m${duplicatedArgumentEncountered}\e[31m\"."
        return 99
    fi

	if     [[ ! "$remoteHostRawValue" =~ ^([_a-zA-Z]+[\._a-zA-Z0-9@]*)?@?[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}$ ]] \
		&& [[ ! "$remoteHostRawValue" =~ ^([_a-zA-Z]+[\._a-zA-Z0-9@]*)?@?[_a-zA-Z]+[\._a-zA-Z0-9]*$      ]]; then
        echo
		print-error    "Invalid value \"\e[33m$remoteHostRawValue\e[31m\" for argument \"\e[32m--to-host=\e[31m\"."
		return 1
	fi

    local remoteHostNameOrIPAddress="$remoteHostRawValue"
    local remoteUserNameInRemoteHostRawValue

    if [[ "$remoteHostRawValue" =~ @ ]]; then
        remoteUserNameInRemoteHostRawValue=${remoteHostRawValue%@*}
        remoteHostNameOrIPAddress=${remoteHostRawValue##*@}
    fi

    # echo -e "\e[30;42mDEBUG\e[0m\n    remoteHostNameOrIPAddress=\"\e[33m${remoteHostNameOrIPAddress}\e[0m\"\n    remoteUserNameInRemoteHostRawValue=\"\e[33m${remoteUserNameInRemoteHostRawValue}\e[0m\""

    if [ $remoteUserNameIsProvededSeparately -gt 0 ] && [ ! -z "$remoteUserNameInRemoteHostRawValue" ] && [ "$remoteUserName" != "$remoteUserNameInRemoteHostRawValue" ]; then
        echo
        print-error    "Remote user name was provided both in \e[33m--to-host=\"${remoteHostRawValue}\"\e[31m and \e[33m--remote-user-name=\"${remoteUserName}\"\e[31m."
        return 2
    fi

    if [ ! -z "$remoteUserNameInRemoteHostRawValue" ]; then
        remoteUserName="$remoteUserNameInRemoteHostRawValue"
    fi

    if [ -z "$remoteUserName" ]; then
        remoteUserName='root'
        echo
        colorful -- 'Remote user name'    textGreen
        colorful -- ' was not provided. Thus "'
        colorful -- 'root'    textMagenta
        colorful -n '" is assumed.'
        echo
    fi


    local remoteID="$remoteUserName@$remoteHostNameOrIPAddress"



    if [ $sourceFolderNameIsProvided -gt 0 ] && [ $sourceFolderPathIsProvided -gt 0 ]; then
        print-error    "Both \"\e[33m--source-package-folder-name\e[31m\" and \"\e[33m--source-package-folder-path\e[31m\" were provided."
        return 20
    fi



    local sourceFolderPathOfWLCBashToolDistributionToDeployToRemoteMachine

    if [ $sourceFolderNameIsProvided -eq 0 ] && [ $sourceFolderPathIsProvided -eq 0 ]; then
        colorful -- 'Neither "'
        colorful -- '--source-package-folder-name'    textGreen
        colorful -- '" nor "'
        colorful -- '--source-package-folder-path'    textGreen
        colorful -n '" were provided.'

        colorful -- 'Thus the default "'
        colorful -- "$WLC_BASH_TOOLS___FOLDER_NAME___OF_DEFAULT_PACKAGE_TO_DEPLOY_TO_REMOTE"    textMagenta
        colorful -n '" is assumed.'

        sourceFolderName="$WLC_BASH_TOOLS___FOLDER_NAME___OF_DEFAULT_PACKAGE_TO_DEPLOY_TO_REMOTE"
    fi

    if [ $sourceFolderPathIsProvided -gt 0 ]; then
        sourceFolderPathOfWLCBashToolDistributionToDeployToRemoteMachine="$sourceFolderPath"
    else
        sourceFolderPathOfWLCBashToolDistributionToDeployToRemoteMachine="$WLC_BASH_TOOLS___FOLDER_PATH___OF_WLC_BASH_TOOLS_FOR_OTHER_MACHINES/$sourceFolderName"
    fi


    if [ ! -d "$sourceFolderPathOfWLCBashToolDistributionToDeployToRemoteMachine" ]; then
        print-error    'The evaluated folder path of package to depoly to a remote machine is invalid, which is'

        colorful -- '    "'    textRed
        colorful -- "$sourceFolderPathOfWLCBashToolDistributionToDeployToRemoteMachine"    textYellow
        colorful -n '"'    textRed
        echo

        colorful -n 'Involved variables:'    textRed

        colorful -- '$WLC_BASH_TOOLS___FOLDER_PATH___OF_WLC_BASH_TOOLS_FOR_OTHER_MACHINES="'    textRed
        colorful -- "$WLC_BASH_TOOLS___FOLDER_PATH___OF_WLC_BASH_TOOLS_FOR_OTHER_MACHINES"    textYellow
        colorful -n '"'    textRed

        colorful -- 'argument: --source-package-folder-name="'    textRed
        colorful -- "$sourceFolderName"    textYellow
        colorful -n '"'    textRed

        colorful -- 'argument: --source-package-folder-path="'    textRed
        colorful -- "$sourceFolderPath"    textYellow
        colorful -n '"'    textRed

        echo
        colorful -n 'Thus, the deployment to a remote machine is not possible.'    textRed
        echo3

        return 2
    fi





    local stageReturnCode



    wlc--ssh_copy_id    "$remoteID"


    wlc-bash-tools-scopy-to-remote-for-later-deployment-at-remote \
        --from        "$sourceFolderPathOfWLCBashToolDistributionToDeployToRemoteMachine" \
        --to-host     "$remoteID"
    stageReturnCode=$?
    if [ $stageReturnCode -gt 0 ]; then
        return $stageReturnCode
    fi



    # wlc_bash_tools--design_host_name_for_remote_machine    "$remoteHostNameOrIPAddress"

    

    echo3
    echo -n "wlc bash tools auto deployment "; print-DONE
    echo3
}

function wlc_bash_tools--design_host_name_for_remote_machine {
    local remoteHostNameOrIPAddress="${1}"
    local sourceFolderPathOfWLCBashToolDistributionToDeployToRemoteMachine="${2}"
    local remoteHostNameDefaultPrefix='computer'

    local tempWorkingFolderName
    local tempWorkingFolderPath

    while true; do
        tempWorkingFolderName="wlc-bash-tools-package-for-remote-installation--$RANDOM"
        tempWorkingFolderPath="$WLC_BASH_TOOLS___FOLDER_PATH___OF_CACHE/$tempWorkingFolderName"

        if [ ! -d "$tempWorkingFolderPath" ]; then
            mkdir -p "$tempWorkingFolderPath"
            break
        fi
    done





    echo3
    print-header "Design the hostname for the remote machine:"


    local safeStringToUseInHostName="ip-${remoteHostNameOrIPAddress//./-}"
    local preferredHostNameFileFolderPath="$sourceFolderPathOfWLCBashToolDistributionToDeployToRemoteMachine/$WLC_BASH_TOOLS___FOLDER_NAME/$WLC_BASH_TOOLS___FOLDER_NAME___OF_ASSETS"
    local preferredHostNameFilePath="$preferredHostNameFileFolderPath/default-computer-name"

    local computerNamePrefixForRemoteMachine="$remoteHostNameDefaultPrefix"


    if [ -f "$preferredHostNameFilePath" ]; then
        local computerNamePrefixViaFile=`cat "$preferredHostNameFilePath"`

        if [ ! -z "$computerNamePrefixViaFile" ]; then
            computerNamePrefixForRemoteMachine="$computerNamePrefixViaFile"
        fi
    fi

    local computerNameForRemoteMachine="${computerNamePrefixForRemoteMachine}-${safeStringToUseInHostName}"

    colorful -- 'Please input the '                                       textGreen
    colorful -- 'hostname'                                                textMagenta
    colorful -n ' for the remote machine, simply for easy recognition.'   textGreen

    colorful -n 'You may skip this by press the <ENTER> key directly.'

    colorful -- '(60 seconds for decision, default is "'
    colorful -- "$computerNameForRemoteMachine"   textGreen
    colorful -n '")'

    colorful -- "hostname: "

    local            userInputComputerNameForRemoteMachine
    read    -t 60    userInputComputerNameForRemoteMachine
    stageReturnCode=$?
    if [ "$stageReturnCode" -gt 0 ]; then
        echo
    fi

    if [ -z "$userInputComputerNameForRemoteMachine" ]; then
        echo '<Skipped>'
    else
        computerNameForRemoteMachine="$userInputComputerNameForRemoteMachine"
    fi





    local nameOfFileForCarryingComputerNameOfRemoteMachine='computer-name'
    local pathOfFileForCarryingComputerNameOfRemoteMachine="$tempWorkingFolderPath/$nameOfFileForCarryingComputerNameOfRemoteMachine"
    echo "$computerNameForRemoteMachine" > "$pathOfFileForCarryingComputerNameOfRemoteMachine"

    echo
    colorful -- 'The hostname of the remote machine('
    colorful -- "$remoteHostNameOrIPAddress"    textYellow
    colorful -n ') will be:'
    colorful -n "$computerNameForRemoteMachine"        textGreen
    echo
    echo





    echo3
    scp        -q    "$pathOfFileForCarryingComputerNameOfRemoteMachine"    "$remoteID:~/$WLC_BASH_TOOLS___FOLDER_NAME/$WLC_BASH_TOOLS___FOLDER_NAME___OF_ASSETS"




    echo3

    print-header "Removing temp folder..."
    colorful -n "Removing folder:"    textRed
    colorful -n "    \"$tempWorkingFolderPath\""    textYellow
    rm    -rf    "$tempWorkingFolderPath"
}