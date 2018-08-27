function deploy-by-s-copying {
    local senarioNameToDeploy=$1
    local idOfTarget_inPatternOf_userAtHost=$2
    local descriptionOfDeploymentTarget=$3

    local defaultDescriptionOfDeploymentTarget="$idOfTarget_inPatternOf_userAtHost:~"

    echo ${descriptionOfDeploymentTarget:=$defaultDescriptionOfDeploymentTarget} 1>/dev/null

    echo
    echo

    local logString=''
    local decorationColor=Magenta

    append-colorful-string-to logString -n "$VE_line_60"                     text${decorationColor}
    append-colorful-string-to logString -n "Deploying by s-copying"          text${decorationColor}
    append-colorful-string-to logString -n "$VE_line_60"                     text${decorationColor}

    append-colorful-string-to logString -- "Senario: "                       textGray
    append-colorful-string-to logString -n "$senarioNameToDeploy"            textYellow
    append-colorful-string-to logString -- "     To: "                       textGray
    append-colorful-string-to logString -n "$descriptionOfDeploymentTarget"  textGreen

    echo -en "$logString"




    local scopyingSources="
        $___here/$___wlcBashScriptsBuildingOutputFolderName/$senarioNameToDeploy/$wlcBashScriptsRunningFolderName
        $___here/$___wlcBashScriptsBuildingOutputFolderName/$senarioNameToDeploy/.bashrc
    "
    beautiful-scopy   "$scopyingSources"  "$idOfTarget_inPatternOf_userAtHost:~"  0


    logString=''
    append-colorful-string-to logString -- "$VE_line_60"               text${decorationColor}
    echo -e "$logString"
}

function beautiful-scopy {
    local scopyingSources=$1
    local idOfTarget_inPatternOf_userAtHost=$2
    local descriptionOfThisCopying=$3

    local shouldNotPrintTitle=0

    if [ "$descriptionOfThisCopying" = "0" ]; then
        shouldNotPrintTitle=1
    fi

    local logString=''
    local decorationColor=Magenta

    append-colorful-string-to logString -n "${VE_line_40:0:35}"        text${decorationColor}

    if [ $shouldNotPrintTitle = 0 ]; then
        [ ${descriptionOfThisCopying:="$idOfTarget_inPatternOf_userAtHost"} ]
        colorful -n "\nS-copying files ${descriptionOfThisCopying}"  textYellow
    fi

    append-colorful-string-to logString -- '(You may press "Ctrl-c" to skip this)'    text${decorationColor}
    echo -e "$logString"



    set-echo-color textRed

    scp  -rq  $scopyingSources  "$idOfTarget_inPatternOf_userAtHost"
    local scopyReturnValue=$?

    clear-echo-color


    logString='\n'

    if [ $scopyReturnValue = 0 ]; then
        append-colorful-string-to logString -n '(s-copy done)'                  textGreen
    else
        append-colorful-string-to logString -- '(s-copy terminated with error code '  textYellow
        append-colorful-string-to logString -- " $scopyReturnValue "            textBlack  bgndRed
        append-colorful-string-to logString -n ')'                              textYellow
    fi

    echo -en "$logString"
}