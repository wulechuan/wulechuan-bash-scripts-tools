function ___wlc_bash_scripts_make_all_packages_for_all_senarios {
    function copy_core_lib_pack_for_one_senario {
        local distributionPath=$1


        local coreLibSourceFullPath
        local coreLibContentName
        local coreLibBashScriptsFolderPath
        local coreLibBashScriptsContentName
        local coreLibBashScriptsContentFullPath


        echo -e '  '`colorful 'Core' textGreen`

        coreLibSourceFullPath="$___here/$___wlcBashScriptsSourceLibCoreFolderName"
        coreLibBashScriptsFolderPath="$coreLibSourceFullPath/$wlcBashScriptsRunningFolderName"


        if [ ! -d "$coreLibBashScriptsFolderPath" ]; then
            echo -en '       '
            echo -en '"'
            echo -en `colorful "$wlcBashScriptsRunningFolderName" textYellow`
            echo -en '"'
            echo -e  `colorful "folder not found"                 textRed`

            exit 2
        else
            for coreLibBashScriptsContentName in `ls $coreLibBashScriptsFolderPath`
            do
                coreLibBashScriptsContentFullPath="$coreLibBashScriptsFolderPath/$coreLibBashScriptsContentName"

                if [ -f "$coreLibBashScriptsContentFullPath" ]; then

                    if [[ $coreLibBashScriptsContentName =~ .filled-template$ ]]; then
                        echo -en '        Filled: '
                        echo -e  `colorful " $coreLibBashScriptsContentName " textBlack bgndMagenta`
                    fi

                fi
            done
        fi

        echo -e `clear-color`

        for coreLibContentName in `ls $coreLibSourceFullPath`
        do
            cp -r "$coreLibSourceFullPath/$coreLibContentName" "$distributionPath/"
        done


        local hiddenItemName
        for hiddenItemName in $___possibleHiddenFilesAndFoldersToCopy; do
            if [ -f "$coreLibSourceFullPath/$hiddenItemName" ]; then
                cp "$coreLibSourceFullPath/$hiddenItemName" "$distributionPath/"
            fi

            if [ -d "$coreLibSourceFullPath/$hiddenItemName" ]; then
                cp -rf "$coreLibSourceFullPath/$hiddenItemName" "$distributionPath/"
            fi
        done
    }



    function make_one_package_for_one_senario {
        local outputLocationOfBuilding=$1
        local senarioName=$2
        echo
        echo
        echo -e  `colorful  $VE_line_60            textBlue`
        echo -en `colorful "Processing senario:"   textBlue`
        echo -e  `colorful " $senarioName"         textGreen`
        echo -e  `colorful  $VE_line_60            textBlue`

        local configurationFolder="$___here/senario-specific-configurations/$senarioName"

        local fullPathOfChosenLibsDotSh="$configurationFolder/chosen-libs.sh"

        if [ ! -f "$fullPathOfChosenLibsDotSh" ]; then
            return
        fi
        source "$fullPathOfChosenLibsDotSh"



        local   distributionPath="$outputLocationOfBuilding/$senarioName"
        mkdir "$distributionPath"


        copy_core_lib_pack_for_one_senario "$distributionPath"


        local libSourceSubPath
        local libSourceFullPath
        local libContentName
        local libBashScriptsFolderPath
        local libBashScriptsContentName
        local libBashScriptsContentFullPath

        local allPackages=""
        local fileNameInCurrentPackage
        local fileInCurrentPackage

        local allChosenLibsFolder=$___allChosenLibsFolder
        unset ___allChosenLibsFolder

        for libSourceSubPath in $allChosenLibsFolder
        do
            echo -en '  Lib: '
            echo -e  `colorful "$libSourceSubPath" textBlue`

            libSourceFullPath="$___here/$___wlcBashScriptsSourceLibFolderName/$libSourceSubPath"
            libBashScriptsFolderPath="$libSourceFullPath/$wlcBashScriptsRunningFolderName"


            if [ ! -d "$libBashScriptsFolderPath" ]; then
                echo -en '       '
                echo -en '"'
                echo -en `colorful "$wlcBashScriptsRunningFolderName" textYellow`
                echo -en '"'
                echo -e  `colorful "folder not found"                 textRed`
            else
                for libBashScriptsContentName in `ls $libBashScriptsFolderPath`
                do
                    libBashScriptsContentFullPath="$libBashScriptsFolderPath/$libBashScriptsContentName"

                    # 如果遇到文件夹，则：
                    #   1) 将其记入 `allPackages` 变量，且报告之。
                    #   2) 检查其中是否有 `components` 文件夹存在。若存在，则报告之。
                    #   3) 检查其中是否有已经填写的模板文件存在。若存在，则报告之。
                    if [ -d "$libBashScriptsContentFullPath" ]; then
                        # 遇到文件夹。

                        allPackages="$allPackages$libBashScriptsContentName "

                        if [ -d "$libBashScriptsContentFullPath/components" ]; then
                            # 找到其中的 `components` 文件夹。
                            echo -en '       Package: '
                            echo -e  `colorful "$libBashScriptsContentName"`
                        fi

                        for fileNameInCurrentPackage in `ls $libBashScriptsContentFullPath`;
                        do
                            fileInCurrentPackage="$libBashScriptsContentFullPath/$fileNameInCurrentPackage"

                            if [ -f "$fileInCurrentPackage" ]; then
                                # 是文件。

                                if [[ $fileNameInCurrentPackage =~ .filled-template$ ]]; then
                                    # 是文件，而非文件夹，且文件扩展名为 `.filled-template`。
                                    echo -en '        Filled: '
                                    echo -e  `colorful " $fileNameInCurrentPackage " textBlack bgndMagenta`
                                fi

                            fi
                        done

                    fi
                done
            fi

            echo -e `clear-color`

            for libContentName in `ls $libSourceFullPath`
            do
                cp -r "$libSourceFullPath/$libContentName" "$distributionPath/"
            done


            local hiddenItemName
            for hiddenItemName in $___possibleHiddenFilesAndFoldersToCopy; do
                if [ -f "$libSourceFullPath/$hiddenItemName" ]; then
                    cp "$libSourceFullPath/$hiddenItemName" "$distributionPath/"
                fi

                if [ -d "$libSourceFullPath/$hiddenItemName" ]; then
                    cp -rf "$libSourceFullPath/$hiddenItemName" "$distributionPath/"
                fi
            done
        done

        local fullPathOfPackagesDotSh="$distributionPath/$wlcBashScriptsRunningFolderName/packages.sh"
        echo "__wlcBashScriptsAllChosenPacakges=\"$allPackages\"" > "$fullPathOfPackagesDotSh"

        local fullPathOfFileAfterMaking="$configurationFolder/after-making-this-senario.sh"
        if [ -f "$fullPathOfFileAfterMaking" ]; then
            echo -e "Taking action: \e[35mafter-making-this-senario.sh\e[0;0m"
            source "$fullPathOfFileAfterMaking"
        else
            echo -e "\e[33mNo actions to take after making this senario.\e[0;0m"
        fi

        echo -e  `colorful  $VE_line_60  textBlue`
    }




    local outputLocationOfBuilding="$___here/$___wlcBashScriptsBuildingOutputFolderName"
    local senarioName

    if [    -d "$outputLocationOfBuilding" ]; then
        rm -rf "$outputLocationOfBuilding"
    fi

    mkdir "$outputLocationOfBuilding"

    for senarioName in $___senarioNamesToBuild
    do
        make_one_package_for_one_senario  $outputLocationOfBuilding  $senarioName
    done
}


___wlc_bash_scripts_make_all_packages_for_all_senarios