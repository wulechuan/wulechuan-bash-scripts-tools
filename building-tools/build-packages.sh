function ___wlc_bash_scripts_make_all_packages_for_all_senarios {
    local wlcBashScriptsDistributionRootPath="$___here/$___wlcBashScriptsBuildingOutputFolderName"
    local _machineUserCombination

    if [ -d "$wlcBashScriptsDistributionRootPath" ]; then
        rm -rf "$wlcBashScriptsDistributionRootPath"
    fi

    mkdir "$wlcBashScriptsDistributionRootPath"

    for _machineUserCombination in `ls $___here/senario-specific-configurations`
    do
        ___wlc_bash_scripts_make_one_package_for_one_senario  $wlcBashScriptsDistributionRootPath  $_machineUserCombination
    done
}

function ___wlc_bash_scripts_make_one_package_for_one_senario {
    local distributionRootPath=$1
    local machineUserCombination=$2
    echo ''
    echo ''
    echo -e "Processing senario: \e[32m$machineUserCombination\e[0;0m"
    echo '────────────────────────────────────────────────────────────'

    local configurationFolder="$___here/senario-specific-configurations/$machineUserCombination"

    local fullPathOfChosenLibsDotSh="$configurationFolder/_chosen-libs.sh"

    if [ ! -f "$fullPathOfChosenLibsDotSh" ]; then
        return
    fi
    source "$fullPathOfChosenLibsDotSh"



    local   distributionPath="$distributionRootPath/$machineUserCombination"
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
        echo -e "  Lib: \e[34m$libSourceSubPath\e[0;0m"

        libSourceFullPath="$___here/lib/$libSourceSubPath"
        libBashScriptsFolderPath="$libSourceFullPath/$wlcBashScriptsRunningFolderName"


        if [ ! -d "$libBashScriptsFolderPath" ]; then
            echo -e "       \"\e[33m$wlcBashScriptsRunningFolderName\e[0;0m\" folder \e[31mnot found\e[0;0m";
        else
            for libBashScriptsContentName in `ls $libBashScriptsFolderPath`
            do
                libBashScriptsContentFullPath="$libBashScriptsFolderPath/$libBashScriptsContentName"

                if [ -d "$libBashScriptsContentFullPath" ]; then

                    allPackages="$allPackages$libBashScriptsContentName "

                    if [ -d "$libBashScriptsContentFullPath/components" ]; then
                        echo -e "       Package: \e[32m$libBashScriptsContentName\e[0;0m"
                    fi

                    for fileNameInCurrentPackage in `ls $libBashScriptsContentFullPath`;
                    do
                        fileInCurrentPackage="$libBashScriptsContentFullPath/$fileNameInCurrentPackage"

                        if [ -f "$fileInCurrentPackage" ]; then

                            if [[ $fileNameInCurrentPackage =~ .filled-template$ ]]; then
                                echo -e "        Filled: \e[33m$fileNameInCurrentPackage"
                            fi

                        fi
                    done

                fi
            done
        fi

        echo -e "\e[0;0m"

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
}

___wlc_bash_scripts_make_all_packages_for_all_senarios
