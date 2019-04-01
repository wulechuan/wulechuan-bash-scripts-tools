#!/bin/bash

function ___temp_func--wlc_bash_tools--deploy_locally--prepare {
	# Usage:
	# source    <this bash file>    [--no-interations | --do-not-reload-bash]    [--from-folder="<your source folder>"]    [--to-folder="<your target folder>"]
	#
	# Examples:
	#    source    <...>/to-install-wlc-bash-tools-locally-stage-1.sh    --no-interations
	#    source    <...>/to-install-wlc-bash-tools-locally-stage-1.sh    --do-not-reload-bash
	#    source    <...>/to-install-wlc-bash-tools-locally-stage-1.sh    --do-not-reload-bash    --from-folder="/d/my-toolset/wlc-bash-tools-for-my-machine/"
	#    source    <...>/to-install-wlc-bash-tools-locally-stage-1.sh    --no-interationc    --to-folder="/d/my-toolset-for-other-machines/"


	local WLC_BASH_TOOLS___FOLDER_NAME='wlc-bash-tools'
	local defaultTargetFolderPath="$HOME"



	# 目前必须为 'no'，因为我还没找到有效的方法来从内存在卸载 wlc-bash-tools。
	# 因为下面的值为 'no'，所以，后续实质的部署任务会直接运行。
	# 于是，可能遭遇部分 .mintty 和 wlc-bash-tools 这两个业已存在的旧版本文件夹无法移动的错误。
	# 正在探究解决方法。
	local shouldTryToUnloadWlcBashScriptsFirst='no'



	function clean-up-home-bashrc {
		local insertingContentStartMark="# ───── contents inserted by wlc bash tools start here ─────"
		local insertingContentEndMark="# ───── contents inserted by wlc bash tools end here ─────"
		sed -i "/$insertingContentStartMark/,/$insertingContentEndMark/d"    ~/.bashrc
		if [[ $- =~ i ]]; then
			echo -e "~/.bashrc is cleaned up. All statements added by wlc bash tools have been removed."
			echo -en "\""; cat ~/.bashrc; echo -e "\""
		fi
	}

	function appendAutorunStatementWithSignalStringToBashProfile {
		local stringToAppend="source    \"$sourceFolderPath/to-install-wlc-bash-tools-locally-stage-2.sh\"    \"$arg1\"    \"$arg2\"    \"$arg3\" # THIS LINE IS ADDED BY to-install-wlc-bash-tools-locally-stage-1.sh"
		echo "$stringToAppend" >> ~/.bash_profile

		if [[ $- =~ i ]]; then
			echo -e "\e[32mAppended this string to \e[35m~/.bash_profile\e[32m:\e[0m"
			echo -e "    \"${stringToAppend//\"/\\\"}\""
		fi
	}




	local arg1
	local arg2
	local arg3

	if [[ $- =~ i ]]; then
		echo -e "\e[32mTo install wlc bash tools locally: \e[35mStage 1\e[0m"
	fi


	if [ "$1" == '--no-interactions' ] || [ "$1" == '--do-not-reload-bash' ]; then
		arg1="$1"
		shift
	fi


	local sourceFolderPath
	local targetFolderPath

	if [[ "$1" =~ ^--from-folder=.+ ]]; then
		arg2="$1"
		sourceFolderPath="${1:14}"
		shift
	fi

	if [ -z "$sourceFolderPath" ]; then
		sourceFolderPath="`pwd`"
	fi

	if [[ "$1" =~ ^--to-folder=.+ ]]; then
		arg3="$1"
		targetFolderPath="${1:12}"
		shift
	fi

	if [ -z "$targetFolderPath" ]; then
		targetFolderPath=$defaultTargetFolderPath
	fi



	local directlyExecueStage2IsAllowed='yes'

	if [[ $- =~ i ]]; then

		echo -en "    Deployment target folder is \e[32m\$HOME\e[0m:                           "
		if [ "$targetFolderPath" == "$HOME" ]; then
			echo -e "\e[31myes\e[0m"
		else
			echo -e "\e[33mno\e[0m"
		fi


		echo -en "    Folder \e[32m~/$WLC_BASH_TOOLS___FOLDER_NAME\e[0m exists:                              "
		if [ -d ~/"$WLC_BASH_TOOLS___FOLDER_NAME" ]; then
			echo -e "\e[31myes\e[0m"
		else
			echo -e "\e[33mno\e[0m"
		fi


		echo -en "    File \e[32m~/.bashrc\e[0m exists:                                       "
		if [ -f ~/.bashrc ]; then
			echo -e "\e[31myes\e[0m"
		else
			echo -e "\e[33mno\e[0m"
		fi

	fi


	if [ "$targetFolderPath" == "$HOME" ] && [ -d ~/"$WLC_BASH_TOOLS___FOLDER_NAME" ] && [ -f ~/.bashrc ]; then
		local autorunFileMentionedWLCBashToolsStartDotSH=`cat ~/.bashrc | grep '"$WLC_BASH_TOOLS___FOLDER_PATH/start.sh"'`
		if [ ! -z "$autorunFileMentionedWLCBashToolsStartDotSH" ]; then
			directlyExecueStage2IsAllowed='no'
		fi

		if [[ $- =~ i ]]; then
			echo -en "    ~/.bashrc contains \"\e[32m\$WLC_BASH_TOOLS___FOLDER_PATH/start.sh\e[0m\": "
			if [ ! -z "$autorunFileMentionedWLCBashToolsStartDotSH" ]; then
				echo -e "\e[31myes\e[0m"
			else
				echo -e "\e[33mno\e[0m"
			fi
		fi
	fi


	if [ "$directlyExecueStage2IsAllowed" == 'yes' ] || [ "$shouldTryToUnloadWlcBashScriptsFirst" == 'no' ]; then

		if [[ $- =~ i ]]; then
			echo
			echo -e "\e[32m    Execute stage 2 directly is allowed.\e[0m"
			echo
		fi

		source    "$sourceFolderPath/to-install-wlc-bash-tools-locally-stage-2.sh"    "$arg1"    "$arg2"    "$arg3"

	else

		clean-up-home-bashrc
		appendAutorunStatementWithSignalStringToBashProfile

		if [[ $- =~ i ]]; then
			echo -e "\e[33mExecuting: \e[35mexec bash -l\e[0m"
		fi

		exec bash -l
	fi




	unset -f ___temp_func--wlc_bash_tools--deploy_locally--prepare
}


___temp_func--wlc_bash_tools--deploy_locally--prepare    $*