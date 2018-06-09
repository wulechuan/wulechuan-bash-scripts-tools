function ___fill_variable_values_in_core_lib_templates {
    local fileToModifyWithoutExt="$___here/$___wlcBashScriptsSourceLibCoreFolderName/$wlcBashScriptsRunningFolderName/start"

    cp  "$fileToModifyWithoutExt.template"  "$fileToModifyWithoutExt.filled-template"

    local fileToModify="$fileToModifyWithoutExt.filled-template"
    sed -i "s/dummyValueBashScriptsFolderName/$wlcBashScriptsRunningFolderName/g" "$fileToModify"
}


___fill_variable_values_in_core_lib_templates