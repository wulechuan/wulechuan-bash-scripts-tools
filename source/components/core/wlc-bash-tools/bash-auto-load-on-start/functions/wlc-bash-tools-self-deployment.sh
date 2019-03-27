function wlc-bash-tools-scopy-to-remote-for-later-deployment-at-remote {
	# $1 should be --from     for easier understanding, but it can actually be anything, as long as it's not absent.
	# $3 should be --to-host  for easier understanding, but it can actually be anything, as long as it's not absent.
	local sourceFolderPath="$2"
	local targetHost="$4"

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

	if     [[ ! "$targetHost" =~ ^[_a-zA-Z0-9]+@[0-9]+\.[0-9]+\.[0-9]+\.[0-9]+$ ]] \
	    && [[ ! "$targetHost" =~ ^[_a-zA-Z0-9]+@[_a-zA-Z0-9]+$                  ]]; then
		console.error    "Invalid targetHost \"\e[35m$targetHost\e[31m\""
		echo
		return 34
	fi



	print-header "Deploying \"wlc-bash-tools\" to another machine"

	colorful -- "Source folder: "
	colorful -n "$sourceFolderPath"    textGreen

	colorful -- "Target host:   "
	colorful -n "$targetHost"    textMagenta



	local timeStamp=`date +%Y-%m-%d_%H-%M-%S`

	local targetFolderNameAtRemote="${WLC_BASH_TOOLS___FOLDER_NAME_PREFIX___OF_NEW_INSTANCE_TO_DEPLOY}___${timeStamp}"
	local duplicationContainerFolderNameInLocalMachineCache="${targetHost}___${timeStamp}"

	local signalFilePathInLocalMachineCache="${WLC_BASH_TOOLS___FOLDER_PATH___OF_CACHE}/deployments-to-remote-machines/${duplicationContainerFolderNameInLocalMachineCache}/${WLC_BASH_TOOLS___FILE_NAME___OF_SIGNAL_OF_NEW_INSTANCE_TO_DEPLOY}"
	local duplicationPathInLocalMachineCache="${WLC_BASH_TOOLS___FOLDER_PATH___OF_CACHE}/deployments-to-remote-machines/${duplicationContainerFolderNameInLocalMachineCache}/$targetFolderNameAtRemote"

	if [ -d "$duplicationPathInLocalMachineCache" ]; then
		rm    -rf    "$duplicationPathInLocalMachineCache"
	fi

	mkdir    -p    "$duplicationPathInLocalMachineCache"

	cp    -r    "$sourceFolderPath"/.    "$duplicationPathInLocalMachineCache"


	echo
	echo
	echo
	colorful -n "Generating signal file to send to remote machine..."
	echo $targetFolderNameAtRemote > "$signalFilePathInLocalMachineCache"


	local itemName
	local sourceItemPath

	echo
	echo -e "Inside of \"\e[34m${WLC_BASH_TOOLS___FOLDER_NAME___OF_CACHE}/.../\e[32m${duplicationContainerFolderNameInLocalMachineCache}\e[0m\","
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
	scp    -rq    "$signalFilePathInLocalMachineCache"    "$duplicationPathInLocalMachineCache"    $targetHost:$targetFolderPathAtRemote

	echo
	print-DONE
	echo
}
