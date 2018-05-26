___entry1ToSCopy="$___here/dist/linux-in-vmware-wulechuan/bash-scripts"
___entry2ToSCopy="$___here/dist/linux-in-vmware-wulechuan/.bashrc"

echo ''
echo -e "  \e[33mS-Copying files to linux in VM\e[0;0m"
echo -en '  \e[31m'
scp -rq "$___entry1ToSCopy" "$___entry2ToSCopy" wulechuan@192.168.236.131:~
echo -e '  \e[0;0m'

unset ___entry1ToSCopy
unset ___entry2ToSCopy
