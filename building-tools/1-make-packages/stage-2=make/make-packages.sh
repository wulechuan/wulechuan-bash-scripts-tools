function ___wlc_bash_scripts_make_all_packages_for_all_senarios {
    function copy_core_lib_pack_for_one_senario {
        local distributionPath=$1


        local coreLibSourceFullPath
        local coreLibContentName
        local coreLibBashScriptsFolderPath
        local coreLibBashScriptsContentName
        local coreLibBashScriptsContentFullPath


        local logString
        logString='  Lib: '
        append-colorful-string-to logString -- "core" textGreen
        echo -e "$logString"

        coreLibSourceFullPath="$___here/$___wlcBashScriptsSourceLibCoreFolderName"
        coreLibBashScriptsFolderPath="$coreLibSourceFullPath/$wlcBashScriptsRunningFolderName"


        if [ ! -d "$coreLibBashScriptsFolderPath" ]; then
            logString='       '
            logString=$logString"'"
            append-colorful-string-to logString -- "$wlcBashScriptsRunningFolderName" textYellow
            logString=$logString"'"
            append-colorful-string-to logString -- " folder not found" textRed

            echo -e "$logString"

            exit 2
        else
            logString=''

            for coreLibBashScriptsContentName in `ls $coreLibBashScriptsFolderPath`
            do
                coreLibBashScriptsContentFullPath="$coreLibBashScriptsFolderPath/$coreLibBashScriptsContentName"

                if [ -f "$coreLibBashScriptsContentFullPath" ]; then

                    if [[ $coreLibBashScriptsContentName =~ .filled-template$ ]]; then
                        # 是文件，而非文件夹，且文件扩展名为 `.filled-template`。
                        logString=$logString'         Found: '
                        append-colorful-string-to logString -n " $coreLibBashScriptsContentName "  textBlack bgndMagenta

                    fi

                fi
            done

            echo -en "$logString"
        fi


        for coreLibContentName in `ls $coreLibSourceFullPath`
        do
            cp -r "$coreLibSourceFullPath/$coreLibContentName" "$distributionPath/"
        done



        local otherItemName
        local otherItemPath

        for otherItemName in `ls -A "$libSourceFullPath"`; do
            otherItemPath="$libSourceFullPath/$otherItemName"

            # 如果遇到文件，则直接复制。
            if [ -f "$otherItemPath" ]; then
                cp "$otherItemPath" "$distributionPath/"
            fi

            # 如果遇到文件夹，则应排除 bash-scripts，因为它在前文已经专门处理过了。
            if [ -d "$otherItemPath" ] && [ $otherItemName != "$wlcBashScriptsRunningFolderName" ]; then
                cp -rf "$otherItemPath" "$distributionPath/"
            fi
        done

        echo
    }



    function make_one_package_for_one_senario {
        local outputLocationOfBuilding=$1
        local senarioName=$2

        local configurationFolder="$___here/senario-specific-configurations/$senarioName"
        local fullPathOfChosenLibsDotSh="$configurationFolder/chosen-libs.sh"

        if [ ! -f "$fullPathOfChosenLibsDotSh" ]; then
            return
        fi



        echo
        echo

        local logString=''
        append-colorful-string-to logString -n "$VE_line_60"           textBlue
        append-colorful-string-to logString -- "Processing senario:"   textBlue
        append-colorful-string-to logString -n " $senarioName"         textGreen
        append-colorful-string-to logString -n "$VE_line_60"           textBlue
        echo -e "$logString"

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
        local itemNameInCurrentPackage
        local fileInCurrentPackage

        local allChosenLibsFolder=$___allChosenLibsFolder
        unset ___allChosenLibsFolder

        local oldIFS
        local libSourceSubPathSegmentsArray
        local libSourceSubPathSegmentsCount
        local libSourceSubPathSegmentLast
        local libSourceSubPathSegmentSecondLast
        local libDefaultModuleDistributionCoreName
        local libModuleDistributionName
        local libModuleIsDefaultOne

        local libModuleIndex=0

        for libSourceSubPath in $allChosenLibsFolder
        do
            logString='  Lib: '
            append-colorful-string-to logString -- "$libSourceSubPath" textBlue
            echo -e "$logString"




            oldIFS=$IFS
            IFS='/'
            libSourceSubPathSegmentsArray=($libSourceSubPath)
            IFS=' '
            libSourceSubPathSegmentsCount=${#libSourceSubPathSegmentsArray[@]}
            IFS=$oldIFS

            libSourceSubPathSegmentLast=${libSourceSubPathSegmentsArray[libSourceSubPathSegmentsCount-1]}
            libSourceSubPathSegmentSecondLast=${libSourceSubPathSegmentsArray[libSourceSubPathSegmentsCount-2]}

            if [ $libSourceSubPathSegmentsCount -gt 1 ]; then
                # 拼装【模块名称】时，如果源路径有多层文件夹，最多仅采用最内层的两级文件夹名称。
                libDefaultModuleDistributionCoreName="$libSourceSubPathSegmentSecondLast-$libSourceSubPathSegmentLast"
            else
                # 拼装【模块名称】时，如果源路径仅有单层文件夹，则采用该文件夹名称。
                libDefaultModuleDistributionCoreName="$libSourceSubPathSegmentLast"
            fi




            # ./libs/<lib-name>/
            libSourceFullPath="$___here/$___wlcBashScriptsSourceLibFolderName/$libSourceSubPath"

            # ./libs/<lib-name>/bash-scripts/
            libBashScriptsFolderPath="$libSourceFullPath/$wlcBashScriptsRunningFolderName"

            if [ ! -d "$libBashScriptsFolderPath" ]; then

                logString='       '
                logString=$logString"'"
                append-colorful-string-to logString -- "$wlcBashScriptsRunningFolderName" textYellow
                logString=$logString"' "
                append-colorful-string-to logString -- "folder not found" textRed
                echo -e "$logString"

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
                        # 复制到 bash-scripts 文件夹内，因为这个源文件本身就位于该 lib 的 bash-scripts 文件夹内。
                        # 但复制时须更名（最起码前面冠以序号）。

                        libModuleIndex=$((libModuleIndex+1))
                        libModuleIsDefaultOne='false'

                        if [ "$libBashScriptsContentName" == "_default-module" ]; then
                            libModuleIsDefaultOne='true'
                            libModuleDistributionName="${libModuleIndex}-${libDefaultModuleDistributionCoreName}"
                        else
                            # 允许使用 “_default-module” 以外的模块名称。
                            # 虽然目前的实践是，多数 “lib” 仅有唯一的名为 “_default-module” 的模块。
                            # 但的确已有一个例外，在 personal/wulechuan/_anywhere 里面有两个模块：“default-module” 和 “GNU-tools”。
                            libModuleDistributionName="${libModuleIndex}-${libBashScriptsContentName}"
                        fi




                        cp -r "$libBashScriptsContentFullPath" "$distributionPath/$wlcBashScriptsRunningFolderName/$libModuleDistributionName"

                        allPackages=${allPackages}${libModuleDistributionName}
                        allPackages=${allPackages}' '




                        # 下面的小节中，并无实际动作，只是在命令行的标准输出设备上打印一些细节，供查阅。
                        logString='       Package: '
                        append-colorful-string-to logString -- "$libModuleDistributionName" textGreen

                        if [ $libModuleIsDefaultOne == 'true' ]; then
                            append-colorful-string-to logString -- " [default]" textMagenta
                        fi

                        logString=$logString'\n'

                        # if [ -d "$libBashScriptsContentFullPath/components" ]; then
                            # 找到其中的 `components` 文件夹。
                        # fi

                        for itemNameInCurrentPackage in `ls $libBashScriptsContentFullPath`;
                        do
                            fileInCurrentPackage="$libBashScriptsContentFullPath/$itemNameInCurrentPackage"

                            if [ -f "$fileInCurrentPackage" ]; then
                                # 是文件，而非文件夹。

                                if [[ $itemNameInCurrentPackage =~ .filled-template$ ]]; then
                                    # 是文件，而非文件夹，且文件扩展名为 `.filled-template`。
                                    logString=$logString'         Found: '
                                    append-colorful-string-to logString -n " $itemNameInCurrentPackage "  textBlack bgndMagenta
                                fi

                            fi
                        done

                        echo -en "$logString"

                    elif [ -f "$libBashScriptsContentFullPath" ]; then
                        # 遇到文件。
                        # 直接复制到 bash-scripts 文件夹内，因为这个源文件本身就位于该 lib 的 bash-scripts 文件夹内。
                        # 复制时无须更名，也不应更名。
                        # 另，复制文件无须打印细节。
                        cp "$libBashScriptsContentFullPath" "$distributionPath/$wlcBashScriptsRunningFolderName"
                    fi

                done

            fi



            local otherItemName
            local otherItemPath

            for otherItemName in `ls -A "$libSourceFullPath"`; do
                otherItemPath="$libSourceFullPath/$otherItemName"

                if [ -f "$otherItemPath" ]; then
                    cp "$otherItemPath" "$distributionPath/"
                fi

                if [ -d "$otherItemPath" ]; then
                    if [ $otherItemName == "$wlcBashScriptsRunningFolderName" ]; then
                        continue
                    else
                        cp -rf "$otherItemPath" "$distributionPath/"
                    fi
                fi
            done

            echo

        done


        local fullPathOfPackagesDotSh="$distributionPath/$wlcBashScriptsRunningFolderName/packages.sh"
        echo "__wlcBashScriptsAllChosenPacakges=\"$allPackages\"" > "$fullPathOfPackagesDotSh"




        logString=''

        local fullPathOfFileAfterMaking="$configurationFolder/after-making-this-senario.sh"
        if [ -f "$fullPathOfFileAfterMaking" ]; then
            logString='Taking action: '
            append-colorful-string-to logString -n "mafter-making-this-senario.sh" textMagenta
            source "$fullPathOfFileAfterMaking"
        else
            append-colorful-string-to logString -n "No actions to take after making this senario." textYellow
        fi

        append-colorful-string-to logString -n "$VE_line_60"   textBlue
        echo -e "$logString"
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