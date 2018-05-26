___here=`pwd`
echo -e '\033[34m────────────────────────────────────────────────────────────'
echo -e "\033[34mTOOLSET: \033[33m$___here"
echo -e '\033[34m────────────────────────────────────────────────────────────'

source "$___here/clean.sh"

source "$___here/tools-for-building/_make-packages.sh"
source "$___here/tools-for-building/after-making-all-senarions.sh"
source "$___here/tools-for-building/install-local-machine-package.sh"

unset ___here
unset ___wlcBashScriptsDistributionRootFolderName
unset ___wlcBashScriptsFolderName