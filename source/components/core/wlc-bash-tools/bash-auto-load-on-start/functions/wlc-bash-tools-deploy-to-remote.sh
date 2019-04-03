function wlc_bash_tools--deploy_to_remote {
    # Usage:
    #     <this function>    "<remote host name or ip>"
    #     <this function>    --to-host="<remote host name or ip>"    [ --source-package-folder-name="<package folder name>" | --source-package-folder-path="<package folder path>" ]    [ --remote-user-name="<user name used at remote>" ]
    #
    # Examples:
    #     <this function>    --to-host="19.79.3.19"
    #     <this function>    --to-host="wulechuan@19.79.3.19"
    #     <this function>    --to-host="19.79.3.19"    --remote-user-name="wulechuan"
    #     <this function>    --to-host="19.79.3.19"    --source-package-folder-name="my-personal-data-server"
    #     <this function>    --to-host="19.79.3.19"    --source-package-folder-path="/d/backup/my-old-data-server-in-1979"

    function wlc_bash_tools--deploy_to_remote--print-help {
        local nameOfThisFunction='wlc_bash_tools--deploy_to_remote'
        local colorOfArgumentName='textGreen'
        local colorOfArgumentValue='textMagenta'
        local colorOfMarkers='textBlue'

        echo

        colorful -n 'Usage:'

        colorful -- "    $nameOfThisFunction"
        colorful -n "    \"<remote host name or ip, user name is optional>\""    $colorOfArgumentValue
        echo



        colorful -- "    $nameOfThisFunction"
        colorful -n ' \\'

        colorful -- "        --to-host="    $colorOfArgumentName
        colorful -- "\"<remote host name or ip, user name is optional>\""    $colorOfArgumentValue
        colorful -n ' \\'

        colorful -- "        [ "    $colorOfMarkers
        colorful -- "--remote-user-name="    $colorOfArgumentName
        colorful -- "\"<user name used at remote>\""    $colorOfArgumentValue
        colorful -- " ]"    $colorOfMarkers
        colorful -n ' \\'

        colorful -- "        [ "    $colorOfMarkers
        colorful -- "--source-package-folder-name="    $colorOfArgumentName
        colorful -- "\"<package folder name>\""    $colorOfArgumentValue
        colorful -- " | "    $colorOfMarkers
        colorful -- "--source-package-folder-path="    $colorOfArgumentName
        colorful -- "\"<package folder path>\""    $colorOfArgumentValue
        colorful -- " ]"    $colorOfMarkers
        echo
        echo




        colorful -n 'Examples:'

        colorful -- "    $nameOfThisFunction"
        colorful -- "    --to-host="    $colorOfArgumentName
        colorful -- "19.79.3.19"    $colorOfArgumentValue
        echo
        echo

        colorful -- "    $nameOfThisFunction"
        colorful -- "    --to-host="    $colorOfArgumentName
        colorful -- "wulechuan@19.79.3.19"    $colorOfArgumentValue
        echo
        echo

        colorful -- "    $nameOfThisFunction"
        colorful -- "    --to-host="    $colorOfArgumentName
        colorful -- "19.79.3.19"    $colorOfArgumentValue
        colorful -- "    --remote-user-name="    $colorOfArgumentName
        colorful -- "\"wulechuan\""    $colorOfArgumentValue
        echo
        echo

        colorful -- "    $nameOfThisFunction"
        colorful -n ' \\'
        colorful -- "        --to-host="    $colorOfArgumentName
        colorful -- "19.79.3.19"    $colorOfArgumentValue
        colorful -n ' \\'
        colorful -- "        --source-package-folder-name="    $colorOfArgumentName
        colorful -- "\"my-wlc-bash-tools-for-data-server\""    $colorOfArgumentValue
        echo
        echo

        colorful -- "    $nameOfThisFunction"
        colorful -n ' \\'
        colorful -- "        --source-package-folder-path="    $colorOfArgumentName
        colorful -- "~/backup/my-wlc-bash-tools-for-old-data-server-in-1979"    $colorOfArgumentValue
        colorful -n ' \\'
        colorful -- "        --to-host="    $colorOfArgumentName
        colorful -- "wulechuan@19.79.3.19"    $colorOfArgumentValue
        echo
        echo
    }


	function wlc_bash_tools--deploy_to_remote--core {
        # Usage:
        #     <this function>    --from-source-package-folder-path="<package folder path>"    --to-host="<remote host name or ip>"
        #
        # Examples:
        #     wlc_bash_tools--deploy_to_remote--core    --from-source-package-folder-path="/d/backup/my-old-data-server-in-1979"    --to-host="wulechuan@19.79.3.19"

        local _sourceFolderPath="${1:34}"
        local _remoteID="${2:10}"


        local    -a    listOfItemsToSend


		function try-to-setup-non-standard-trigger-for-deployment-on-a-brand-new-remote-machine {
			# 下方用很长的名称，特别是尾部借助多个下划线进一步延长名称，仅仅是为了方便对齐由 echo 所书写的远程代码片段。
			local wlcBashToolsRemotePreDeploymentFolderNameAtRemote______="${1:29}" # --pre-deployment-folder-name="..."
			local localWorkingCacheFolderPath="${2:22}"                             # --working-folder-path="..."

			wlc-print-header "Detecting remote \e[35m~/.bash_profile\e[32m and \e[35m~/.bashrc\e[32m..."
			detect-remote-file    "$_remoteID"    '~'    ".bash_profile"    "$localWorkingCacheFolderPath"
			detect-remote-file    "$_remoteID"    '~'    ".bashrc"          "$localWorkingCacheFolderPath"

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



                # Value of `0` means we should actually
                # inject and utilize some temp auto-run statements.
				return 0
			fi


			rm    -f    "$pathOfLocalCacheFileOfRemoteBashProfile"



            # Value of `1 means there are no needs
            # to inject or utilize any temp auto-run statements.
            # It's ok to simply take the so-called standard way,
            # aka the wlc-bash-tools way, to auto deploy a new instance.
			return 1
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
			echo -e "these signal files for auto deployment will be s-copied:"
			echo "$VE_line_60"
			echo -e "    \e[32m$WLC_BASH_TOOLS___FILE_NAME___OF_SIGNAL_OF_NEW_INSTANCE_TO_DEPLOY\e[0m"
			echo -e "    \e[32m$WLC_BASH_TOOLS___FILE_NAME___OF_SIGNAL_OF_AUTO_LOGGING_OUT\e[0m"
			echo "$VE_line_60"
		}




		wlc-print-header "Deploy \"\e[35mwlc bash tools\e[32m\" to another machine"

		colorful -- "Source folder: "
		colorful -n "$_sourceFolderPath"    textGreen

		colorful -- "Target host:   "
		colorful -n "$_remoteID"            textMagenta



		local timeStamp=`date +%Y-%m-%d_%H-%M-%S`

		# something like "wlc-bash-tools___new-one-to-deploy___1979-03-19_12-34-56"
		local wlcBashToolsRemotePreDeploymentFolderNameAtRemote="${WLC_BASH_TOOLS___FOLDER_NAME_PREFIX___OF_NEW_INSTANCE_TO_DEPLOY}___${timeStamp}"
		local localTempWorkingFolderName="${_remoteID}___${timeStamp}"
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
		cp       -r    "$_sourceFolderPath"/.    "$wlcBashToolsRemotePreDeploymentFolderPathAtLocal"

		itemListToSend+=("$wlcBashToolsRemotePreDeploymentFolderPathAtLocal")
		# ######################################################################### #






		# local sourceItemPath
		# 	if   [ -f "$sourceItemPath" ]; then
		# echo; echo; for sourceItemPath in ${itemListToSend[@]}; do
		# 		echo -e "\e[30;42mDEBUG\e[0m   File: \e[32m$sourceItemPath\e[0m"
		# 	elif [ -d "$sourceItemPath" ]; then
		# 		echo -e "\e[30;42mDEBUG\e[0m Folder: \e[35m$sourceItemPath\e[0m"
		# 	fi
		# done; echo


		echo
		echo


		echo -e "Inside of \"\e[34m${WLC_BASH_TOOLS___FOLDER_NAME___OF_CACHE}/.../\e[32m${localTempWorkingFolderName}\e[0m\","
		echo -e "these items will be s-copied:"
		wlc-print-direct-children    "$localTempWorkingFolderPath"


		echo
		echo


		echo -e "Inside of \"\e[34m${WLC_BASH_TOOLS___FOLDER_NAME___OF_CACHE}/.../\e[32m${wlcBashToolsRemotePreDeploymentFolderNameAtRemote}\e[0m\","
		echo -e "these items will be s-copied:"
		wlc-print-direct-children    "$wlcBashToolsRemotePreDeploymentFolderPathAtLocal"




		echo3
		colorful -- 'Now s-copying '           textGreen
		colorful -- "wlc bash tools"           textMagenta
		colorful -n ' to remote machine...'    textGreen
		scp    -rq    ${itemListToSend[@]}    $_remoteID:~    # $itemListToSend 不可以有引号！



		echo


		colorful -n "Now SSH connect to remote once, for triggering auto deployment at remote" textGreen
		echo5

		# 主动连接一次，以使【远程主机】上：
		#    1) 旧有的 wlc-bash-tools 版的 .bashrc，
		#    2) 或者上方 try-to-setup-non-standard-trigger-for-deployment-on-a-brand-new-remote-machine 代码在【远程主机】留下的临时代码
		# 能够被执行。
		ssh    "$_remoteID"
		echo5




		echo
		print-DONE
		echo
	}





    local stageReturnCode



    local duplicatedArgumentEncountered

    local remoteHostNameOrIPAddressIsProvided=0
    local remoteUserNameIsProvededSeparately=0
    local sourceFolderNameIsProvided=0
    local sourceFolderPathIsProvided=0

    local remoteHostRawValue
    local remoteUserName
    local sourceFolderName
    local sourceFolderPath

    local currentArgument

    if [ $# -eq 0 ]; then
        wlc_bash_tools--deploy_to_remote--print-help
        return 0
    fi

    if [ $# -eq 1 ] && [[ ! "$1" =~ ^--to-host=.+ ]]; then
        remoteHostRawValue="$1"
        remoteHostNameOrIPAddressIsProvided=1
        shift
    fi

    while true; do
        if [ $# -eq 0 ]; then
            break
        fi

        currentArgument="$1"
        shift

        case "$currentArgument" in
            --to-host=*)
                if [ $remoteHostNameOrIPAddressIsProvided -gt 0 ]; then
                    duplicatedArgumentEncountered='--to-host='
                    break
                fi
                remoteHostRawValue=${currentArgument:10}
                remoteHostNameOrIPAddressIsProvided=1
                ;;

            --remote-user-name=*)
                if [ $remoteUserNameIsProvededSeparately -gt 0 ]; then
                    duplicatedArgumentEncountered='--remote-user-name='
                    break
                fi
                remoteUserName=${currentArgument:19}
                remoteUserNameIsProvededSeparately=1
                ;;

            --source-package-folder-name=*)
                if [ $sourceFolderNameIsProvided -gt 0 ]; then
                    duplicatedArgumentEncountered='--source-package-folder-name='
                    break
                fi
                sourceFolderName=${currentArgument:29}
                sourceFolderNameIsProvided=1
                ;;

            --source-package-folder-path=*)
                if [ $sourceFolderPathIsProvided -gt 0 ]; then
                    duplicatedArgumentEncountered='--source-package-folder-path='
                    break
                fi
                sourceFolderPath=${currentArgument:29}
                sourceFolderPathIsProvided=1
                ;;

            *)
                colorful -- 'Unknow argument "'    textYellow
                colorful -- "$currentArgument"     textRed
                colorful -n '" is skipped'         textYellow
                ;;

        esac
    done


    # echo -e "\e[30;42mDEBUG\e[0m\n    remoteHostRawValue=\"\e[33m${remoteHostRawValue}\e[0m\"\n    remoteUserName=\"\e[33m${remoteUserName}\e[0m\"\n    sourceFolderName=\"\e[33m${sourceFolderName}\e[0m\"\n    sourceFolderPath=\"\e[33m${sourceFolderPath}\e[0m\""

    if [ ! -z "$duplicatedArgumentEncountered" ]; then
        echo
        wlc-print-error    "Duplicated argument \"\e[33m${duplicatedArgumentEncountered}\e[31m\"."
        wlc_bash_tools--deploy_to_remote--print-help
        return 99
    fi


    local remoteHostNameOrIPAddress
    local remoteUserNameInRemoteHostRawValue

    wlc-validate-host-id-or-ip-address-with-optional-user-name    "$remoteHostRawValue"    remoteHostNameOrIPAddress    remoteUserNameInRemoteHostRawValue
    stageReturnCode=$?

	if [ $stageReturnCode -gt 0 ]; then
        echo
		wlc-print-error    "Invalid value \"\e[33m$remoteHostRawValue\e[31m\" for argument \"\e[32m--to-host=\e[31m\"."
        wlc_bash_tools--deploy_to_remote--print-help
		return 1
	fi

    # echo -e "\e[30;42mDEBUG\e[0m\n    remoteHostNameOrIPAddress=\"\e[33m${remoteHostNameOrIPAddress}\e[0m\"\n    remoteUserNameInRemoteHostRawValue=\"\e[33m${remoteUserNameInRemoteHostRawValue}\e[0m\""

    if [ $remoteUserNameIsProvededSeparately -gt 0 ] && [ ! -z "$remoteUserNameInRemoteHostRawValue" ] && [ "$remoteUserName" != "$remoteUserNameInRemoteHostRawValue" ]; then
        echo
        wlc-print-error    "Remote user name was provided both in \e[33m--to-host=\"${remoteHostRawValue}\"\e[31m and \e[33m--remote-user-name=\"${remoteUserName}\"\e[31m."
        wlc_bash_tools--deploy_to_remote--print-help
        return 2
    fi

    if [ ! -z "$remoteUserNameInRemoteHostRawValue" ]; then
        remoteUserName="$remoteUserNameInRemoteHostRawValue"
    fi

    if [ -z "$remoteUserName" ]; then
        remoteUserName='root'
        echo
        colorful -- 'Remote user name'    textBrightCyan
        colorful -- ' was not provided. Thus "'    textGreen
        colorful -- 'root'    textMagenta
        colorful -n '" is assumed.'    textGreen
        echo
    fi


    local remoteID="$remoteUserName@$remoteHostNameOrIPAddress"



    if [ $sourceFolderNameIsProvided -gt 0 ] && [ $sourceFolderPathIsProvided -gt 0 ]; then
        wlc-print-error    "Both \"\e[33m--source-package-folder-name\e[31m\" and \"\e[33m--source-package-folder-path\e[31m\" were provided."
        wlc_bash_tools--deploy_to_remote--print-help
        return 20
    fi



    if [ $sourceFolderNameIsProvided -eq 0 ] && [ $sourceFolderPathIsProvided -eq 0 ]; then
        sourceFolderName="$WLC_BASH_TOOLS___FOLDER_NAME___OF_DEFAULT_PACKAGE_TO_DEPLOY_TO_REMOTE"

        colorful -- 'Neither "'    textGreen
        colorful -- '--source-package-folder-name'    textBrightCyan
        colorful -- '" nor "'    textGreen
        colorful -- '--source-package-folder-path'    textBrightCyan
        colorful -n '" were provided.'    textGreen

        colorful -- 'Thus the default "'    textGreen
        colorful -- "$WLC_BASH_TOOLS___FOLDER_NAME___OF_DEFAULT_PACKAGE_TO_DEPLOY_TO_REMOTE"    textMagenta
        colorful -n '" is assumed.'    textGreen

        echo
    fi

    if [ $sourceFolderPathIsProvided -eq 0 ]; then
        sourceFolderPath="$WLC_BASH_TOOLS___FOLDER_PATH___OF_WLC_BASH_TOOLS_FOR_OTHER_MACHINES/$sourceFolderName"
    fi



    if [ ! -d "$sourceFolderPath" ]; then
        wlc-print-error    'The evaluated folder path of package to depoly to a remote machine is invalid, which is'

        colorful -- '    "'    textRed
        colorful -- "$sourceFolderPath"    textYellow
        colorful -n '"'    textRed
        echo

        colorful -n 'Involved variables:'    textRed

        colorful -- '$WLC_BASH_TOOLS___FOLDER_PATH___OF_WLC_BASH_TOOLS_FOR_OTHER_MACHINES="'    textRed
        colorful -- "$WLC_BASH_TOOLS___FOLDER_PATH___OF_WLC_BASH_TOOLS_FOR_OTHER_MACHINES"      textYellow
        colorful -n '"'    textRed

        colorful -- 'argument: --source-package-folder-name="'    textRed
        colorful -- "$sourceFolderName"    textYellow
        colorful -n '"'    textRed

        colorful -- 'argument: --source-package-folder-path="'    textRed
        colorful -- "$sourceFolderPath"    textYellow
        colorful -n '"'    textRed

        echo
        colorful -n 'Thus, the deployment to a remote machine is not possible.'    textRed
        echo3

        return 30
    fi

    if [ "$sourceFolderPath" == "$HOME" ] || [ "$sourceFolderPath" == ~ ]; then
        echo
        wlc-print-error    "Cannot deploy \e[32m~\e[31m instance of \e[33m$WLC_BASH_TOOLS___FOLDER_NAME\e[31m to remote."
        return 31
    fi



    echo3



    wlc--ssh_copy_id    "$remoteID"
    stageReturnCode=$?
    # if [ $stageReturnCode -gt 0 ]; then
    #     return $stageReturnCode
    # fi



    wlc_bash_tools--deploy_to_remote--core    --from-source-package-folder-path="$sourceFolderPath"   --to-host="$remoteID"
    stageReturnCode=$?
    if [ $stageReturnCode -gt 0 ]; then
        return $stageReturnCode
    fi



    # wlc_bash_tools--design_host_name_for_remote_machine    "$remoteHostNameOrIPAddress"
    # stageReturnCode=$?
    # if [ $stageReturnCode -gt 0 ]; then
    #     return $stageReturnCode
    # fi



    echo3
    wlc-print-message-of-source    'function'    'wlc_bash_tools--deploy_to_remote'
    print-DONE
    echo3
}

