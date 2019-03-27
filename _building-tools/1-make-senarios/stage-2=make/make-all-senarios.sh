function wlc_bash_tools--building--make_all_senarios {
    if [    -d "$___pathOf_buildOutputRootFolder" ]; then
        rm -rf "$___pathOf_buildOutputRootFolder"
    fi
    mkdir    -p    "$___pathOf_buildOutputRootFolder"




    function copy_one_file_item {

        # --source-file-sub-path-to-source-components-root="a sub path";
        local sourceFileParentFolderSubPathToSourceComponentsRoot="${1:49}"


        # --source-file-full-path="a file path here"
        local sourceFilePath="${2:24}"


        # --target-folder-sub-path-to-building-root="a folder path here"
        local targetFolderSubPath="${3:42}"


        # The value '--should-append-content-if-target-file-alreay-exists' has effect; otherwise doesn't
        local argumentForAppendingControl="$4"



        # echo -e "DEBUG:\e[35m copy_one_file_item\e[0m"
        # echo -e '  sourceFileParentFolderSubPathToSourceComponentsRoot:'
        # echo -e "    $sourceFileParentFolderSubPathToSourceComponentsRoot"
        # echo -e '  sourceFilePath:'
        # echo -e "    $sourceFilePath"
        # echo -e '  targetFolderSubPath:'
        # echo -e "    $targetFolderSubPath"
        # echo -e '  argumentForAppendingControl:'
        # echo -e "    $argumentForAppendingControl"


        local logIndentationBase='             '
        local shouldAppendContentIfTargetFileAlreadyExists='no'
        local appendingEnabledAccordingTo=''

        local sourceFileName=`basename    "$sourceFilePath"`
        local targetFileName="$sourceFileName"


        local sourceFileNameSuffix
        if [ "${#sourceFileName}" -gt $___lengthOfFileNameSuffixForEnablingAppending ]; then
            sourceFileNameSuffix=${sourceFileName:(-$___lengthOfFileNameSuffixForEnablingAppending)}

            if [ "$sourceFileNameSuffix" == "$___fileNameSuffixForEnablingAppending" ]; then
                shouldAppendContentIfTargetFileAlreadyExists='yes'
                appendingEnabledAccordingTo="According to file name suffix '\e[32m$___fileNameSuffixForEnablingAppending\e[0m'"
                targetFileName=${targetFileName:0:(-$___lengthOfFileNameSuffixForEnablingAppending)}
            fi
        fi

        if     [ "$shouldAppendContentIfTargetFileAlreadyExists" != 'yes' ] \
            && [ "$argumentForAppendingControl" == '--should-append-content-if-target-file-alreay-exists' ]; then
            shouldAppendContentIfTargetFileAlreadyExists='yes'
            appendingEnabledAccordingTo="According to function argument '\e[32m$argumentForAppendingControl\e[0m'"
        fi

        # echo
        # echo "${logIndentationBase}     sourceFileName='$sourceFileName'"
        # echo "${logIndentationBase}SourceFileNameuffix='$sourceFileNameSuffix'"
        # echo "${logIndentationBase}     targetFileName='$targetFileName'"

        local targetFolderPath="${___pathOf_buildOutputRootFolder}/$targetFolderSubPath"
        local targetFilePath="$targetFolderPath/$targetFileName"
        local targetFileSubPath="$targetFolderSubPath/$targetFileName"


        if     [ "$shouldAppendContentIfTargetFileAlreadyExists" == 'yes' ]; then
            if [ -f "$targetFilePath" ]; then
                colorful -n "${logIndentationBase}${appendingEnabledAccordingTo},"
                colorful -- "${logIndentationBase}appending content to file \""
                # colorful -- "${logIndentationBase}"
                colorful -- "${targetFileName}"    textBlack    bgndGreen
                # echo
                colorful -n "\" in target folder:"
                colorful -- "${logIndentationBase}    ./"
                colorful -n "${___subPathOf_buildOutputRootFolder}/${targetFolderSubPath}/"
                echo

                local stringToInsertBetweenFiles='\n'

                if     [  "$targetFileName" == '.bashrc' ] \
                    || [  "$targetFileName" == '.bashprofile' ] \
                    || [[ "$targetFileName" =~ \.sh$ ]]; then
                    stringToInsertBetweenFiles=$stringToInsertBetweenFiles"\n\n\n"
                    stringToInsertBetweenFiles=$stringToInsertBetweenFiles"\n# ${VE_line_80:0:78}"
                    stringToInsertBetweenFiles=$stringToInsertBetweenFiles"\n# ${sourceFileParentFolderSubPathToSourceComponentsRoot}/${sourceFileName}"
                    stringToInsertBetweenFiles=$stringToInsertBetweenFiles"\n# ${VE_line_80:0:78}"
                    stringToInsertBetweenFiles=$stringToInsertBetweenFiles"\n"
                fi

                echo   -e    "$stringToInsertBetweenFiles"    >>    "$targetFilePath"
            fi

            cat          "$sourceFilePath"                    >>    "$targetFilePath"
        else
            if [ -f "$targetFilePath" ]; then
                colorful -- "${logIndentationBase}Overwritting file \""    textRed
                # colorful -- "${logIndentationBase}"
                colorful -- "${targetFileName}"    textBlack    bgndMagenta
                # echo
                colorful -n "\" in target folder:"    textRed
                colorful -- "${logIndentationBase}    ./"    textRed
                colorful -n "${___subPathOf_buildOutputRootFolder}/${targetFolderSubPath}/"    textRed
                echo
            fi

            cp    -f    "$sourceFilePath"    "$targetFolderPath"
        fi
    }

    function copy_one_item--recursively_if_its_a_folder {
        local sourceItemFullPath="${2:24}"      # --source-item-full-path="a file path here"

        # echo -e "DEBUG:\e[33m copy_one_item--recursively_if_its_a_folder\e[0m"
        # echo -e "sourceItemFullPath: $sourceItemFullPath"

        if [ -f "$sourceItemFullPath" ]; then

            copy_one_file_item    $* # The length of the term 'item' happens to be equal to the length of 'file'. :)

        else

            local sourceItemSubPathToSourceComponentsRoot="${1:49}"    # --source-item-sub-path-to-source-components-root="a sub path";
            local targetFolderSubPath="${3:42}"                        # --target-folder-sub-path-to-building-root="a folder path here"

            # Triple `shift`s prepares for the '$*' used later
            shift
            shift
            shift

            local directChildItem
            local thisFolderName=`basename    "$sourceItemFullPath"`


            # echo -e "DEBUG:\e[33m copy_one_item--recursively_if_its_a_folder\e[0m"
            # echo -e "sourceItemSubPathToSourceComponentsRoot: $sourceItemSubPathToSourceComponentsRoot"
            # echo -e "targetFolderSubPath: $targetFolderSubPath"
            # echo -e "thisFolderName: $thisFolderName"
            # echo -e "will create dir: ${___pathOf_buildOutputRootFolder}/$targetFolderSubPath/$thisFolderName"
            # return;

            mkdir     -p    "${___pathOf_buildOutputRootFolder}/$targetFolderSubPath/$thisFolderName"

            for directChildItem in `ls -A "$sourceItemFullPath"`; do
                copy_one_item--recursively_if_its_a_folder \
                    --source-item-sub-path-to-source-components-root="$sourceItemSubPathToSourceComponentsRoot/$thisFolderName" \
                    --source-item-full-path="$sourceItemFullPath/$directChildItem" \
                    --target-folder-sub-path-to-building-root="$targetFolderSubPath/$thisFolderName" \
                    $*
            done

        fi
    }

    function make_one_senario--copy_all_chosen_compnents_to {
        local senarioSubPath="$2"
        # local senarioName=`basename    "$senarioSubPath"`

        local senarioSourceFolderPath="$___pathOf_sourceRootFolderOfAllSenarios/$senarioSubPath"
        local senarioChosenComponentsListFilePath="$senarioSourceFolderPath/$___senarioChosenComponentsListFileName"

        if [ ! -f "$senarioChosenComponentsListFilePath" ]; then
            return
        fi



        echo
        echo

        colorful -n "$VE_line_70"           textBlue
        colorful -- "Building senario:"   textBlue
        colorful -n " $senarioSubPath"      textGreen
        colorful -n "$VE_line_70"           textBlue

        source "$senarioChosenComponentsListFilePath"



        local senarioDistributionSubPath="$senarioSubPath"
        local senarioDistributionPath="$___pathOf_buildOutputRootFolder/$senarioDistributionSubPath"
        mkdir    -p    "$senarioDistributionPath"






        local allChosenComponentsSubPath=(
            "$___coreComponentFolderName"
        )

        local componentSourceSubPath

        for componentSourceSubPath in $___allChosenOptionalComponentsSubPath; do
            allChosenComponentsSubPath+=("optional/$componentSourceSubPath")
        done

        unset ___allChosenOptionalComponentsSubPath





        local allAutoLoadPackagesNameList=""
        local autoLoadModuleIndex=0

        for componentSourceSubPath in ${allChosenComponentsSubPath[@]}; do
            colorful -- '  Component: '

            if [ "$componentSourceSubPath" == "$___coreComponentFolderName" ]; then
                colorful -n "$componentSourceSubPath"             textCyan
            else
                colorful -- "[${componentSourceSubPath%%/*}] "    textBlue
                colorful -n "${componentSourceSubPath#*/}"        textCyan
            fi


            # 要么是 "./components/core/"
            # 要么是 "./components/optional/<component name>/"
            local componentSourceFullPath="$___pathOf_sourceRootFolderOfAllComponents/$componentSourceSubPath"





            # 直接位于 "./components/core/" 或 "./components/optional/<component name>/" 文件夹下的元素。
            local componentSourceFolder_directChild_name
            local componentSourceFolder_directChild_path
            local componentSourceFolder_directChild_subPath

            for componentSourceFolder_directChild_name in `ls -A "$componentSourceFullPath"`; do
                componentSourceFolder_directChild_path="$componentSourceFullPath/$componentSourceFolder_directChild_name"
                componentSourceFolder_directChild_subPath="$componentSourceSubPath/$componentSourceFolder_directChild_name"

                if     [ -d "$componentSourceFolder_directChild_path" ] \
                    && [ $componentSourceFolder_directChild_name == "$___wlcBashToolsRunningFolderName" ]
                then
                    continue # 暂时略过 wlc-bash-tools 文件夹，留待下文处理。
                fi


                if   [ -f "$componentSourceFolder_directChild_path" ]; then
                    colorful -- '       File: '
                    colorful -n "$componentSourceFolder_directChild_name"    textGreen
                elif [ -d "$componentSourceFolder_directChild_path" ]; then
                    colorful -- '     Folder: '
                    colorful -n "$componentSourceFolder_directChild_name"    textYellow
                fi


                copy_one_item--recursively_if_its_a_folder \
                    --source-item-sub-path-to-source-components-root="$componentSourceFolder_directChild_subPath" \
                    --source-item-full-path="$componentSourceFolder_directChild_path" \
                    --target-folder-sub-path-to-building-root="$senarioDistributionSubPath" \
                    # --should-append-content-if-target-file-alreay-exists
            done





            # 要么是 "./components/core/wlc-bash-tools/"
            # 要么是 "./components/optional/<component name>/wlc-bash-tools/"
            local componentSource_wlcBashToolsFolder_fullPath="$componentSourceFullPath/$___wlcBashToolsRunningFolderName"





            if [ ! -d "$componentSource_wlcBashToolsFolder_fullPath" ]; then

                colorful -- '             '
                colorful -- 'the folder'       textRed
                colorful -- ' "'
                colorful -- "$___wlcBashToolsRunningFolderName"    textYellow
                colorful -- '" '
                colorful -n "was not found"    textRed

            else

                local distribution_wlcBashTools_Path="$senarioDistributionPath/$___wlcBashToolsRunningFolderName"
                local distribution_wlcBashTools_subPath="$senarioSubPath/$___wlcBashToolsRunningFolderName"

                if [ ! -d "$distribution_wlcBashTools_Path" ]; then
                    mkdir "$distribution_wlcBashTools_Path/"
                fi



                local componentSourceSubPathSegmentLast # not full path
                local componentSourceSubPathParentPath # not full path
                local componentSourceSubPathSegmentSecondLast # not full path

                componentSourceSubPathSegmentLast=`basename       "$componentSourceSubPath"`
                componentSourceSubPathParentPath=`dirname         "$componentSourceSubPath"`
                componentSourceSubPathSegmentSecondLast=`basename "$componentSourceSubPathParentPath"`


                if     [ "$componentSourceSubPathSegmentSecondLast" == '.' ] \
                    || [ "$componentSourceSubPathSegmentSecondLast" == 'optional' ]; then
                    componentSourceSubPathSegmentSecondLast=''
                else
                    componentSourceSubPathSegmentSecondLast=${componentSourceSubPathSegmentSecondLast}'-'
                fi


                local componentDistributionCoreName="${componentSourceSubPathSegmentSecondLast}${componentSourceSubPathSegmentLast}"



                local componentSource_wlcBashTools_childName
                local componentSource_wlcBashTools_childPath
                local componentSource_wlcBashTools_childSubPath

                for componentSource_wlcBashTools_childName in `ls -A "$componentSource_wlcBashToolsFolder_fullPath"`; do
                    componentSource_wlcBashTools_childPath="$componentSource_wlcBashToolsFolder_fullPath/$componentSource_wlcBashTools_childName"
                    componentSource_wlcBashTools_childSubPath="$componentSourceSubPath/$___wlcBashToolsRunningFolderName/$componentSource_wlcBashTools_childName"

                    if [ -f "$componentSource_wlcBashTools_childPath" ]; then
                        # 遇到文件。

                        colorful -- '       File: '
                        colorful -n "$componentSource_wlcBashTools_childName"    textGreen

                        # 直接复制到 wlc-bash-tools 文件夹内。
                        copy_one_file_item \
                            --source-file-sub-path-to-source-components-root="$componentSource_wlcBashTools_childSubPath" \
                            --source-file-full-path="$componentSource_wlcBashTools_childPath" \
                            --target-folder-sub-path-to-building-root="$distribution_wlcBashTools_subPath" \
                            # --should-append-content-if-target-file-alreay-exists

                    else
                        # 遇到文件夹。

                        if [ "$componentSource_wlcBashTools_childName" == "$___rootFolderNameOfAutoLoadBashes" ]; then

                            autoLoadModuleIndex=$((autoLoadModuleIndex+1))
                            local autoLoadModuleDitributionName="${autoLoadModuleIndex}-${componentDistributionCoreName}"
                            local autoLoadModuleDitributionPath="${distribution_wlcBashTools_Path}/${___rootFolderNameOfAutoLoadBashes}/${autoLoadModuleDitributionName}"

                            mkdir    -p    "$autoLoadModuleDitributionPath"

                            local sourceAutoLoadFolder_childName
                            local sourceAutoLoadFolder_childPath
                            # local sourceAutoLoadFolder_childSubPath

                            for sourceAutoLoadFolder_childName in `ls -A "$componentSource_wlcBashTools_childPath"`; do
                                sourceAutoLoadFolder_childPath="$componentSource_wlcBashTools_childPath/$sourceAutoLoadFolder_childName"
                                # sourceAutoLoadFolder_childSubPath="$componentSource_wlcBashTools_childSubPath/$sourceAutoLoadFolder_childName"

                                cp -rf    "$sourceAutoLoadFolder_childPath"    "$autoLoadModuleDitributionPath"
                            done

                            allAutoLoadPackagesNameList=${allAutoLoadPackagesNameList}"'${autoLoadModuleDitributionName}'\n"

                        elif   [ "$componentSource_wlcBashTools_childName" == "$___allowedSourceSubFolderName2" ] \
                            || [ "$componentSource_wlcBashTools_childName" == "$___allowedSourceSubFolderName3" ] \
                            || [ "$componentSource_wlcBashTools_childName" == "$___allowedSourceSubFolderName4" ]
                        then

                            colorful -- '     Folder: '
                            colorful -n "$componentSource_wlcBashTools_childName"    textYellow


                            copy_one_item--recursively_if_its_a_folder \
                                --source-item-sub-path-to-source-components-root="$componentSource_wlcBashTools_childSubPath" \
                                --source-item-full-path="$componentSource_wlcBashTools_childPath" \
                                --target-folder-sub-path-to-building-root="$distribution_wlcBashTools_subPath" \
                                # --should-append-content-if-target-file-alreay-exists

                        else
                            colorful -- "    Sub folder with non acceptable name \""    textRed
                            colorful -- "$componentSource_wlcBashTools_childName"    textYellow
                            colorful -- "\". Skipped."    textRed
                        fi







                        # 如果遇到文件夹，则：
                        #   1) 将其记入 `allAutoLoadPackagesNameList` 变量，且报告之。
                        #   2) 检查其中是否有 `components` 文件夹存在。若存在，则报告之。
                        #   3) 检查其中的 data 文件夹内是否有已经填写的模板文件存在。若存在，则报告之。

                        
                        # 复制到 wlc-bash-tools 文件夹内，因为这个源文件本身就位于该 component 的 wlc-bash-tools 文件夹内。
                        # 但复制时须更名（最起码前面冠以序号）。

                        # autoLoadModuleIndex=$((autoLoadModuleIndex+1))
                        # libModuleIsDefaultOne='false'

                        # if [ "$componentSource_wlcBashTools_childName" == "_default-module" ]; then
                        #     libModuleIsDefaultOne='true'
                        #     libModuleDistributionName="${autoLoadModuleIndex}-${componentDistributionCoreName}"
                        # else
                        #     # 允许使用 “_default-module” 以外的模块名称。
                        #     # 虽然目前的实践是，多数 “lib” 仅有唯一的名为 “_default-module” 的模块。
                        #     # 但的确已有一个例外，在 personal/wulechuan/_anywhere 里面有两个模块：“default-module” 和 “GNU-tools”。
                        #     libModuleDistributionName="${autoLoadModuleIndex}-${componentSource_wlcBashTools_childName}"
                        # fi




                        # cp -r "$componentSource_wlcBashTools_childPath" "$senarioDistributionPath/$___wlcBashToolsRunningFolderName/$libModuleDistributionName"






                        # # 下面的小节并无实际动作，只是在命令行的标准输出设备上打印一些细节，供查阅。
                        # colorful -- '    Package: '
                        # colorful -- "$libModuleDistributionName" textGreen

                        # if [ $libModuleIsDefaultOne == 'true' ]; then
                        #     colorful -- " [default]" textMagenta
                        # fi

                        # echo

                        # # if [ -d "$componentSource_wlcBashTools_childPath/components" ]; then
                        #     # 找到其中的 `components` 文件夹。
                        # # fi

                        # for itemNameInCurrentPackage in `ls $componentSource_wlcBashTools_childPath`; do
                        #     fileInCurrentPackage="$componentSource_wlcBashTools_childPath/$itemNameInCurrentPackage"

                        #     if [ -f "$fileInCurrentPackage" ]; then
                        #         # 是文件，而非文件夹。

                        #         if [[ $itemNameInCurrentPackage =~ .wlc-filled-bash-template$ ]]; then
                        #             # 是文件，而非文件夹，且文件扩展名为 `.wlc-filled-bash-template`。
                        #             colorful -- '      Found: '
                        #             colorful -n " $itemNameInCurrentPackage "  textBlack bgndMagenta
                        #         fi
                        #     fi
                        # done

                    fi

                done

            fi


            echo

        done # end of for loop over one component source


        allAutoLoadPackagesNameList="${allAutoLoadPackagesNameList}"

        local fullPathOfPackagesDotSh="$senarioDistributionPath/$___wlcBashToolsRunningFolderName/${___rootFolderNameOfAutoLoadBashes}/packages-to-load.sh"
        echo -e "$allAutoLoadPackagesNameList" > "$fullPathOfPackagesDotSh"




        local fullPathOfFileAfterMaking="$senarioSourceFolderPath/$___senarioPostMakingActionFileName"
        if [ -f "$fullPathOfFileAfterMaking" ]; then
            colorful -- 'Taking action: '
            colorful -n "$___senarioPostMakingActionFileName"    textMagenta
            source "$fullPathOfFileAfterMaking"
        else
            colorful -n "No actions to take after making this senario."    textYellow
        fi



        chmod -R 775 "$senarioDistributionPath"


        colorful -n "$VE_line_70"    textBlue
    }




    local senarioSubPath


    for senarioSubPath in $___subPathsOf_senariosToBuild; do
        make_one_senario--copy_all_chosen_compnents_to    "$___pathOf_buildOutputRootFolder"    "$senarioSubPath"
    done

    unset -f wlc_bash_tools--building--make_all_senarios
}


wlc_bash_tools--building--make_all_senarios