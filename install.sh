___here=`pwd`
echo -e '\e[34m────────────────────────────────────────────────────────────'
echo -e "\e[34mTOOLSET: \e[33m$___here"
echo -e '\e[34m────────────────────────────────────────────────────────────'

source "$___here/clean.sh"

source "$___here/tools-for-building/_make-packages.sh"
source "$___here/tools-for-building/after-making-all-senarios.sh"
source "$___here/tools-for-building/install-local-machine-package.sh"

unset ___here
unset ___wlcBashScriptsDistributionRootFolderName
unset ___wlcBashScriptsFolderName