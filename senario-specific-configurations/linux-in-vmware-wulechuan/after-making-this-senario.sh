function ___scp_bash_scripts_entries_to_remote {
    local userAtHost=$1

    echo ''
    echo -e "  \e[33mS-Copying files to linux in VM\e[0;0m"
    echo -e "  \e[35m(You may press \"Ctrl-C\" to skip this.)\e[0;0m"


    echo -en '  \e[31m'
    scp -rq \
        "$___here/dist/linux-in-vmware-wulechuan/$wlcBashScriptsFolderName"\
        "$___here/dist/linux-in-vmware-wulechuan/.bashrc"\
        "$userAtHost:~"


    echo -e '  \e[0;0m'
}

[ ${shouldSkipSCopyingOutputToLinuxVM:=0} ]

if [ shouldSkipSCopyingOutputToLinuxVM = 0 ]; then
    ___scp_bash_scripts_entries_to_remote   "wulechuan@192.168.236.131"
    ___scp_bash_scripts_entries_to_remote   "root@192.168.236.131"
fi