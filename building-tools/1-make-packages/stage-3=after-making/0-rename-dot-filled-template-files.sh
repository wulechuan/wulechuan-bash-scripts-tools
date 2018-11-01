function ___wlc_bash_scripts_rename_dot_filled_template_into_dot_sh {
    local searchingRoot="$___here/$___wlcBashScriptsBuildingOutputFolderName"
    local foundFiles=`find "$searchingRoot" -name "*.filled-template"`

    local foundFile
    local foundFileDirname
    local foundFileBasename

    local logString=''

    if [ ! -z "$foundFiles" ]; then
        logString='\n\n'

        append-colorful-string-to logString -n $VE_line_60          textBlue

        append-colorful-string-to logString -- 'Renaming: '         textBlue
        append-colorful-string-to logString -n '*.filled-tempalte'  textYellow
        append-colorful-string-to logString -- 'Deleting: '         textRed
        append-colorful-string-to logString -n '*.tempalte'         textRed

        append-colorful-string-to logString -n $VE_line_60          textBlue

        echo -en "$logString"


        for foundFile in $foundFiles
        do
            foundFileDirname=`dirname $foundFile`
            foundFileBasename=`basename $foundFile`
            foundFileBasename=${foundFileBasename%.*}

            rm "$foundFileDirname/$foundFileBasename.template"
            mv "$foundFile" "$foundFileDirname/$foundFileBasename.sh"
        done
    fi


    unset -f ___wlc_bash_scripts_rename_dot_filled_template_into_dot_sh
}


___wlc_bash_scripts_rename_dot_filled_template_into_dot_sh