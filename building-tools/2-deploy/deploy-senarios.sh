function ___wlc_bash_scripts_deploy_all_desired_senarios {
    local sourceLocationAllSenarios="$___here/senario-specific-configurations"
    local senarioName
    local senarioDeploymentScriptFile

    for senarioName in $___senarioNamesToBuild
    do
        senarioDeploymentScriptFile="$sourceLocationAllSenarios/$senarioName/deploy.sh"

        if [ -f "$senarioDeploymentScriptFile" ]; then
            source "$senarioDeploymentScriptFile"
        fi
    done

    echo
    echo
    echo

    local logString=''

    # append-colorful-string-to logString  --  $VE_line_70            textGreen
    append-colorful-string-to logString  --  ' Installation Done '  textBlack  bgndGreen
    # append-colorful-string-to logString  --  $VE_line_70            textGreen

    echo -e "$logString"
}

___wlc_bash_scripts_deploy_all_desired_senarios