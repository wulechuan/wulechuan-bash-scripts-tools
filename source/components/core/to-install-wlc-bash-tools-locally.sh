#!/bin/bash

# Usage:
#     source    <this bash file>    --should-accord-to-standard-auto-deployment-signal-file
#     source    <this bash file>    [--no-interations | --do-not-reload-bash]    [--from-folder="<your source folder>"]    [--to-folder="<your target folder>"]
#
# Examples:
#     source    <...>/to-install-wlc-bash-tools-locally.sh    --should-accord-to-standard-auto-deployment-signal-file
#     source    <...>/to-install-wlc-bash-tools-locally.sh    --no-interations
#     source    <...>/to-install-wlc-bash-tools-locally.sh    --do-not-reload-bash
#     source    <...>/to-install-wlc-bash-tools-locally.sh    --do-not-reload-bash    --from-folder="/d/my-toolset/wlc-bash-tools-for-my-machine/"
#     source    <...>/to-install-wlc-bash-tools-locally.sh    --no-interationc    --to-folder="/d/my-toolset-for-other-machines/"



function ___temp_func--wlc_bash_tools--deploy_locally {
	# Those core global vars not available yet.
	# So we have to manually provide them here.
	local WLC_BASH_TOOLS___FOLDER_NAME='wlc-bash-tools'
	local WLC_BASH_TOOLS___FOLDER_NAME___OF_SIGNALS=".${WLC_BASH_TOOLS___FOLDER_NAME}-signals"
	local WLC_BASH_TOOLS___FILE_NAME___OF_SIGNAL_OF_NEW_INSTANCE_TO_DEPLOY="${WLC_BASH_TOOLS___FOLDER_NAME}___new-one-to-deploy"
	# local WLC_BASH_TOOLS___FILE_NAME___OF_SIGNAL_OF_AUTO_LOGGING_OUT="should-auto-log-out-after-auto-tasks-done"
	local VE_line='──────────' # 10 chars
	VE_line=${VE_line}${VE_line}${VE_line}${VE_line}${VE_line}${VE_line}${VE_line} # 70 chars


	local defaultTargetFolderPath="$HOME"



	function ___temp_func--wlc_bash_tools--deploy_locally--core {
		# Usage:
		#     <this function>    [--no-interations | --do-not-reload-bash]    [--from-folder="<your source folder>"]    [--to-folder="<your target folder>"]
		#
		# Examples:
		#     <this function>    --no-interations
		#     <this function>    --do-not-reload-bash
		#     <this function>    --do-not-reload-bash    --from-folder="/d/my-toolset/wlc-bash-tools-for-my-machine/"
		#     <this function>    --no-interationc    --to-folder="/d/my-toolset-for-other-machines/"


		if [[ $- =~ i ]]; then
			echo
			echo
			echo
			echo -e "\e[32m$VE_line\e[0m"
			echo -e "\e[32mTo deploy \e[35mwlc bash tools\e[32m locally\e[0m"
			echo -e "\e[32m$VE_line\e[0m"
			echo
			# echo -e "\e[30;42mDEBUG\e[0;32m function --core\e[0m:\n    \$1=\"\e[33m$1\e[0m\"\n    \$2=\"\e[33m$2\e[0m\"\n    \$3=\"\e[33m$3\e[0m\""
		fi



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
		local currentFolderMatchingRegExp="^${currentFolder// /\\ }" # 空格前增加转义符，即【反斜杠号】。


		if [ -z "$sourceFolderPath" ]; then
			sourceFolderPath="$currentFolder"
			sourceFolderPath_forPrinting="./"
			if [ `dirname "$sourceFolderPath"` == "$HOME" ]; then
				sourceFolderPath_forPrinting="$sourceFolderPath"
			fi
		elif [[ "$sourceFolderPath" =~ $currentFolderMatchingRegExp ]]; then
			local currentFolderStringLength=${#currentFolder}
			sourceFolderPath_forPrinting="./${sourceFolderPath:$currentFolderStringLength}"
		fi


		if [ -z "$targetFolderPath" ]; then
			targetFolderPath=$defaultTargetFolderPath
		fi

		if [ ! -d "$sourceFolderPath" ]; then
			echo -e "\e[31mNon existing\e[33m source\e[31m folder for deployment of \e[32mwlc bash tools\e[31m.\e[0m"
			echo -e "\e[31mDesired\e[33m source\e[31m folder path was:\e[0m"
			echo -e "    '\e[33m${sourceFolderPath_forPrinting}\e[0m'"
			echo

			return 1
		fi

		if [ ! -d "$sourceFolderPath/$WLC_BASH_TOOLS___FOLDER_NAME" ]; then
			echo -e "\e[31mInvalid\e[33m source\e[31m folder for deployment of \e[32mwlc bash tools\e[31m.\e[0m"
			echo -e "\e[31mIt doesn't contain a sub folder named \"\e[33m$WLC_BASH_TOOLS___FOLDER_NAME\e[31m\"\e[0m"
			echo -e "\e[31mProvided\e[33m source\e[31m folder path was:\e[0m"
			echo -e "    '\e[33m${sourceFolderPath_forPrinting}\e[0m'"
			echo

			return 12
		fi

		if [ ! -d "$targetFolderPath" ]; then
			echo -e "\e[31mNon exisiting\e[33m target\e[31m folder for deployment of \e[35mwlc bash tools\e[31m.\e[0m"
			echo -e "\e[31mDesired\e[33m target\e[31m folder path was:\e[0m"
			echo -e "    '\e[33m${targetFolderPath}\e[0m'"
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

			local fileName=`basename    "$sourceFilePath"`

			if [ ! -f "$sourceFilePath" ]; then
				if [ "$fileName" == '.bash_profile' ]; then
					echo -e "\e[33mNo source \"\e[32m.bash_profile\e[33m\" is provided. A new one will be generated automatically.\e[0m"
				else
					echo -e "\e[31mNon existing source file: \"\e[31m${sourceFilePath}\"\e[0m"
					return 1
				fi
			fi

			if [ ! -d "$_targetFolderPath" ]; then
				echo -e "\e[31mNon existing target folder: \"\e[31m${_targetFolderPath}\"\e[0m"
				return 2
			fi

			local targetFilePath="$_targetFolderPath/$fileName"
			local targetFileAlreadyExists='no'

			local stringToAppend=''

			if [ -f "$targetFilePath" ]; then
				targetFileAlreadyExists='yes'

				mkdir    -p    "$_backupFolderPath"
				cp       -f    "$targetFilePath"    "$_backupFolderPath"


				sed -i "/$insertingContentStartMark/,/$insertingContentEndMark/d"    "$targetFilePath"

				if [ "$targetFolderPath" == "$HOME" ] && [ "$fileName" == '.bashrc' ]; then
					local foundOldBashScriptsEntryPointInvocations=`awk '/^\s*if\s+\[\s+-f\s+~\/bash-scripts\/(after-)?start\.sh/' ~/.bashrc`

					if [ ! -z "$foundOldBashScriptsEntryPointInvocations" ]; then
						local _newTempBashRCFileName='.bashrc_temp'
						awk 'BEGIN {met=0} {if (met>0) met++; else if ($0 ~ /^\s*if\s+\[\s+-f\s+~\/bash-scripts\/(after-)?start\.sh/) met=1} {if (met==0) print $0; else print "# "$0 } {if (met>=3) met=0 }' ~/.bashrc > ~/${_newTempBashRCFileName}

						rm ~/.bashrc
						mv ~/${_newTempBashRCFileName} ~/.bashrc
					fi
				fi




				local targetFileOldContentLastLineTrimmed=`sed -n '${/\S/p}' "$targetFilePath"`

				if [ -z "$targetFileOldContentLastLineTrimmed" ]; then
					sed -i '$d' "$targetFilePath"
				fi

				stringToAppend="${stringToAppend}\n"
			fi




			stringToAppend=${stringToAppend}${insertingContentStartMark}
			stringToAppend=${stringToAppend}'\n'

			local sourceFileContentIsNotEmpty

			if [ -f "$sourceFilePath" ]; then # .bash_profile 可能不存在源文件
				sourceFileContentIsNotEmpty=`sed    -n    '/^\s*[^#]\S/p'    "$sourceFilePath"`

				if [ -z "$sourceFileContentIsNotEmpty" ]; then
					echo -en "\e[33mSource file \"\e[32m$fileName\e[33m\" has zero statements.\e[0m"

					if [ "$fileName" == '.bash_profile' ]; then
						echo
						# Do not return here, if file is .bash_profile
					else
						echo -e "\e[33mSkipped.\e[0m"
						return 0
					fi
				else
					stringToAppend=${stringToAppend}`cat "$sourceFilePath"`
				fi
			fi

			if [ "$fileName" == '.bash_profile' ]; then
				local sourceBashProfileIsInvokingBashRC
				local oldTargetBashProfileIsInvokingBashRC

				if [ -f "$targetFilePath" ]; then
					oldTargetBashProfileIsInvokingBashRC=`sed    -n    "/\(source\|\.\)\s\+~\/.bashrc/p"    "$targetFilePath"`
				fi

				if [ -f "$sourceFilePath" ]; then
					sourceBashProfileIsInvokingBashRC=`   sed    -n    "/\(source\|\.\)\s\+~\/.bashrc/p"    "$sourceFilePath"`
				fi

				if [ -z "$oldTargetBashProfileIsInvokingBashRC" ] && [ -z "$sourceBashProfileIsInvokingBashRC" ]; then
					stringToAppend=${stringToAppend}'if [ -f ~/.bashrc ]; then\n'
					stringToAppend=${stringToAppend}'	source ~/.bashrc\n'
					stringToAppend=${stringToAppend}'fi'
				fi
			fi

			stringToAppend=${stringToAppend}'\n'
			stringToAppend=${stringToAppend}${insertingContentEndMark}

			# echo -e "deploy_one_bash_file:"
			# echo -e "    from   $sourceFilePath"
			# echo -e "    to     $targetFilePath"

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

			echo
			echo    $VE_line
			echo -e "Deployment source:  \"\e[35m$sourceFolderPath_forPrinting\e[0m\""
			echo -e "Folder for backups: \"\e[32m$targetFolderPath/\e[35m$backupFolderName\e[0m\""
			echo    $VE_line
			echo
		fi





		if [ "$targetFolderPath" == "$HOME" ]; then

			if [ -d ~/bash-scripts ]; then # 如果旧版本存在，它将干扰新版本
				mv    ~/bash-scripts    ~/bash-scripts--old-version
			fi


			deploy_one_bash_file \
				--from-file="$sourceFolderPath/.bash_profile" \
				--to-folder="$targetFolderPath" \
				--backup-folder="$backupFolderPath"


			deploy_one_bash_file \
				--from-file="$sourceFolderPath/.bashrc" \
				--to-folder="$targetFolderPath" \
				--backup-folder="$backupFolderPath"
		fi


		local itemName
		local sourceItemPath
		local targetItemPath
		local oldTargetItemFound

		for itemName in `ls -A "$sourceFolderPath"`; do
			if [ "$targetFolderPath" == "$HOME" ]; then
				if [ "$itemName" == '.bash_profile' ]; then
					continue
				fi

				if [ "$itemName" == '.bashrc' ]; then
					continue
				fi

				if [ "$itemName" == 'to-install-wlc-bash-tools-locally.sh' ]; then
					echo -en "\e[33mDuring deployment of \e[34mwlc-bash-tools\e[33m, the file \"\e[0m"
					echo -en "\e[32mto-install-wlc-bash-tools-locally.sh\e[0m"
					echo -e  "\e[33m\" is skipped.\e[0m"
					continue
				fi
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
				# *************************************************** #
				# *************************************************** #
				# *************************************************** #
				mkdir    -p                         "$backupFolderPath"
				cp       -r    "$targetItemPath"    "$backupFolderPath"
				rm      -rf    "$targetItemPath"
				# 此处采用先 cp 后 rm 的方法，而不是直接采用 mv 命令，是因为 mv 命令常常遭遇失败。
				# *************************************************** #
				# *************************************************** #
				# *************************************************** #
			fi


			if [ $nonErrorInfoIsAllowed == 'yes' ]; then
				if   [ -f "$sourceItemPath" ]; then
					echo -e "    \e[32m[new]\e[0m   File: \e[32m$itemName\e[0m"
				elif [ -d "$sourceItemPath" ]; then
					echo -e "    \e[32m[new]\e[0m Folder: \e[30;45m$itemName\e[0m"
				fi
			fi


			# ***************************************************** #
			# ***************************************************** #
			# ***************************************************** #
			cp    -rf    "$sourceItemPath"    "$targetFolderPath"
			# ***************************************************** #
			# ***************************************************** #
			# ***************************************************** #
		done



		local folderToDisableExecution="$targetFolderPath/$WLC_BASH_TOOLS___FOLDER_NAME/$WLC_BASH_TOOLS___FOLDER_NAME___OF_ASSETS"
		if [ -d "$folderToDisableExecution" ]; then
			chmod    -x    -R    "$folderToDisableExecution"
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


		local pathOfSignalFileOfDeploymentOfNewInstance="$HOME/.wlc-bash-tools___new-one-to-deploy"
		if [ -f "$pathOfSignalFileOfDeploymentOfNewInstance" ]; then
			rm    -f    "$pathOfSignalFileOfDeploymentOfNewInstance"
		fi


		if [ "$shouldReloadBash" == 'yes' ]; then
			exec bash -l
			return 0 # Necessary？
		fi


		if [[ $- =~ i ]]; then
			echo
			echo -e "\e[33mThe bash environment will NOT reload automatically. To apply\e[0m"
			echo -e "\e[33mthe latest deployed toolset, you shall either create a new\e[0m"
			echo -e "\e[33msession, or reload current session via '\e[35mexec bash -l\e[33m'.\e[0m"
			echo
			echo

		fi
	}






	local arg1="$1"
	local arg2="$2"
	local arg3="$3"
	local deploymentWasAccordingToSignalFile='no'
	local deploymentSucceeded='no'

	shift
	shift
	shift



	local pathOfSignalFileOfDeploymentOfNewInstance="$HOME/$WLC_BASH_TOOLS___FOLDER_NAME___OF_SIGNALS/$WLC_BASH_TOOLS___FILE_NAME___OF_SIGNAL_OF_NEW_INSTANCE_TO_DEPLOY"

	# 注意！ $1 已经不存在了！
	if [ "$arg1" == '--should-accord-to-standard-auto-deployment-signal-file' ]; then

		if [ -f "$pathOfSignalFileOfDeploymentOfNewInstance" ]; then
			local folderNameOfNewInstanceToDeploy=`cat "$pathOfSignalFileOfDeploymentOfNewInstance"`
			local folderPathOfNewInstanceToDeploy="$HOME/$folderNameOfNewInstanceToDeploy"

			deploymentWasAccordingToSignalFile='yes'
			arg1='--no-interactions'
			arg2="--from-folder=$folderPathOfNewInstanceToDeploy"
			arg3="--to-folder=$HOME"
		else
			echo -e "\e[31mStandard signal file \"\e[33m$pathOfSignalFileOfDeploymentOfNewInstance\e[31m\" for auto deployment was not found.\e[0m"
			return 127
		fi

	fi








	# ************************************************************************************* #
	# ************************************************************************************* #
	# ************************************************************************************* #
	___temp_func--wlc_bash_tools--deploy_locally--core    "$arg1"    "$arg2"    "$arg3"    $*
	if [ $? -eq 0 ]; then
		deploymentSucceeded='yes'
	fi
	# ************************************************************************************* #
	# ************************************************************************************* #
	# ************************************************************************************* #






	if [ "$deploymentWasAccordingToSignalFile" == 'yes' ]; then
		local shouldDeleteSignalFileOfDeploymentOfNewInstance='no'

		if [ "$deploymentSucceeded" == 'yes' ] || [ "$arg1" == '--no-interactions' ]; then
			shouldDeleteSignalFileOfDeploymentOfNewInstance='yes'
		else
			local __userInput

			while true; do
				echo -e  "\e[33mShall we remove the auto deployment signal file \"\e[35m${pathOfSignalFileOfDeploymentOfNewInstance}\e[33m\"?\e[0m"
				echo -en "[y/n] "
				read    -n 1    -t 5    __userInput

				if [ $? -gt 0 ]; then
					echo
					shouldDeleteSignalFileOfDeploymentOfNewInstance='no'
					break
				fi

				echo

				case $__userInput in
					[yY])
						shouldDeleteSignalFileOfDeploymentOfNewInstance='yes'
						break
						;;

					[nN])
						shouldDeleteSignalFileOfDeploymentOfNewInstance='no'
						break
						;;
				esac

			done
		fi

		if [ $shouldDeleteSignalFileOfDeploymentOfNewInstance == 'yes' ]; then
			rm    -f    "$pathOfSignalFileOfDeploymentOfNewInstance"
			if [ $? -eq 0 ] && [[ $- =~ i ]]; then
				echo -e "\e[33mSignal file \"\e[35m$pathOfSignalFileOfDeploymentOfNewInstance\e[33m\" has been removed.\e[0m"
			fi
		fi


		if [[ $- =~ i ]]; then
			echo
			echo -en "Deployment of \e[35mwlc bash tools\e[0m "
			echo -e "\e[30;42mDONE\e[0m"
			echo
		fi
	fi
}




# if [[ $- =~ i ]]; then echo -e "\e[30;42mDEBUG\e[0;32m to-install-wlc-bash-tools-locally.sh\e[0m:\n    \$1=\"\e[33m$1\e[0m\"\n    \$2=\"\e[33m$2\e[0m\"\n    \$3=\"\e[33m$3\e[0m\""; fi

___temp_func--wlc_bash_tools--deploy_locally    $*
unset -f ___temp_func--wlc_bash_tools--deploy_locally