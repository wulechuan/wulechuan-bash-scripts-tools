function deploy-by-copying {
    local senarioNameToDeploy=$1
    local descriptionOfThisDepolyment=$2
    local deploymentTargetLocation=$3

    echo
    echo

    echo ${descriptionOfThisDepolyment:=$senarioNameToDeploy} 1>/dev/null
    echo ${deploymentTargetLocation:=~}                       1>/dev/null # Do NOT quote ~

    if [ 1 ]; then
        echo -e  `colorful  " Deploying by copying "       textBlack  bgndCyan`
        echo -e  `colorful  $VE_line_60                    textCyan`
    else
        echo -en `colorful  " Deploying by copying "       textBlack  bgndCyan`
        echo -e  `colorful  "──────────────────────────────────────"  textCyan`
        echo
    fi

    echo -en `colorful  "Senario: "                  textBlue`
    echo -e  `colorful  "$senarioNameToDeploy"       textYellow`

    echo -en "     "
    echo -en `colorful  "To: "                       textBlue`
    echo -e  `colorful  "$deploymentTargetLocation"  textGreen`

    echo -e  `colorful  $VE_line_60                  textCyan`


    local deploymentTarget="$deploymentTargetLocation/$wlcBashScriptsRunningFolderName"
    if [    -d "$deploymentTarget" ]; then
        rm -rf "$deploymentTarget"
    fi


    local distPathAsCopyingSourceLocation="$___here/$___wlcBashScriptsBuildingOutputFolderName/$senarioNameToDeploy"


    local itemName
    for itemName in `ls $distPathAsCopyingSourceLocation`
    do
        cp      -r "$distPathAsCopyingSourceLocation/$itemName"        "$deploymentTargetLocation"
    done


    local hiddenItemName
    for hiddenItemName in $___possibleHiddenFilesAndFoldersToCopy; do
        if [    -f "$distPathAsCopyingSourceLocation/$hiddenItemName" ]; then
            cp  -f "$distPathAsCopyingSourceLocation/$hiddenItemName"  "$deploymentTargetLocation"
        fi

        if [    -d "$distPathAsCopyingSourceLocation/$hiddenItemName" ]; then
            cp -rf "$distPathAsCopyingSourceLocation/$hiddenItemName"  "$deploymentTargetLocation"
        fi
    done
}
