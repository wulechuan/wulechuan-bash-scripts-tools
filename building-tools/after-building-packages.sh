function ___rename_dot_filled_template_into_dot_sh___ {
    local searchingRoot="$___here/$___wlcBashScriptsDistributionRootFolderName"
    local foundFiles=`find "$searchingRoot" -name "*.filled-template"`

    local foundFile
    local foundFileDirname
    local foundFileBasename

    if [ ! -z "$foundFiles" ]; then
        echo
        echo
        echo -e  '\e[34m────────────────────────────────────────────────────────────'
        echo -en "\e[34mRENAMING: \e[33m*.filled-tempalte"
        echo -en "\e[0;0m; "
        echo -e  "\e[34mDELETING: \e[33m*.tempalte"
        echo -e  '\e[34m────────────────────────────────────────────────────────────'


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

___rename_dot_filled_template_into_dot_sh___
