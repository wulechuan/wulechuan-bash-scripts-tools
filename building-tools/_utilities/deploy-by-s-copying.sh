function deploy-by-s-copying {
    local senarioNameToDeploy=$1
    local idOfTarget_inPatternOf_userAtHost=$2
    local descriptionOfDeploymentTarget=$3

    local defaultDescriptionOfDeploymentTarget="$idOfTarget_inPatternOf_userAtHost:~"

    echo
    echo

    echo ${descriptionOfDeploymentTarget:=$defaultDescriptionOfDeploymentTarget} 1>/dev/null

    if [ 1 ]; then
        echo -e  `colorful  " Deploying by s-copying "    textBlack  bgndMagenta`
        echo -e  `colorful  $VE_line_60                   textMagenta`
    else
        echo -en `colorful  " Deploying by s-copying "    textBlack  bgndMagenta`
        echo -e  `colorful  "────────────────────────────────────"   textMagenta`    
        echo
    fi

    echo -en `colorful  "Senario: "                       textBlue`
    echo -e  `colorful  "$senarioNameToDeploy"            textYellow`

    echo -en "     "
    echo -en `colorful  "To: "                            textBlue`
    echo -e  `colorful  "$descriptionOfDeploymentTarget"  textGreen`

    echo -e  `colorful  $VE_line_40                       textMagenta`

    local scopyingSources="
        $___here/$___wlcBashScriptsBuildingOutputFolderName/$senarioNameToDeploy/$wlcBashScriptsRunningFolderName
        $___here/$___wlcBashScriptsBuildingOutputFolderName/$senarioNameToDeploy/.bashrc
    "
    beautiful-scopy   "$scopyingSources"  "$idOfTarget_inPatternOf_userAtHost:~"  0


    echo -e  `colorful  $VE_line_60                     textMagenta`
}

function beautiful-scopy {
    local scopyingSources=$1
    local idOfTarget_inPatternOf_userAtHost=$2
    local descriptionOfThisCopying=$3

    local shouldNotPrintTitle=0

    if [ "$descriptionOfThisCopying" = "0" ]; then
        shouldNotPrintTitle=1
    fi

    if [ $shouldNotPrintTitle = 0 ]; then
        [ ${descriptionOfThisCopying:="$idOfTarget_inPatternOf_userAtHost"} ]
        echo
        echo -e  `colorful  "S-copying files ${descriptionOfThisCopying}"  textYellow`
    fi

    echo -e  `colorful  '(You may press "Ctrl-c" to skip this)'  textMagenta`



    echo -en `set-color textRed`
    scp  -rq  $scopyingSources  "$idOfTarget_inPatternOf_userAtHost"
    local scopyReturnValue=$?

    # echo -en `clear-color`

    if [ $scopyReturnValue = 0 ]; then
        echo -e  `colorful "(s-copy done)"                  textGreen`
    else
        echo -en `colorful "(s-copy done with error code "  textYellow`
        echo -en `colorful " $scopyReturnValue "            textBlack  bgndRed`
        echo -e  `colorful ")"                              textYellow`
    fi
}