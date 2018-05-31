function ___fill_variable_values_in_lib_templates_for_common_senarios {
    local fileToModifyWithoutExt="$___here/$___wlcBashScriptsSourceLibFolderName/_anyone-_anywhere/$wlcBashScriptsRunningFolderName/start"

    cp  "$fileToModifyWithoutExt.template"  "$fileToModifyWithoutExt.filled-template"

    local fileToModify="$fileToModifyWithoutExt.filled-template"
    sed -i "s/dummyValueBashScriptsFolderName/$wlcBashScriptsRunningFolderName/g" "$fileToModify"
}


___fill_variable_values_in_lib_templates_for_common_senarios