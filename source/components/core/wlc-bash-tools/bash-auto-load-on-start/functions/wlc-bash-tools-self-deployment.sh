function wlc-bash-tools-scopy-to-remote-for-later-deployment-at-remote {
	# $1 should be --from     for easier understanding, but it can actually be anything, as long as it's not absent.
	# $3 should be --to-host  for easier understanding, but it can actually be anything, as long as it's not absent.
	local sourceFolderPath="$2"
	local remoteHost="$4"

	local targetFolderPathAtRemote='~'



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



	print-header "Deploying \"wlc-bash-tools\" to another machine"

	colorful -- "Source folder: "
	colorful -n "$sourceFolderPath"    textGreen

	colorful -- "Target host:   "
	colorful -n "$remoteHost"          textMagenta



	local timeStamp=`date +%Y-%m-%d_%H-%M-%S`

	# something like "wlc-bash-tools___new-one-to-deploy___1979-03-19_11-22-33"
	local targetFolderNameAtRemote="${WLC_BASH_TOOLS___FOLDER_NAME_PREFIX___OF_NEW_INSTANCE_TO_DEPLOY}___${timeStamp}"
	local targetFolderNameAtRemoteTheVarNameLengthEqualsToContent="$targetFolderNameAtRemote"


	local nameOfFolderAsContainerOfDuplicationsToCopyToRemote="${remoteHost}___${timeStamp}"

	local __tempWorkingFolderPath="${WLC_BASH_TOOLS___FOLDER_PATH___OF_CACHE}/deployments-to-remote-machines/${nameOfFolderAsContainerOfDuplicationsToCopyToRemote}"
	local signalFilePathInLocalMachineCache="$__tempWorkingFolderPath/${WLC_BASH_TOOLS___FILE_NAME___OF_SIGNAL_OF_NEW_INSTANCE_TO_DEPLOY}"
	local duplicationPathInLocalMachineCache="$__tempWorkingFolderPath/$targetFolderNameAtRemote"


	# ########################## MAKING DUPLICATIONS ########################## #
	echo
	echo
	colorful -n "Making duplications, so that files can be put in correct folder at remote machine..."    textGreen

	if [ -d "$duplicationPathInLocalMachineCache" ]; then
		rm    -rf    "$duplicationPathInLocalMachineCache"
	fi
	mkdir    -p                             "$duplicationPathInLocalMachineCache"
	cp       -r    "$sourceFolderPath"/.    "$duplicationPathInLocalMachineCache"
	# ######################################################################### #




	# echo
	# echo
	# colorful -n "Generating signal file to send to remote machine..."    textGreen
	echo $targetFolderNameAtRemote > "$signalFilePathInLocalMachineCache"


	local itemName
	local sourceItemPath

	echo
	echo -e "Inside of \"\e[34m${WLC_BASH_TOOLS___FOLDER_NAME___OF_CACHE}/.../\e[32m${nameOfFolderAsContainerOfDuplicationsToCopyToRemote}\e[0m\","
	echo -e "this file will be copied:"
	echo "$VE_line_60"
	echo -e "      File: \e[32m$WLC_BASH_TOOLS___FILE_NAME___OF_SIGNAL_OF_NEW_INSTANCE_TO_DEPLOY\e[0m"
	echo "$VE_line_60"


	echo
	echo
	echo -e "Inside of \"\e[34m${WLC_BASH_TOOLS___FOLDER_NAME___OF_CACHE}/.../\e[32m${targetFolderNameAtRemote}\e[0m\","
	echo -e "these items will be copied:"
	echo "$VE_line_60"

	for itemName in `ls -A "$duplicationPathInLocalMachineCache"`; do
		sourceItemPath="$sourceFolderPath/$itemName"

		if [ -f "$sourceItemPath" ]; then
			echo -e "      File: \e[32m$itemName\e[0m"
		fi

		if [ -d "$sourceItemPath" ]; then
			echo -e "    Folder: \e[35m$itemName\e[0m"
		fi
	done

	echo "$VE_line_60"
	echo




	echo
	echo
	echo
	colorful -n "Now s-copying..." textGreen
	scp    -rq    "$signalFilePathInLocalMachineCache"    "$duplicationPathInLocalMachineCache"    $remoteHost:$targetFolderPathAtRemote





	
	echo
	echo
	echo
	print-header "Detecting remote ~/.bash_profile and ~/.bashrc"...
	detect-remote-file    "$remoteHost"    '~'    ".bash_profile"    "$__tempWorkingFolderPath"
	detect-remote-file    "$remoteHost"    '~'    ".bashrc"          "$__tempWorkingFolderPath"
	echo

	local pathOfLocalCacheFileOfRemoteBashProfile="$__tempWorkingFolderPath/.bash_profile"
	local pathOfLocalCacheFileOfRemoteBashRC="$__tempWorkingFolderPath/.bashrc"

	touch    "$pathOfLocalCacheFileOfRemoteBashProfile"
	touch    "$pathOfLocalCacheFileOfRemoteBashRC"

	local tempStatementMarkerString='THIS_LINE_IS_ADDED_TEMPORARILY_BY_WLC_BASH_TOOLS'
	local tempStatementMarkerStringVarNameLengthEquals2="$tempStatementMarkerString"

	local remoteAutorunFileMentionedTempAutorunStatements=`cat   "$pathOfLocalCacheFileOfRemoteBashProfile"` | grep "$tempStatementMarkerString"
	local remoteAutorunFileMentionedWLCBashToolsStartDotSH=`cat "$pathOfLocalCacheFileOfRemoteBashRC"`      | grep '"\$WLC_BASH_TOOLS___FOLDER_PATH/start.sh"'


	echo -en "Remote autorun file mentioned \e[32mtemp autorun statements\e[0m: "
	if [ -z "$remoteAutorunFileMentionedTempAutorunStatements" ]; then
		echo -e "\e[31mno\e[0m"
	else
		echo -e "\e[35myes\e[0m"
	fi

	echo -en "Remote autorun file mentioned \e[32m~/wlc-bash-tools/start.sh\e[0m: "
	if [ -z "$remoteAutorunFileMentionedWLCBashToolsStartDotSH" ]; then
		echo -e "\e[31mno\e[0m"
	else
		echo -e "\e[35myes\e[0m"
	fi

	if  [ -z "$remoteAutorunFileMentionedTempAutorunStatements" ] && [ -z "$remoteAutorunFileMentionedWLCBashToolsStartDotSH" ]; then
		echo
		colorful -n "Appending temp autorun statement to cache of remote \".bash_profile\"..."    textGreen

		echo "if [ -d ~/$targetFolderNameAtRemoteTheVarNameLengthEqualsToContent ]; then       # $tempStatementMarkerString" >> "$pathOfLocalCacheFileOfRemoteBashProfile"
		echo "    cd ~/$targetFolderNameAtRemoteTheVarNameLengthEqualsToContent                # $tempStatementMarkerString" >> "$pathOfLocalCacheFileOfRemoteBashProfile"
		echo "    ./to-install-wlc-bash-tools-locally.sh    --no-interactions                  # $tempStatementMarkerString" >> "$pathOfLocalCacheFileOfRemoteBashProfile"
		echo "    sed -i '/${tempStatementMarkerStringVarNameLengthEquals2}/d' ~/.bash_profile # $tempStatementMarkerString" >> "$pathOfLocalCacheFileOfRemoteBashProfile"
		echo "    logout                                                                       # $tempStatementMarkerString" >> "$pathOfLocalCacheFileOfRemoteBashProfile"
		echo "fi                                                                               # $tempStatementMarkerString" >> "$pathOfLocalCacheFileOfRemoteBashProfile"

		colorful -n "Uploading modified \".bash_profile\" to remote..."    textGreen
		scp    -q    "$pathOfLocalCacheFileOfRemoteBashProfile"    "$remoteHost:~"
	fi


	echo $VE_line_60
	local nameOfTempSignalFileForPreventingRemoteMachineFromInteractionsDuringUpComingSelfDeployment='.wlc-bash-tools___should-not-allow-interations-during-up-coming-deployment-of-itself'
	touch    "$__tempWorkingFolderPath/$nameOfTempSignalFileForPreventingRemoteMachineFromInteractionsDuringUpComingSelfDeployment"
	scp    -q    "$__tempWorkingFolderPath/$nameOfTempSignalFileForPreventingRemoteMachineFromInteractionsDuringUpComingSelfDeployment"    "$remoteHost:~"
	echo -e "\e[32mSent a signal file. At remote it's:\n    \e[33m~/$nameOfTempSignalFileForPreventingRemoteMachineFromInteractionsDuringUpComingSelfDeployment\e[0m"
	echo $VE_line_60

	echo
	echo
	echo
	echo
	echo



	# 主动连接一次，以使【远程主机】上旧有的 wlc-bash-tools 版的 .bashrc，或者上方代码在【远程主机】留下的临时代码能够被执行。
	ssh    "$remoteHost"



	echo
	echo
	echo
	echo
	echo

	print-DONE
	echo
}
