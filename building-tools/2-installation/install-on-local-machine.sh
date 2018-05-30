function ___install_dist_to_local_machine_package {
    echo ''
    echo ''
    echo -e '\e[34m────────────────────────────────────────────────────────────'
    echo -e "\e[34mInstalling all built packages to: \e[33m~"
    echo -e '\e[34m────────────────────────────────────────────────────────────'


    local distPath="$___here/$___wlcBashScriptsBuildingOutputFolderName/_local-machine-wulechuan"

    if [ -d "~/$wlcBashScriptsRunningFolderName" ]; then
        rm -rf "~/$wlcBashScriptsRunningFolderName"
    fi


    local targetPath=~
    local itemName

    for itemName in `ls $distPath`
    do
        cp -r "$distPath/$itemName" "$targetPath/"
    done


    local hiddenItemName
    for hiddenItemName in $___possibleHiddenFilesAndFoldersToCopy; do
        if [ -f "$distPath/$hiddenItemName" ]; then
            cp "$distPath/$hiddenItemName" "$targetPath/"
        fi

        if [ -d "$distPath/$hiddenItemName" ]; then
            cp -rf "$distPath/$hiddenItemName" "$targetPath/"
        fi
    done
}

___install_dist_to_local_machine_package