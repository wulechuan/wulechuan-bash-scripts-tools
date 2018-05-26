___here=`pwd`
echo ''

source "$___here/configurations.sh"

if [ -d "$___here/$___wlcBashScriptsDistributionRootFolderName" ]; then
    rm -rf "$___here/$___wlcBashScriptsDistributionRootFolderName"
    echo -e '\e[33m────────────────────────────────────────────────────────────\e[0;0m'
    echo -e "\e[33mREMOVED: \e[31m$___here/$___wlcBashScriptsDistributionRootFolderName\e[0;0m"
    echo -e '\e[33m────────────────────────────────────────────────────────────\e[0;0m'
fi
