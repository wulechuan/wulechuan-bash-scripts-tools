echo ''
echo -e "  \e[33mS-Copying files to linux in VM\e[0;0m"


echo -en '  \e[31m'
scp -rq \
    "$___here/dist/linux-in-vmware-wulechuan/bash-scripts"\
    "$___here/dist/linux-in-vmware-wulechuan/.bashrc"\
    wulechuan@192.168.236.131:~


echo -e '  \e[0;0m'