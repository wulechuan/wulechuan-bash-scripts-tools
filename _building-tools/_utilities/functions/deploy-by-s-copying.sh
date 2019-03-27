function deploy-by-s-copying {
    local senarioNameToDeploy=$1
    local idOfTarget_inPatternOf_userAtHost=$2
    local descriptionOfDeploymentTarget=$3

    local defaultDescriptionOfDeploymentTarget="$idOfTarget_inPatternOf_userAtHost:~"

    echo ${descriptionOfDeploymentTarget:=$defaultDescriptionOfDeploymentTarget} 1>/dev/null

    echo
    echo

    local decorationColor=Magenta

    colorful -n "$VE_line_60"                     text${decorationColor}
    colorful -n "Deploying by s-copying"          text${decorationColor}
    colorful -n "$VE_line_60"                     text${decorationColor}

    colorful -- "Senario: "                       textGray
    colorful -n "$senarioNameToDeploy"            textYellow
    colorful -- "     To: "                       textGray
    colorful -n "$descriptionOfDeploymentTarget"  textGreen





    local scopyingSources="
        $___pathOf_buildOutputRootFolder/$senarioNameToDeploy/$___wlcBashToolsRunningFolderName
        $___pathOf_buildOutputRootFolder/$senarioNameToDeploy/.bashrc
    "
    beautiful-scopy   "$scopyingSources"  "$idOfTarget_inPatternOf_userAtHost:~"  0


    colorful -n "$VE_line_60"               text${decorationColor}
}

function beautiful-scopy {
    local scopyingSources=$1
    local idOfTarget_inPatternOf_userAtHost=$2
    local descriptionOfThisCopying=$3

    local shouldNotPrintTitle=0

    if [ "$descriptionOfThisCopying" = "0" ]; then
        shouldNotPrintTitle=1
    fi

    local decorationColor=Magenta

    colorful -n "${VE_line_40:0:35}"        text${decorationColor}

    if [ $shouldNotPrintTitle = 0 ]; then
        [ ${descriptionOfThisCopying:="$idOfTarget_inPatternOf_userAtHost"} ]
        colorful -n "\nS-copying files ${descriptionOfThisCopying}"  textYellow
    fi

    colorful -n '(You may press "Ctrl-c" to skip this)'    text${decorationColor}



    set-echo-color textRed

    scp  -rq  $scopyingSources  "$idOfTarget_inPatternOf_userAtHost"
    local scopyReturnValue=$?

    clear-echo-color


    echo

    if [ $scopyReturnValue = 0 ]; then
        colorful -n '(s-copy done)'                  textGreen
    else
        colorful -- '(s-copy terminated with error code '  textYellow
        colorful -- " $scopyReturnValue "            textBlack  bgndRed
        colorful -n ')'                              textYellow
    fi
}