function wlc_bash_tools--design_host_name_for_remote_machine {
    local remoteHostNameOrIPAddress="${1}"
    local sourceFolderPath="${2}"
    local remoteHostNameDefaultPrefix='computer'

    local tempWorkingFolderName
    local tempWorkingFolderPath

    while true; do
        tempWorkingFolderName="wlc-bash-tools-package-for-remote-installation--$RANDOM"
        tempWorkingFolderPath="$WLC_BASH_TOOLS___FOLDER_PATH___OF_CACHE/$tempWorkingFolderName"

        if [ ! -d "$tempWorkingFolderPath" ]; then
            mkdir -p "$tempWorkingFolderPath"
            break
        fi
    done





    echo3
    wlc-print-header "Design the hostname for the remote machine:"


    local safeStringToUseInHostName="ip-${remoteHostNameOrIPAddress//./-}"
    local preferredHostNameFileFolderPath="$sourceFolderPath/$WLC_BASH_TOOLS___FOLDER_NAME/$WLC_BASH_TOOLS___FOLDER_NAME___OF_ASSETS"
    local preferredHostNameFilePath="$preferredHostNameFileFolderPath/default-computer-name"

    local computerNamePrefixForRemoteMachine="$remoteHostNameDefaultPrefix"


    if [ -f "$preferredHostNameFilePath" ]; then
        local computerNamePrefixViaFile=`cat "$preferredHostNameFilePath"`

        if [ ! -z "$computerNamePrefixViaFile" ]; then
            computerNamePrefixForRemoteMachine="$computerNamePrefixViaFile"
        fi
    fi

    local computerNameForRemoteMachine="${computerNamePrefixForRemoteMachine}-${safeStringToUseInHostName}"

    colorful -- 'Please input the '                                       textGreen
    colorful -- 'hostname'                                                textMagenta
    colorful -n ' for the remote machine, simply for easy recognition.'   textGreen

    colorful -n 'You may skip this by press the <ENTER> key directly.'

    colorful -- '(60 seconds for decision, default is "'
    colorful -- "$computerNameForRemoteMachine"   textGreen
    colorful -n '")'

    colorful -- "hostname: "

    local            userInputComputerNameForRemoteMachine
    read    -t 60    userInputComputerNameForRemoteMachine
    stageReturnCode=$?
    if [ "$stageReturnCode" -gt 0 ]; then
        echo
    fi

    if [ -z "$userInputComputerNameForRemoteMachine" ]; then
        echo '<Skipped>'
    else
        computerNameForRemoteMachine="$userInputComputerNameForRemoteMachine"
    fi





    local nameOfFileForCarryingComputerNameOfRemoteMachine='computer-name'
    local pathOfFileForCarryingComputerNameOfRemoteMachine="$tempWorkingFolderPath/$nameOfFileForCarryingComputerNameOfRemoteMachine"
    echo "$computerNameForRemoteMachine" > "$pathOfFileForCarryingComputerNameOfRemoteMachine"

    echo
    colorful -- 'The hostname of the remote machine('
    colorful -- "$remoteHostNameOrIPAddress"    textYellow
    colorful -n ') will be:'
    colorful -n "$computerNameForRemoteMachine"        textGreen
    echo
    echo





    echo3
    scp        -q    "$pathOfFileForCarryingComputerNameOfRemoteMachine"    "$remoteID:~/$WLC_BASH_TOOLS___FOLDER_NAME/$WLC_BASH_TOOLS___FOLDER_NAME___OF_ASSETS"




    echo3

    wlc-print-header "Removing temp folder..."
    colorful -n "Removing folder:"    textRed
    colorful -n "    \"$tempWorkingFolderPath\""    textYellow
    rm    -rf    "$tempWorkingFolderPath"
}