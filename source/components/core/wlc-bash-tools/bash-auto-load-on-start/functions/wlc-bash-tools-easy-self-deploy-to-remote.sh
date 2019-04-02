function wlc_bash_tools--easy_self_deploy_to_remote {
    local sourceFolderNameOfWLCBashToolDistributionToDeployToRemoteMachine='netis-docker-bpc-sup-as-root-for-wulechuan'
    local remoteMachineHostNameOrIPAddress="$2"
    local remoteMachineUserName="$3"



    if [ -z "$remoteMachineHostNameOrIPAddress" ] || [ -z "$remoteMachineUserName" ]; then
        colorful -- 'function "'            textRed
        colorful -- 'wlc_bash_tools--easy_self_deploy_to_remote'    textGreen
        colorful -n '" error.'              textRed
        colorful -n 'Too few arguments.'    textYellow

        return 1
    fi




    local sourceFolderPathOfWLCBashToolDistributionToDeployToRemoteMachine="$WLC_BASH_TOOLS___FOLDER_PATH___OF_WLC_BASH_TOOLS_FOR_OTHER_MACHINES/$sourceFolderNameOfWLCBashToolDistributionToDeployToRemoteMachine"

    if [ ! -d "$sourceFolderPathOfWLCBashToolDistributionToDeployToRemoteMachine" ]; then
        colorful -n 'According to bash global variable:'    textRed
        colorful -n '    $WLC_BASH_TOOLS___FOLDER_PATH___OF_WLC_BASH_TOOLS_FOR_OTHER_MACHINES'    textYellow
        colorful -n 'and local variable:'    textRed
        colorful -n '    $sourceFolderNameOfWLCBashToolDistributionToDeployToRemoteMachine'       textYellow
        colorful -n 'the path:'    textRed
        colorful -- '    "'    textRed
        colorful -- "$sourceFolderPathOfWLCBashToolDistributionToDeployToRemoteMachine"           textYellow
        colorful -n '"'    textRed
        colorful -n 'is not valid.'    textRed
        colorful -n 'Thus, the deployment to a remote machine is not possible.'    textRed

        return 2
    fi




    local stageReturnCode



    local remoteID="$remoteMachineUserName@$remoteMachineHostNameOrIPAddress"


    wlc--ssh_copy_id    "$remoteID"


    wlc-bash-tools-scopy-to-remote-for-later-deployment-at-remote \
        --from        "$sourceFolderPathOfWLCBashToolDistributionToDeployToRemoteMachine" \
        --to-host     "$remoteID"





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





    echo
    echo
    echo
    print-header "Design the hostname for the remote machine:"


    local safeStringToUseInHostName="ip-${remoteMachineHostNameOrIPAddress//./-}"
    local preferredHostNameFileFolderPath="$sourceFolderPathOfWLCBashToolDistributionToDeployToRemoteMachine/$WLC_BASH_TOOLS___FOLDER_NAME/$WLC_BASH_TOOLS___FOLDER_NAME___OF_ASSETS"
    local preferredHostNameFilePath="$preferredHostNameFileFolderPath/default-computer-name"

    local computerNamePrefixForRemoteMachine='computer'


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
    colorful -- "$remoteMachineHostNameOrIPAddress"    textYellow
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


    echo3
    echo -n "wlc bash tools auto deployment "; print-DONE
    echo3
}