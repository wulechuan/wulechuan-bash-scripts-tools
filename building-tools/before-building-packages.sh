function ___fill_variable_values_via_building_configurations___ {
    local fileToModify="$___here/lib/_anyone-_anywhere/$___wlcBashScriptsFolderName/start.sh"
    sed -i "s/dummyValueBashScriptsFolderName/$___wlcBashScriptsFolderName/g" "$fileToModify"
}


___fill_variable_values_via_building_configurations___