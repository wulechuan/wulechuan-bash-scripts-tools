function ___move_netis_bash_scripts_packages_to_local_machine_package___ {
    local distPath="$___here/$___wlcBashScriptsDistributionRootFolderName"

    local targetPath="$distPath/local-machine-wulechuan/bash-scripts-for-netis-dockers"
    mkdir "$targetPath"

    mv "$distPath/netis-docker-non-root-user" "$targetPath"
    mv "$distPath/netis-docker-root-user"     "$targetPath"
}

___move_netis_bash_scripts_packages_to_local_machine_package___
