function wlc_bash_tools--building--deploy_some_senarios {
    mkdir    -p    "$___pathOf_defaultDeploymentFolder"

    echo
    echo

    local sourceSenarioSubPath
    local builtSenarioSubPath
    local builtSenarioPath
    local senarioDeploymentScriptFile

    for sourceSenarioSubPath in $___subPathsOf_senariosToDeploy; do
        builtSenarioSubPath="$sourceSenarioSubPath"

        builtSenarioPath="$___pathOf_buildOutputRootFolder/$builtSenarioSubPath"

        if [ ! -d "$builtSenarioPath" ]; then
            colorful -n "$VE_line_80"              textRed
            colorful -- "Built senario \""         textRed
            colorful -- "$builtSenarioSubPath"     textYellow
            colorful -n "\" not found. Skipped"    textRed
            colorful -n "$VE_line_80"              textRed

            continue
        fi


        senarioDeploymentScriptFile="$___pathOf_sourceRootFolderOfAllSenarios/$builtSenarioSubPath/$___senarioSpecificDeployActionFileName"

        if [ -f "$senarioDeploymentScriptFile" ]; then

            colorful -n "$VE_line_80"                  textMagenta
            colorful -- "Deploying "                   textMagenta
            colorful -- "$builtSenarioSubPath"         textGreen
            colorful -n " by its own $___senarioSpecificDeployActionFileName"    textMagenta
            colorful -n "$VE_line_80"                  textMagenta

            source "$senarioDeploymentScriptFile"

            echo
            echo

        else

            colorful -n "$VE_line_80"              textMagenta
            colorful -- "Deploying "               textMagenta
            colorful -- "$builtSenarioSubPath"     textGreen
            colorful -n " to default location"     textMagenta
            colorful -n "$VE_line_80"              textMagenta

            mv \
                "$___pathOf_buildOutputRootFolder/$builtSenarioSubPath/" \
                "$___pathOf_defaultDeploymentFolder"

            colorful -n "DONE" textBlack bgndGreen
            echo

            echo
            echo
        fi

    done

    echo
    echo

    unset -f wlc_bash_tools--building--deploy_some_senarios
}

wlc_bash_tools--building--deploy_some_senarios