___unnamedOrganizationDockerDistOldPath="$___here/$___wlcBashScriptsBuildingOutputFolderName"

___unnamedOrganizationDockerDistNewPath="$___unnamedOrganizationDockerDistOldPath/_local-machine-wulechuan/$wlcLocalMachineFolderNameOfBashScriptsForDockers"
mkdir "$___unnamedOrganizationDockerDistNewPath"

if [ -d "$___unnamedOrganizationDockerDistOldPath/unnamed-organization-docker-non-root-user" ]; then
    mv "$___unnamedOrganizationDockerDistOldPath/unnamed-organization-docker-non-root-user" "$___unnamedOrganizationDockerDistNewPath"
fi

if [ -d "$___unnamedOrganizationDockerDistOldPath/unnamed-organization-docker-root-user" ]; then
    mv "$___unnamedOrganizationDockerDistOldPath/unnamed-organization-docker-root-user"     "$___unnamedOrganizationDockerDistNewPath"
fi

unset ___unnamedOrganizationDockerDistOldPath
unset ___unnamedOrganizationDockerDistNewPath