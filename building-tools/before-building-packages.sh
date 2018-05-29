function ___fill_variable_values_via_building_configurations___ {
    local fileToModify="$___here/lib/_anyone-_anywhere/$wlcBashScriptsRunningFolderName/start.sh"
    sed -i "s/dummyValueBashScriptsFolderName/$wlcBashScriptsRunningFolderName/g" "$fileToModify"
}


___fill_variable_values_via_building_configurations___