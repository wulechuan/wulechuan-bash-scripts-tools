function deploy-by-copying {
    local senarioNameToDeploy=$1
    local descriptionOfThisDepolyment=$2
    local deploymentTargetLocation=$3

    echo ${descriptionOfThisDepolyment:=$senarioNameToDeploy} 1>/dev/null
    echo ${deploymentTargetLocation:=~}                       1>/dev/null # Do NOT quote the ~

    echo
    echo

    local logString=''
    local decorationColor=Cyan

    append-colorful-string-to logString -n "$VE_line_60"                text${decorationColor}
    append-colorful-string-to logString -n "Deploying by copying"       text${decorationColor}
    append-colorful-string-to logString -n "$VE_line_60"                text${decorationColor}

    append-colorful-string-to logString -- "Senario: "                  textGray
    append-colorful-string-to logString -n "$senarioNameToDeploy"       textYellow
    append-colorful-string-to logString -- "     To: "                  textGray
    append-colorful-string-to logString -n "$deploymentTargetLocation"  textGreen

    echo -en "$logString"


    # ./dist/<senario>
    local distPathAsCopyingSourceLocation="$___here/$___wlcBashScriptsBuildingOutputFolderName/$senarioNameToDeploy"


    local sourceItemName
    local sourceItemPath
    local targetFolderPath

    for sourceItemName in `ls -A $distPathAsCopyingSourceLocation`; do
        sourceItemPath="$distPathAsCopyingSourceLocation/$sourceItemName"

        # 如果遇到文件，则直接复制，-f 强迫覆盖旧有文件。
        if [    -f "$sourceItemPath" ]; then
            if [ "$sourceItemName" == 'install' ]; then
                continue
            fi

            cp  -f "$sourceItemPath"   "$deploymentTargetLocation/"
        fi


        # 如果遇到文件夹，则先删除可能存在的旧目标文件夹，而后复制整个源文件夹。
        if [    -d "$sourceItemPath" ]; then
            targetFolderPath="$deploymentTargetLocation/$sourceItemName"

            if [    -d "$targetFolderPath" ]; then
                rm -rf "$targetFolderPath"
            fi

            cp -rf "$sourceItemPath"   "$deploymentTargetLocation/"
        fi
    done

    
    logString=''
    append-colorful-string-to logString -- "$VE_line_60"                text${decorationColor}
    echo -e "$logString"
}
