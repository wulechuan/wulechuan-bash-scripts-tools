function ___move_unnamedOrg_bash_script_dist_packages_into_local_machine_package___ {
    local distPath="$___here/$___wlcBashScriptsBuildingOutputFolderName"

    local targetPath="$distPath/_local-machine-wulechuan/bash-scripts-for-unnamedOrg-dockers"
    mkdir "$targetPath"

    if [ -d "$distPath/unnamedOrg-docker-non-root-user" ]; then
        mv "$distPath/unnamedOrg-docker-non-root-user" "$targetPath"
    fi

    if [ -d "$distPath/unnamedOrg-docker-root-user" ]; then
        mv "$distPath/unnamedOrg-docker-root-user"     "$targetPath"
    fi
}


___move_unnamedOrg_bash_script_dist_packages_into_local_machine_package___
