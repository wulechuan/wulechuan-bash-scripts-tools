#!/bin/bash

function load_all_shell_scripts_in_a_folder--alphabetically {
    local pathOfRootFolderOfBashFiles="$1"

    if [ ! -d "$pathOfRootFolderOfBashFiles" ]; then
        if [[ $- =~ i ]]; then
            echo -e "function load_all_shell_scripts_in_a_folder--alphabetically:\n    \e[31mFolder not found: '\e[33m$pathOfRootFolderOfBashFiles\e[31m'\e[0m"
        fi

        return 1
    fi

    local allFoundBashFiles=`find "$pathOfRootFolderOfBashFiles" -name "*\.sh"`
    # echo -e "\e[32mDEBUG:\e[35m pathOfRootFolderOfBashFiles:\e[0m $pathOfRootFolderOfBashFiles"
    # echo -e "\e[32mDEBUG:\e[35m allFoundBashFiles:\e[0m $allFoundBashFiles"

    local bashFilePath
    for bashFilePath in $allFoundBashFiles; do
        # echo -e "\e[32mDEBUG: \e[35malphabetically:\e[0m $bashFilePath"
        source    "$bashFilePath"
    done
}



function ___temp_func--wlc_bash_tools--start {
    if [[ ! $- =~ i ]]; then
        unset    -f    ___temp_func--wlc_bash_tools--start

        return 0
    fi


    if [ ! -z "$WLC_BASH_TOOLS___STATE___HAVE_LOADED" ]; then
        unset    -f    ___temp_func--wlc_bash_tools--start

        return 0
    fi





    local coreGlobalConstantsFileName='core-global-constants.sh'
    local coreGlobalConstantsFilePath="${WLC_BASH_TOOLS___FOLDER_PATH}/$coreGlobalConstantsFileName"

    if [ ! -f "${coreGlobalConstantsFilePath}" ]; then

        echo -e "\e[31mERROR: File \"\e[33m${coreGlobalConstantsFilePath}\e[31m\" not found.\e[0m"
        echo -e "\e[31mWLC Bash tools failed to start.\e[0m"
        echo

        unset    -f    ___temp_func--wlc_bash_tools--start

        return 127

    fi

    source    "${coreGlobalConstantsFilePath}"






    local pathOfMarkFileOfInstallationOfNewInstance="$HOME/$WLC_BASH_TOOLS___FILE_NAME___OF_SIGNAL_OF_NEW_INSTANCE_TO_DEPLOY"

    if [ -f "$pathOfMarkFileOfInstallationOfNewInstance" ]; then
        local folderNameOfNewInstanceToDeploy=`cat "$pathOfMarkFileOfInstallationOfNewInstance"`
        local folderPathOfNewInstanceToDeploy="$HOME/$folderNameOfNewInstanceToDeploy"

        if [ -d "$folderPathOfNewInstanceToDeploy" ]; then
            cd        "$folderPathOfNewInstanceToDeploy"
            source    ./'to-install-wlc-bash-tools-locally.sh'

            unset    -f    ___temp_func--wlc_bash_tools--start

            return 0
        else
            echo -e "\e[31mERROR: Folder \"\e[33m${folderPathOfNewInstanceToDeploy}\e[31m\" not found.\e[0m"
            echo -e "\e[31mFailed to deploy new instance of wlc bash tools.\e[0m"
            echo

            local shouldRemoveMarkFileOfInstallationOfNewInstance
            local userInput

            while true; do
                echo -en "Shall we remove the installation mark? [y/n]"
                read    -n 1    -t 5    userInput

                if [ $? -gt 0 ]; then
                    echo
                    shouldRemoveMarkFileOfInstallationOfNewInstance='no'
                    break
                fi

                echo

                case $userInput in
                    [yY])
						shouldRemoveMarkFileOfInstallationOfNewInstance='yes'
						break
						;;

                    [nN])
						shouldRemoveMarkFileOfInstallationOfNewInstance='no'
						break
						;;
                esac

            done

            if [ $shouldRemoveMarkFileOfInstallationOfNewInstance == 'yes' ]; then
                rm    -f    "$pathOfMarkFileOfInstallationOfNewInstance"

                echo -e "Mark file \"\e[33m$pathOfMarkFileOfInstallationOfNewInstance\e[0m\" has been removed."
            fi
        fi
    fi







    local rootFolderNameOfAutoLoadBashes='bash-auto-load-on-start'
    local packageNamesListFileName='packages-to-load.sh'


    local rootFolderPathOfAutoLoadBashFiles="$WLC_BASH_TOOLS___FOLDER_PATH/${rootFolderNameOfAutoLoadBashes}"


    local wlcBashTools_nameOfAllPackagesToAutoLoadOnStart=`cat "${rootFolderPathOfAutoLoadBashFiles}/${packageNamesListFileName}"`



    function load_all_shell_scripts--of_category {
        local categoryFolderName="$1"

        local packageNameToAutoLoad
        local packageNameLength   # some bash env does NOT allow to use negative sub string expression

        for packageNameToAutoLoad in ${wlcBashTools_nameOfAllPackagesToAutoLoadOnStart}; do
            packageNameLength=${#packageNameToAutoLoad}
            packageNameLength=$((packageNameLength-2))
            packageNameToAutoLoad=${packageNameToAutoLoad:1:$packageNameLength}

            local packageFolderPath="${rootFolderPathOfAutoLoadBashFiles}/${packageNameToAutoLoad}"

            if [ -d "$packageFolderPath" ]; then

                if [ -d "$packageFolderPath/$categoryFolderName" ]; then
                    load_all_shell_scripts_in_a_folder--alphabetically     "$packageFolderPath/$categoryFolderName"
                else
                    if [ "$2" != '--category-is-optional' ]; then
                        echo -e "\e[31mCategory folder \"\e[33m${categoryFolderName}\e[31m\" not found under package \"\e[35m$packageNameToAutoLoad\e[31m\" not found. Skipped.\e[0m"
                    fi
                fi

            else
                if [ "$2" != '--category-is-optional' ]; then
                    echo -e "\e[31mPackage \"\e[35m${packageFolderPath}\e[31m\" not found. Skipped.\e[0m"
                fi
            fi
        done
    }





    mkdir    -p    "$WLC_BASH_TOOLS___FOLDER_PATH___OF_CACHE"



    load_all_shell_scripts--of_category    'functions'              --category-is-optional
    load_all_shell_scripts--of_category    'data'                   --category-is-optional
    load_all_shell_scripts--of_category    'interfaces'             --category-is-optional
    load_all_shell_scripts--of_category    'run-actions-batch-1'    --category-is-optional
    load_all_shell_scripts--of_category    'run-actions-batch-2'    --category-is-optional
    load_all_shell_scripts--of_category    'run-actions-batch-3'    --category-is-optional

    WLC_BASH_TOOLS___STATE___HAVE_LOADED='yes'

    unset    -f    ___temp_func--wlc_bash_tools--start
}



___temp_func--wlc_bash_tools--start