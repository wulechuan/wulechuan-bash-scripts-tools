function ___scopy_bash_scripts_to_virtual_machine {
    local userAtHost=$1

    echo ''
    echo -e "  \e[33mS-Copying files to linux in VM\e[0;0m"
    echo -e "  \e[35m(You may press \"Ctrl-C\" to skip this.)\e[0;0m"

    echo -en '  \e[31m'
    scp -rq \
        "$___here/dist/linux-in-vmware-wulechuan/$wlcBashScriptsRunningFolderName"\
        "$___here/dist/linux-in-vmware-wulechuan/.bashrc"\
        "$userAtHost:~"

    echo -e '  \e[0;0m'
}



[ ${___shouldSkipSCopyingOutputToLinuxVirtualMachine:=0} ]

if [ $___shouldSkipSCopyingOutputToLinuxVirtualMachine = 0 ]; then
    ___scopy_bash_scripts_to_virtual_machine   "wulechuan@$___virtualMachineHost"
    ___scopy_bash_scripts_to_virtual_machine   "root@$___virtualMachineHost"
fi