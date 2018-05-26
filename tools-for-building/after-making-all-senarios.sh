function ___move_netis_bash_scripts_packages_to_local_machine_package___ {
    local distPath="$___here/$___wlcBashScriptsDistributionRootFolderName"

    local targetPath="$distPath/local-machine-wulechuan/bash-scripts-for-netis-dockers"
    mkdir "$targetPath"

    if [ -d "$distPath/netis-docker-non-root-user" ]; then
        mv "$distPath/netis-docker-non-root-user" "$targetPath"
    fi

    if [ -d "$distPath/netis-docker-root-user" ]; then
        mv "$distPath/netis-docker-root-user"     "$targetPath"
    fi
}

___move_netis_bash_scripts_packages_to_local_machine_package___
