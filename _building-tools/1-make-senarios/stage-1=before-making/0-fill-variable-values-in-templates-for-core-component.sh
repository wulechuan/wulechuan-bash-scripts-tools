# function wlc_bash_tools--building--fill_variable_values_in_templates--for_core_component {
#     local fileNameWithoutExt="core-global-constants"
#     local sourceFileLocation="$___pathOf_sourceRootFolderOfAllComponents/core/$___wlcBashToolsRunningFolderName"

#     local sourceFilePath="$sourceFileLocation/${fileNameWithoutExt}.wlc-bash-template"
#     local targetFilePath="$sourceFileLocation/${fileNameWithoutExt}.wlc-filled-bash-template"

#     cp    "$sourceFilePath"    "$targetFilePath"

#     sed    -i    "s/dummyValueBashToolsFolderName/$___wlcBashToolsRunningFolderName/g"    "$targetFilePath"

#     unset    -f    wlc_bash_tools--building--fill_variable_values_in_templates--for_core_component
# }


# wlc_bash_tools--building--fill_variable_values_in_templates--for_core_component