function ___fill_variable_values_via_building_configurations___ {
    local fileToModifyWithoutExt="$___here/lib/_anyone-_anywhere/$wlcBashScriptsRunningFolderName/start"

    cp "$fileToModifyWithoutExt.template" "$fileToModifyWithoutExt.filled-template"

    local fileToModify="$fileToModifyWithoutExt.filled-template"
    sed -i "s/dummyValueBashScriptsFolderName/$wlcBashScriptsRunningFolderName/g" "$fileToModify"
}


___fill_variable_values_via_building_configurations___