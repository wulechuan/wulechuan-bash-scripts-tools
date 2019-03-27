#!/bin/bash


# --------------------------------------------------------
# These variables below ONLY effect the building process.
# They will NOT effect built packages.
# --------------------------------------------------------








# --------------------------------------------------------
# common
# --------------------------------------------------------
___copywritingLanguageDuringBuilding='en_US' # 'en_US' or 'zh_CN'

___wlcBashToolsRunningFolderName='wlc-bash-tools'








# --------------------------------------------------------
# source
# --------------------------------------------------------

___subPathOf_sourceRootFolderOfAllComponents='source/components'
___subPathOf_sourceRootFolderOfAllSenarios="source/senarios-are-combinations-of-components"

___coreComponentFolderName='core'

___rootFolderNameOfAutoLoadBashes='bash-auto-load-on-start'
___allowedSourceSubFolderName2='bash-load-on-demand'
___allowedSourceSubFolderName3='assets'
___allowedSourceSubFolderName4='bash-from-3rd-parties'

___fileNameSuffixForEnablingAppending='--to_append'

___senarioChosenComponentsListFileName='chosen-optional-components.sh'
___senarioPostMakingActionFileName='after-making-this-senario.sh'
___senarioSpecificDeployActionFileName='deploy.sh'

___subPathsOf_senariosToBuild='
	local-machine-wulechuan
	linux-in-vmware-wulechuan
'

# ___subPathsOf_senariosToDeploy=







# --------------------------------------------------------
# target
# --------------------------------------------------------

___subPathOf_buildOutputRootFolder='built-senarios'
___subPathOf_defaultDeploymentFolder='built-senarios/wlc-bash-tools-for-other-machines'