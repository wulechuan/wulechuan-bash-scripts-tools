___bashScriptsRootFolder=~/bash-scripts # DO NOT QUOTE THIS VALUE!
source "$___bashScriptsRootFolder/packages.sh"







# ------------------------------------------------
#     import configurations and utilities(functions) 
# ------------------------------------------------
for categoryFolder in ${__wlcBashScriptsAllChosenPacakges}
do
    ___bashScriptsCurrentPath="${___bashScriptsRootFolder}/${categoryFolder}"

    if [ -d "$___bashScriptsCurrentPath" ]; then

        if [ -f "$___bashScriptsCurrentPath/define-variables.sh" ]; then
            source "${___bashScriptsCurrentPath}/define-variables.sh"
        fi

        if [ -d "$___bashScriptsCurrentPath/components" ]; then
            for componentFile in `ls $___bashScriptsCurrentPath/components | grep .sh$`
            do
                source "$___bashScriptsCurrentPath/components/$componentFile"
            done

            unset componentFile
        fi

    fi
done
unset categoryFolder







# ------------------------------------------------
#     take some actions
# ------------------------------------------------
if [ "$windowsCurrentUserName" = "wulechuan" ]; then
    copywritingLanguage="en_US"
fi

if [ "$windowsCurrentUserName" = "lechuan.wu" ]; then
    copywritingLanguage="en_US"
fi

for categoryFolder in ${__wlcBashScriptsAllChosenPacakges}
do
    ___bashScriptsCurrentPath="${___bashScriptsRootFolder}/${categoryFolder}"

    if [ -d "$___bashScriptsCurrentPath" ]; then
        if [ -f "$___bashScriptsCurrentPath/init.sh" ]; then
            source "$___bashScriptsCurrentPath/init.sh"
        fi
    fi
done
unset categoryFolder







# ------------------------------------------------
#     Finalization
# ------------------------------------------------
unset ___bashScriptsRootFolder
unset __wlcBashScriptsAllChosenPacakges
