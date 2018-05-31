function ___wlc_bash_scripts_make_all_packages_for_all_senarios {
    function ___wlc_bash_scripts_make_one_package_for_one_senario {
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


        local libSourceSubPath
        local libSourceFullPath
        local libContentName
        local libContentAllPackages
        local libBashScriptsFolderPath
        local libBashScriptsContentName
        local libBashScriptsContentFullPath

        local allPackages=""
        local fileNameInCurrentPackage
        local fileInCurrentPackage

        for libSourceSubPath in $___allChosenLibsFolder
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

                    if [ -d "$libBashScriptsContentFullPath" ]; then

                        allPackages="$allPackages$libBashScriptsContentName "

                        if [ -d "$libBashScriptsContentFullPath/components" ]; then
                            echo -en '       Package: '
                            echo -e  `colorful "$libBashScriptsContentName"`
                        fi

                        for fileNameInCurrentPackage in `ls $libBashScriptsContentFullPath`;
                        do
                            fileInCurrentPackage="$libBashScriptsContentFullPath/$fileNameInCurrentPackage"

                            if [ -f "$fileInCurrentPackage" ]; then

                                if [[ $fileNameInCurrentPackage =~ .filled-template$ ]]; then
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

        unset ___allChosenLibsFolder
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
        ___wlc_bash_scripts_make_one_package_for_one_senario  $outputLocationOfBuilding  $senarioName
    done
}


___wlc_bash_scripts_make_all_packages_for_all_senarios