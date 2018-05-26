___here=`pwd`
echo ''

source "$___here/configurations.sh"

if [ -d "$___here/$___wlcBashScriptsDistributionRootFolderName" ]; then
    rm -rf "$___here/$___wlcBashScriptsDistributionRootFolderName"
    echo -e '\033[33m────────────────────────────────────────────────────────────\033[0;0m'
    echo -e "\033[33mREMOVED: \033[31m$___here/$___wlcBashScriptsDistributionRootFolderName\033[0;0m"
    echo -e '\033[33m────────────────────────────────────────────────────────────\033[0;0m'
fi
