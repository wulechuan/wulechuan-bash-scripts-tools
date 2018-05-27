function ___install_local_machine_package___ {
    echo ''
    echo ''
    echo -e '\e[34m────────────────────────────────────────────────────────────'
    echo -e "\e[34mINSTALLING BUILT PACKAGES TO: \e[33m~"
    echo -e '\e[34m────────────────────────────────────────────────────────────'


    local distPath="$___here/$___wlcBashScriptsDistributionRootFolderName/_local-machine-wulechuan"

    if [ -d "~/$___wlcBashScriptsFolderName" ]; then
        rm -rf "~/$___wlcBashScriptsFolderName"
    fi

    local targetPath=~
    local itemName

    for itemName in `ls $distPath`
    do
        cp -r "$distPath/$itemName" "$targetPath/"
    done

    if [ -f "$distPath/.bashrc" ]; then
        cp "$distPath/.bashrc" "$targetPath/"
    fi

    if [ -f "$distPath/.minttyrc" ]; then
        cp "$distPath/.minttyrc" "$targetPath/"
    fi

    if [ -d "$distPath/.mintty" ]; then
        cp -r "$distPath/.mintty" "$targetPath/"
    fi
}

___install_local_machine_package___