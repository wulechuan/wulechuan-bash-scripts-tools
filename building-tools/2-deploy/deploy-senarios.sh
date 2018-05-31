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
    # echo -e  `colorful  $VE_line_70            textGreen`
    echo -en `colorful  " Installation Done "  textBlack  bgndGreen`
    # echo -e  `colorful  $VE_line_70            textGreen`
    echo
}

___wlc_bash_scripts_deploy_all_desired_senarios