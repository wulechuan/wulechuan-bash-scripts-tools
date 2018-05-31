function ___wlc_bash_scripts_rename_dot_filled_template_into_dot_sh {
    local searchingRoot="$___here/$___wlcBashScriptsBuildingOutputFolderName"
    local foundFiles=`find "$searchingRoot" -name "*.filled-template"`

    local foundFile
    local foundFileDirname
    local foundFileBasename

    if [ ! -z "$foundFiles" ]; then
        echo
        echo
        echo -e  `colorful  $VE_line_60          textBlue`
        echo -en `colorful  "Renaming: "         textBlue`
        echo -e  `colorful  "*.filled-tempalte"  textYellow`
        echo -en `colorful  "Deleting: "         textRed`
        echo -e  `colorful  "*.tempalte"         textRed`
        echo -e  `colorful  $VE_line_60          textBlue`


        for foundFile in $foundFiles
        do
            foundFileDirname=`dirname $foundFile`
            foundFileBasename=`basename $foundFile`
            foundFileBasename=${foundFileBasename%.*}

            rm "$foundFileDirname/$foundFileBasename.template"
            mv "$foundFile" "$foundFileDirname/$foundFileBasename.sh"
        done
    fi
}


___wlc_bash_scripts_rename_dot_filled_template_into_dot_sh