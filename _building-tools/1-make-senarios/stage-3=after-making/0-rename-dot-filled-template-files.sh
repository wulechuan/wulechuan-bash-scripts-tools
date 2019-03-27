function wlc_bash_tools--building--after_making_all_senarios--rename___dot_filled_templates___into___dot_sh {
    local dotFileExtensionToFocusOn='.wlc-filled-bash-template'
    local dotFileExtensionToDelete='.wlc-bash-template'

    # local searchingRootPath="$___pathOf_buildOutputRootFolder"
    local searchingRootSubPath="$___subPathOf_buildOutputRootFolder"
    local foundFiles=`find "$searchingRootSubPath" -name "*$dotFileExtensionToFocusOn"`

    local foundFile
    local foundFileFileContainingSubPath
    local foundFileBaseName
    local foundFileNameWithoutExt
    local lengthOfSearchingRootSubPath=${#searchingRootSubPath}



    if [ ! -z "$foundFiles" ]; then

        echo
        echo
        colorful -n "$VE_line_70"    textBlue

        colorful -- 'Renaming: '    textBlue
        colorful -- "*$dotFileExtensionToFocusOn"    textGreen
        colorful -- ' into '        textBlue
        colorful -n '*.sh'          textMagenta

        colorful -- 'Deleting dupliactions of: '    textRed
        colorful -n '*.wlc-bash-tempalte'           textYellow

        colorful -n "$VE_line_70"    textBlue



        for foundFile in $foundFiles; do
            foundFileFileContainingSubPath=`dirname   "$foundFile"`
            foundFileBaseName=`basename "$foundFile"`
            foundFileNameWithoutExt=${foundFileBaseName%.*}

            colorful -- "$foundFileNameWithoutExt"      textMagenta
            colorful -n "$dotFileExtensionToFocusOn"    textGreen
            colorful -- "  at: "
            colorful -n "${foundFileFileContainingSubPath:$lengthOfSearchingRootSubPath}/"        textBlue

            rm    "$foundFileFileContainingSubPath/${foundFileNameWithoutExt}${dotFileExtensionToDelete}"
            mv    "$foundFile"    "$foundFileFileContainingSubPath/$foundFileNameWithoutExt.sh"
        done

        colorful -n "$VE_line_70"    textBlue
        echo
        echo
    fi


    unset -f wlc_bash_tools--building--after_making_all_senarios--rename___dot_filled_templates___into___dot_sh
}


wlc_bash_tools--building--after_making_all_senarios--rename___dot_filled_templates___into___dot_sh