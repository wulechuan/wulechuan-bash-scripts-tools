___lengthOfFileNameSuffixForEnablingAppending=${#___fileNameSuffixForEnablingAppending}

___pathOf_sourceRootFolderOfAllComponents="$___here/$___subPathOf_sourceRootFolderOfAllComponents"
___pathOf_sourceRootFolderOfAllSenarios="$___here/$___subPathOf_sourceRootFolderOfAllSenarios"
___pathOf_buildOutputRootFolder="$___here/$___subPathOf_buildOutputRootFolder"
___pathOf_defaultDeploymentFolder="$___here/$___subPathOf_defaultDeploymentFolder"

if [ -z "$___subPathsOf_senariosToBuild" ]; then
	echo -e "\e[33m\$___subPathsOf_senariosToBuild is empty.\e[0m"
	echo -e "\e[32mGenerating \e[33m\$___subPathsOf_senariosToBuild\e[32m automatically,\e[0m"
	echo -e "\e[32m  assuming none of those senarios are nested in deep sub folder.\e[0m"

	___autoFoundSenarioCount=0
	cd    "$___pathOf_sourceRootFolderOfAllSenarios"
	for ___autoFoundSenarioName in `ls -d */`; do
		___autoFoundSenarioName="`echo ${___autoFoundSenarioName%%/}`"

		if [ "$___autoFoundSenarioName" == '_common-configurations' ]; then
			continue
		fi

		echo -e "    $___autoFoundSenarioName"
		___subPathsOf_senariosToBuild=$___subPathsOf_senariosToBuild" $___autoFoundSenarioName"
		___autoFoundSenarioCount=$((___autoFoundSenarioCount+1))
	done
	unset ___autoFoundSenarioName
	cd    "$___here"

	echo
	echo -e "\e[35m$___autoFoundSenarioCount\e[32m senario(s) will build.\e[0m"

fi

if [ -z "$___subPathsOf_senariosToDeploy" ]; then
	___subPathsOf_senariosToDeploy="$___subPathsOf_senariosToBuild"

	if [ ! -z "$___autoFoundSenarioCount" ]; then
		echo -e "\e[35m$___autoFoundSenarioCount\e[32m senario(s) will deploy.\e[0m"
	fi
fi

echo
echo
echo


function wlc_bash_tools--unset_all_variables_used_during_building_process {
	unset ___copywritingLanguageDuringBuilding

	unset ___wlcBashToolsRunningFolderName

	unset ___subPathOf_sourceRootFolderOfAllComponents
	unset ___subPathOf_sourceRootFolderOfAllSenarios

	unset ___pathOf_sourceRootFolderOfAllComponents
	unset ___pathOf_sourceRootFolderOfAllSenarios

	unset ___coreComponentFolderName

	unset ___rootFolderNameOfAutoLoadBashes
	unset ___allowedSourceSubFolderName2
	unset ___allowedSourceSubFolderName3
	unset ___allowedSourceSubFolderName4

	unset ___fileNameSuffixForEnablingAppending
	unset ___lengthOfFileNameSuffixForEnablingAppending

	unset ___senarioChosenComponentsListFileName
	unset ___senarioPostMakingActionFileName
	unset ___senarioSpecificDeployActionFileName

	unset ___subPathsOf_senariosToBuild
	unset ___subPathsOf_senariosToDeploy

	unset ___autoFoundSenarioCount



	unset ___subPathOf_buildOutputRootFolder
	unset ___subPathOf_defaultDeploymentFolder

	unset ___pathOf_buildOutputRootFolder
	unset ___pathOf_defaultDeploymentFolder



	unset -f wlc_bash_tools--unset_all_variables_used_during_building_process
}