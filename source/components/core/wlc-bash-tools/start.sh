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
        return 0
    fi


    if [ ! -z "$WLC_BASH_TOOLS___STATE___HAVE_LOADED" ]; then
        return 0
    fi

    local coreGlobalConstantsFileName='core-global-constants.sh'
    local coreGlobalConstantsFilePath="${WLC_BASH_TOOLS___FOLDER_PATH}/$coreGlobalConstantsFileName"

    if [ ! -f "${coreGlobalConstantsFilePath}" ]; then

        echo -e "\e[31mERROR: File \"\e[33m${coreGlobalConstantsFilePath}\e[31m\" not found.\e[0m"
        echo -e "\e[31mWLC Bash tools failed to start.\e[0m"
        echo

        return 127

    fi

    source    "${coreGlobalConstantsFilePath}"





    mkdir    -p    "$WLC_BASH_TOOLS___FOLDER_PATH___OF_CACHE"
    mkdir    -p    "$WLC_BASH_TOOLS___FOLDER_PATH___OF_SIGNALS"





    local pathOfSignalFileOfDeploymentOfNewInstance="$WLC_BASH_TOOLS___FOLDER_PATH___OF_SIGNALS/$WLC_BASH_TOOLS___FILE_NAME___OF_SIGNAL_OF_NEW_INSTANCE_TO_DEPLOY"

    if [ -f "$pathOfSignalFileOfDeploymentOfNewInstance" ]; then
        local folderNameOfNewInstanceToDeploy=`cat "$pathOfSignalFileOfDeploymentOfNewInstance"`
        local folderPathOfNewInstanceToDeploy="$HOME/$folderNameOfNewInstanceToDeploy"

        if [ -f       "$folderPathOfNewInstanceToDeploy/to-install-wlc-bash-tools-locally.sh" ]; then
            source    "$folderPathOfNewInstanceToDeploy/to-install-wlc-bash-tools-locally.sh"    --should-accord-to-standard-auto-deployment-signal-file


            local logoutSignalFilePath="$HOME/$WLC_BASH_TOOLS___FOLDER_NAME___OF_SIGNALS/$WLC_BASH_TOOLS___FILE_NAME___OF_SIGNAL_OF_AUTO_LOGGING_OUT"
            if [ -f "$logoutSignalFilePath" ]; then
                rm    -f    "$logoutSignalFilePath"
                if [ $? -eq 0 ] && [[ $- =~ i ]]; then
                    echo -e "\e[33mSignal file \"\e[35m$logoutSignalFilePath\e[33m\" has been removed.\e[0m"
                fi

                logout
            fi

            return 0
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
unset    -f    ___temp_func--wlc_bash_tools--start