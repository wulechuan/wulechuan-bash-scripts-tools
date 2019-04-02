function wlc-bash-tools-scopy-to-remote-for-later-deployment-at-remote {
	# $1 should be --from     for easier understanding, but it can actually be anything, as long as it's not absent.
	# $3 should be --to-host  for easier understanding, but it can actually be anything, as long as it's not absent.
	local sourceFolderPath="$2"
	local remoteHost="$4"


	local -a itemListToSend



	function try-to-setup-non-standard-trigger-for-deployment-on-a-brand-new-remote-machine {
		# 下方用很长的名称，特别是尾部借助多个下划线进一步延长名称，仅仅是为了方便对齐由 echo 所书写的远程代码片段。
		local wlcBashToolsRemotePreDeploymentFolderNameAtRemote______="${1:29}" # --pre-deployment-folder-name="..."
		local localWorkingCacheFolderPath="${2:22}"                             # --working-folder-path="..."

		print-header "Detecting remote \e[35m~/.bash_profile\e[32m and \e[35m~/.bashrc\e[32m..."
		detect-remote-file    "$remoteHost"    '~'    ".bash_profile"    "$localWorkingCacheFolderPath"
		detect-remote-file    "$remoteHost"    '~'    ".bashrc"          "$localWorkingCacheFolderPath"

		echo

		local pathOfLocalCacheFileOfRemoteBashProfile="$localWorkingCacheFolderPath/.bash_profile"
		local pathOfLocalCacheFileOfRemoteBashRC_____="$localWorkingCacheFolderPath/.bashrc"

		touch    "$pathOfLocalCacheFileOfRemoteBashProfile"
		touch    "$pathOfLocalCacheFileOfRemoteBashRC_____"

		local tempStatementMarkerString='THIS_LINE_IS_ADDED_TEMPORARILY_BY_WLC_BASH_TOOLS'
		local tempStatementMarkerString____________________="$tempStatementMarkerString"


		local remoteAutorunFileMentionedTempAutorunStatements_=`cat "$pathOfLocalCacheFileOfRemoteBashProfile" | grep "$tempStatementMarkerString"`
		local remoteAutorunFileMentionedWLCBashToolsStartDotSH=`cat "$pathOfLocalCacheFileOfRemoteBashRC_____" | grep '"$WLC_BASH_TOOLS___FOLDER_PATH/start.sh"'`

		echo -en "Remote autorun file mentioned \e[32mtemp autorun statements\e[0m:   "
		if [ -z "$remoteAutorunFileMentionedTempAutorunStatements_" ]; then
			echo -e "\e[31mno\e[0m"
		else
			echo -e "\e[33myes\e[0m"
		fi

		echo -en "Remote autorun file mentioned \e[32m~/wlc-bash-tools/start.sh\e[0m: "
		if [ -z "$remoteAutorunFileMentionedWLCBashToolsStartDotSH" ]; then
			echo -e "\e[31mno\e[0m"
		else
			echo -e "\e[33myes\e[0m"
		fi


		rm    -f    "$pathOfLocalCacheFileOfRemoteBashRC_____"


		if  [ -z "$remoteAutorunFileMentionedTempAutorunStatements_" ] && [ -z "$remoteAutorunFileMentionedWLCBashToolsStartDotSH" ]; then
			echo
			colorful -n "Appending temp autorun statements to locally cached \".bash_profile\"..."    textGreen

			echo "if [ -d ~/$wlcBashToolsRemotePreDeploymentFolderNameAtRemote______ ]; then       # $tempStatementMarkerString" >> "$pathOfLocalCacheFileOfRemoteBashProfile"
			echo "    cd ~/$wlcBashToolsRemotePreDeploymentFolderNameAtRemote______                # $tempStatementMarkerString" >> "$pathOfLocalCacheFileOfRemoteBashProfile"
			echo "    ./to-install-wlc-bash-tools-locally.sh    --no-interactions                  # $tempStatementMarkerString" >> "$pathOfLocalCacheFileOfRemoteBashProfile"
			echo "    sed -i '/${tempStatementMarkerString____________________}/d' ~/.bash_profile # $tempStatementMarkerString" >> "$pathOfLocalCacheFileOfRemoteBashProfile"
			echo "    logout                                                                       # $tempStatementMarkerString" >> "$pathOfLocalCacheFileOfRemoteBashProfile"
			echo "fi                                                                               # $tempStatementMarkerString" >> "$pathOfLocalCacheFileOfRemoteBashProfile"


			itemListToSend+=("$pathOfLocalCacheFileOfRemoteBashProfile")

			return 0 # Should actually use temp autorun statements.
		fi


		rm    -f    "$pathOfLocalCacheFileOfRemoteBashProfile"

		return 1 # No need to use temp autorun statements. It's ok to take the so-called standard way, aka the wlc-bash-tools way, to auto deploy a new instance.
	}


	function setup-standard-signal-file-for-remote-auto-deployment {
		local remotePreDeploymentFolderName="${1:29}" # --pre-deployment-folder-name="..."
		local localWorkingFolderPath="${2:22}"        # --working-folder-path="..."

		local remoteSignalFilesContainingFolderPathAtLocal="$localWorkingFolderPath/$WLC_BASH_TOOLS___FOLDER_NAME___OF_SIGNALS"
		mkdir    -p    "$remoteSignalFilesContainingFolderPathAtLocal"

		local remoteSignalFile1PathAtLocalCache="$remoteSignalFilesContainingFolderPathAtLocal/${WLC_BASH_TOOLS___FILE_NAME___OF_SIGNAL_OF_NEW_INSTANCE_TO_DEPLOY}"
		echo $remotePreDeploymentFolderName > "$remoteSignalFile1PathAtLocalCache"

		local remoteSignalFile2PathAtLocalCache="$remoteSignalFilesContainingFolderPathAtLocal/${WLC_BASH_TOOLS___FILE_NAME___OF_SIGNAL_OF_AUTO_LOGGING_OUT}"
		touch    "$remoteSignalFile2PathAtLocalCache"

		itemListToSend+=("$remoteSignalFilesContainingFolderPathAtLocal")

		echo
		echo -e "Inside of \"\e[34m${WLC_BASH_TOOLS___FOLDER_NAME___OF_CACHE}/.../\e[32m${WLC_BASH_TOOLS___FOLDER_NAME___OF_SIGNALS}\e[0m\","
		echo -e "these signal files for auto deployment will be copied:"
		echo "$VE_line_60"
		echo -e "    \e[32m$WLC_BASH_TOOLS___FILE_NAME___OF_SIGNAL_OF_NEW_INSTANCE_TO_DEPLOY\e[0m"
		echo -e "    \e[32m$WLC_BASH_TOOLS___FILE_NAME___OF_SIGNAL_OF_AUTO_LOGGING_OUT\e[0m"
		echo "$VE_line_60"
	}






	if [ "$sourceFolderPath" == "$HOME" ] || [ "$sourceFolderPath" == ~ ]; then
		console.error    "Cannot deploy \e[32m~\e[32m instance of \e[33m$WLC_BASH_TOOLS___FOLDER_NAME\e[31m to remote."
		echo
		return 31
	fi

	if [ ! -d "$sourceFolderPath" ]; then
		console.error    "Failed to find folder \"\e[35m$sourceFolderPath\e[31m\" as source."
		echo
		return 32
	fi

	if     [[ ! "$remoteHost" =~ ^[_a-zA-Z0-9]+@[0-9]+\.[0-9]+\.[0-9]+\.[0-9]+$ ]] \
		&& [[ ! "$remoteHost" =~ ^[_a-zA-Z0-9]+@[_a-zA-Z0-9]+$                  ]]; then
		console.error    "Invalid remoteHost \"\e[35m$remoteHost\e[31m\""
		echo
		return 34
	fi



	print-header "Deploying \"\e[35mwlc bash tools\e[32m\" to another machine"

	colorful -- "Source folder: "
	colorful -n "$sourceFolderPath"    textGreen

	colorful -- "Target host:   "
	colorful -n "$remoteHost"          textMagenta



	local timeStamp=`date +%Y-%m-%d_%H-%M-%S`

	# something like "wlc-bash-tools___new-one-to-deploy___1979-03-19_12-34-56"
	local wlcBashToolsRemotePreDeploymentFolderNameAtRemote="${WLC_BASH_TOOLS___FOLDER_NAME_PREFIX___OF_NEW_INSTANCE_TO_DEPLOY}___${timeStamp}"
	local localTempWorkingFolderName="${remoteHost}___${timeStamp}"
	local localTempWorkingFolderPath="${WLC_BASH_TOOLS___FOLDER_PATH___OF_CACHE}/deployments-to-remote-machines/${localTempWorkingFolderName}"
	mkdir    -p    "$localTempWorkingFolderPath"



	
	echo3

	try-to-setup-non-standard-trigger-for-deployment-on-a-brand-new-remote-machine \
	    --pre-deployment-folder-name="$wlcBashToolsRemotePreDeploymentFolderNameAtRemote" \
		       --working-folder-path="$localTempWorkingFolderPath"

	local valueOfOneMeansShouldTakeStandardWay=$?
	if [ "$valueOfOneMeansShouldTakeStandardWay" -eq 1 ]; then
		setup-standard-signal-file-for-remote-auto-deployment \
			--pre-deployment-folder-name="$wlcBashToolsRemotePreDeploymentFolderNameAtRemote" \
			       --working-folder-path="$localTempWorkingFolderPath"
	fi










	# ########################## MAKING DUPLICATIONS ########################## #
	# echo
	# echo
	# colorful -n "Making duplications, so that files can be put in correct folder at remote machine..."    textGreen

	local wlcBashToolsRemotePreDeploymentFolderPathAtLocal="$localTempWorkingFolderPath/$wlcBashToolsRemotePreDeploymentFolderNameAtRemote"

	if [ -d "$wlcBashToolsRemotePreDeploymentFolderPathAtLocal" ]; then
		rm    -rf    "$wlcBashToolsRemotePreDeploymentFolderPathAtLocal"
	fi

	mkdir    -p                             "$wlcBashToolsRemotePreDeploymentFolderPathAtLocal"
	cp       -r    "$sourceFolderPath"/.    "$wlcBashToolsRemotePreDeploymentFolderPathAtLocal"

	itemListToSend+=("$wlcBashToolsRemotePreDeploymentFolderPathAtLocal")
	# ######################################################################### #





	local itemName
	local sourceItemPath

	# echo; echo; for sourceItemPath in ${itemListToSend[@]}; do
	# 	if   [ -f "$sourceItemPath" ]; then
	# 		echo -e "\e[30;42mDEBUG\e[0m   File: \e[32m$sourceItemPath\e[0m"
	# 	elif [ -d "$sourceItemPath" ]; then
	# 		echo -e "\e[30;42mDEBUG\e[0m Folder: \e[35m$sourceItemPath\e[0m"
	# 	fi
	# done; echo


	echo
	echo


	echo -e "Inside of \"\e[34m${WLC_BASH_TOOLS___FOLDER_NAME___OF_CACHE}/.../\e[32m${localTempWorkingFolderName}\e[0m\","
	echo -e "these items will be copied:"
	echo "$VE_line_60"
	for itemName in `ls -A "$localTempWorkingFolderPath"`; do
		sourceItemPath="$localTempWorkingFolderPath/$itemName"

		if   [ -f "$sourceItemPath" ]; then
			echo -e "      File: \e[32m$itemName\e[0m"
		elif [ -d "$sourceItemPath" ]; then
			echo -e "    Folder: \e[35m$itemName\e[0m"
		fi
	done
	echo "$VE_line_60"


	echo
	echo


	echo -e "Inside of \"\e[34m${WLC_BASH_TOOLS___FOLDER_NAME___OF_CACHE}/.../\e[32m${wlcBashToolsRemotePreDeploymentFolderNameAtRemote}\e[0m\","
	echo -e "these items will be copied:"
	echo "$VE_line_60"
	for itemName in `ls -A "$wlcBashToolsRemotePreDeploymentFolderPathAtLocal"`; do
		sourceItemPath="$sourceFolderPath/$itemName"

		if [ -f "$sourceItemPath" ]; then
			echo -e "      File: \e[32m$itemName\e[0m"
		fi

		if [ -d "$sourceItemPath" ]; then
			echo -e "    Folder: \e[35m$itemName\e[0m"
		fi
	done
	echo "$VE_line_60"





	echo3
	colorful -n "Now s-copying wlc-bash-tools to remote machine..." textGreen
	scp    -rq    ${itemListToSend[@]}    $remoteHost:~    # $itemListToSend 不可以有引号！



	echo


	colorful -n "Now SSH connect to remote once, for triggering auto deployment at remote" textGreen
	echo5

	# 主动连接一次，以使【远程主机】上：
	#    1) 旧有的 wlc-bash-tools 版的 .bashrc，
	#    2) 或者上方 try-to-setup-non-standard-trigger-for-deployment-on-a-brand-new-remote-machine 代码在【远程主机】留下的临时代码
	# 能够被执行。
	ssh    "$remoteHost"
	echo5




	echo
	print-DONE
	echo
}
