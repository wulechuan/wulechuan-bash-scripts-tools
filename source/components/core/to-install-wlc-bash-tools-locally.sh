#!/bin/bash

function ___temp_func--wlc_bash_tools--deploy_locally {
	local WLC_BASH_TOOLS___FOLDER_NAME='wlc-bash-tools'
	local defaultTargetFolderPath="$HOME"


	local shouldRunWithoutAnyInteractions='no'
	local shouldReloadBash='ask user'
	local nonErrorInfoIsAllowed='yes'

	if [ "$1" == '--no-interactions' ]; then

		shouldRunWithoutAnyInteractions='yes'
		shift

	elif [ "$1" == '--do-not-reload-bash' ]; then

		shouldRunWithoutAnyInteractions='yes'
		shouldReloadBash='no'
		shift

	fi



	if [[ ! $- =~ i ]]; then
		nonErrorInfoIsAllowed='no'
		shouldReloadBash='no'
		shouldRunWithoutAnyInteractions='yes'
	fi



	local sourceFolderPath
	local targetFolderPath

	if [[ "$1" =~ ^--from-folder=.+ ]]; then
		sourceFolderPath="${1:14}"
		shift
	fi

	if [[ "$1" =~ ^--to-folder=.+ ]]; then
		targetFolderPath="${1:12}"
		shift
	fi


	local sourceFolderPath_forPrinting="$sourceFolderPath"

	local currentFolder=`pwd`'/'
	local currentFolderMatchingRegExp="^${currentFolder// /\\ }"


	if [ -z "$sourceFolderPath" ]; then
		sourceFolderPath="$currentFolder"
		sourceFolderPath_forPrinting="./"
	elif [[ "$sourceFolderPath" =~ $currentFolderMatchingRegExp ]]; then
		local currentFolderStringLength=${#currentFolder}
		sourceFolderPath_forPrinting="./${sourceFolderPath:$currentFolderStringLength}"
	fi


	if [ -z "$targetFolderPath" ]; then
		targetFolderPath=$defaultTargetFolderPath
	fi

	if [ ! -d "$sourceFolderPath" ]; then
		echo -e "\e[31mNon existing\e[35m source\e[31m folder for deployment of \e[35mwlc bash tools\e[31m.\e[0m"
		echo -e "\e[31m       Desired\e[35m source\e[31m folder path was:\e[0m"
		echo -e "           '\e[33m${sourceFolderPath_forPrinting}\e[0m'"
		echo

		return 1
	fi

	if [ ! -d "$sourceFolderPath/$WLC_BASH_TOOLS___FOLDER_NAME" ]; then
		echo -e "\e[31mInvalid\e[35m source\e[31m folder for deployment of \e[35mwlc bash tools\e[31m.\e[0m"
		echo -e "\e[31m       It doesn't contain a sub folder named \"\e[33m$WLC_BASH_TOOLS___FOLDER_NAME\e[31m\"\e[0m"
		echo -e "\e[31m       Provided\e[35m source\e[31m folder path was:\e[0m"
		echo -e "           '\e[33m${sourceFolderPath_forPrinting}\e[0m'"
		echo

		return 12
	fi

	if [ ! -d "$targetFolderPath" ]; then
		echo -e "\e[31mNon exisiting\e[35m target\e[31m folder for deployment of \e[35mwlc bash tools\e[31m.\e[0m"
		echo -e "\e[31m       Desired\e[35m target\e[31m folder path was:\e[0m"
		echo -e "           '\e[33m${targetFolderPath}\e[0m'"
		echo

		return 2
	fi

	if [ "$targetFolderPath" == "$sourceFolderPath" ] && [[ $- =~ i ]]; then
		echo -e "\e[32mAlready at \"\e[35m$sourceFolderPath_forPrinting\e[32m\".\e[0m"
		echo -e "\e[32mNothing to do.\e[0m"
		echo
		return 0
	fi




	function deploy_one_bash_file {
		local sourceFilePath="${1:12}" # --from-file=
		local _targetFolderPath="${2:12}" # --to-folder=
		local _backupFolderPath="${3:16}" # --backup-folder=

		local insertingContentStartMark="# ───── contents inserted by wlc bash tools start here ─────"
		local insertingContentEndMark="# ───── contents inserted by wlc bash tools end here ─────"

		if [ ! -f "$sourceFilePath" ]; then
			echo -e "\e[31mNon existing source file: \"\e[31m${sourceFilePath}\"\e[0m"
			return 1
		fi

		if [ ! -d "$_targetFolderPath" ]; then
			echo -e "\e[31mNon existing target folder: \"\e[31m${_targetFolderPath}\"\e[0m"
			return 2
		fi

		local fileName=`basename    "$sourceFilePath"`
		local targetFilePath="$_targetFolderPath/$fileName"
		local targetFileAlreadyExists='no'

		local stringToAppend=''

		if [ -f "$targetFilePath" ]; then
			targetFileAlreadyExists='yes'

			mkdir    -p    "$_backupFolderPath"
			cp       -f    "$targetFilePath"    "$_backupFolderPath"

			sed -i "/$insertingContentStartMark/,/$insertingContentEndMark/d"    "$targetFilePath"

			local targetFileOldContentTail=`tail "$targetFilePath" -n1`


			if [[ ! "$targetFileOldContentTail" =~ ^$ ]]; then
				stringToAppend="${stringToAppend}\n"
			fi

		fi

		stringToAppend=${stringToAppend}${insertingContentStartMark}
		stringToAppend=${stringToAppend}'\n'
		stringToAppend=${stringToAppend}`cat "$sourceFilePath"`
		stringToAppend=${stringToAppend}'\n'
		stringToAppend=${stringToAppend}${insertingContentEndMark}
		stringToAppend=${stringToAppend}'\n'

		echo -e "$stringToAppend" >> "$targetFilePath"

		if [ $nonErrorInfoIsAllowed == 'yes' ]; then
			if [ $targetFileAlreadyExists == 'yes' ]; then
				echo -e " \e[32m[append]\e[0m   File: \e[32m$fileName\e[0m"
			else
				echo -e "    \e[32m[new]\e[0m   File: \e[32m$fileName\e[0m"
			fi
		fi
	}




	local backupFolderName="${WLC_BASH_TOOLS___FOLDER_NAME}_backup_on_`date +%Y-%m-%d_%H-%M`"
	local backupFolderPath="$targetFolderPath/$backupFolderName"


	if [ $nonErrorInfoIsAllowed == 'yes' ]; then
		local VE_line='──────────'
		VE_line=${VE_line}${VE_line}${VE_line}${VE_line}${VE_line}${VE_line}${VE_line}

		echo
		echo    $VE_line
		echo -e "Deploying from:      \"\e[35m$sourceFolderPath_forPrinting\e[0m\""
		echo -e "Backup of old files: \"\e[32m$targetFolderPath/\e[35m$backupFolderName\e[0m\""
		echo    $VE_line
		echo
	fi




	deploy_one_bash_file \
		--from-file="$sourceFolderPath/.bash_profile" \
		--to-folder="$HOME" \
		--backup-folder="$backupFolderPath"


	deploy_one_bash_file \
		--from-file="$sourceFolderPath/.bashrc" \
		--to-folder="$HOME" \
		--backup-folder="$backupFolderPath"


	local itemName
	local sourceItemPath
	local targetItemPath
	local oldTargetItemFound

	for itemName in `ls -A "$sourceFolderPath"`; do
		if [ "$itemName" == '.bash_profile' ]; then
			continue
		fi

		if [ "$itemName" == '.bashrc' ]; then
			continue
		fi

		if [ "$itemName" == 'to-install-wlc-bash-tools-locally.sh' ]; then
			continue
		fi

		sourceItemPath="$sourceFolderPath/$itemName"
		targetItemPath="$targetFolderPath/$itemName"


		oldTargetItemFound='no'

		if   [ -f "$targetItemPath" ]; then

			oldTargetItemFound='yes'

			if [ $nonErrorInfoIsAllowed == 'yes' ]; then
				echo -e "    \e[34m[old]\e[0m   File: \e[36m$itemName\e[0m"
			fi

		elif [ -d "$targetItemPath" ]; then

			oldTargetItemFound='yes'

			if [ $nonErrorInfoIsAllowed == 'yes' ]; then
				echo -e "    \e[34m[old]\e[0m Folder: \e[30;46m$itemName\e[0m"
			fi

		fi


		if [ "$oldTargetItemFound" == 'yes' ]; then
			mkdir    -p    "$backupFolderPath"
			mv     "$targetItemPath"    "$backupFolderPath"
		fi


		if [ $nonErrorInfoIsAllowed == 'yes' ]; then
			if   [ -f "$sourceItemPath" ]; then
				echo -e "    \e[32m[new]\e[0m   File: \e[32m$itemName\e[0m"
			elif [ -d "$sourceItemPath" ]; then
				echo -e "    \e[32m[new]\e[0m Folder: \e[30;45m$itemName\e[0m"
			fi
		fi


		cp    -rf    "$sourceItemPath"    "$targetFolderPath"
	done


	if [ $nonErrorInfoIsAllowed == 'yes' ]; then
		echo
		echo -e "\e[30;42mDONE\e[0m"
		echo
	fi



	if [ "$shouldRunWithoutAnyInteractions" == 'no' ]; then
		local userInput

		echo
		while true; do
			echo -en 'Replace current bash process with new one (`\e[35mexec bash -l\e[0m`)? [y/n] '
			read -n 1 -s    userInput
			echo

			if   [[ "$userInput" =~ [yY] ]]; then
				shouldReloadBash='yes'
				break

			elif [[ "$userInput" =~ [nN] ]]; then
				shouldReloadBash='no'
				break

			fi

		done
	fi


    local pathOfMarkFileOfInstallationOfNewInstance="$HOME/.wlc-bash-tools___new-one-to-deploy"
	if [ -f "$pathOfMarkFileOfInstallationOfNewInstance" ]; then
		rm    -f    "$pathOfMarkFileOfInstallationOfNewInstance"
	fi


	if [ "$shouldReloadBash" == 'yes' ]; then
		exec bash -l
	fi


	unset -f ___temp_func--wlc_bash_tools--deploy_locally
}


___temp_func--wlc_bash_tools--deploy_locally    $*