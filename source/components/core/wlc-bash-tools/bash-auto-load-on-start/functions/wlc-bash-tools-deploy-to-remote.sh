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
        colorful -n "$VE_line_60"
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

        local _sourceFolderPath_="${1:34}"
        local _remoteID_="${2:10}"

        local    -a    listOfItemsToSend




		function try-to-setup-non-standard-trigger-for-deployment-on-a-brand-new-remote-machine {
			# 下方用很长的名称，特别是尾部借助多个下划线进一步延长名称，仅仅是为了方便对齐由 echo 所书写的远程代码片段。
			local wlcBashToolsRemotePreDeploymentFolderName______________="${1:29}" # --pre-deployment-folder-name="..."
			local __localWorkingCacheFolderPath__="${2:22}"                         # --working-folder-path="..."
            local __remote_id_in_non_standard_trigger_function__="${3:12}"          # --remote-id="..."

			wlc-print-header "Detecting remote \e[35m~/.bash_profile\e[32m and \e[35m~/.bashrc\e[32m..."
			detect-remote-file    "$__remote_id_in_non_standard_trigger_function__"    '~'    ".bash_profile"    "$__localWorkingCacheFolderPath__"
			detect-remote-file    "$__remote_id_in_non_standard_trigger_function__"    '~'    ".bashrc"          "$__localWorkingCacheFolderPath__"

			echo

			local __pathOfLocalCacheFileOfRemoteBashProfile__="$__localWorkingCacheFolderPath__/.bash_profile"
			local __pathOfLocalCacheFileOfRemoteBashRC_______="$__localWorkingCacheFolderPath__/.bashrc"

			touch    "$__pathOfLocalCacheFileOfRemoteBashProfile__"
			touch    "$__pathOfLocalCacheFileOfRemoteBashRC_______"

			local tempStatementMarkerString='THIS_LINE_IS_ADDED_TEMPORARILY_BY_WLC_BASH_TOOLS'
			local tempStatementMarkerString____________________="$tempStatementMarkerString"


			local remoteAutorunFileMentionedTempAutorunStatements_=`cat "$__pathOfLocalCacheFileOfRemoteBashProfile__" | grep "$tempStatementMarkerString"`
			local remoteAutorunFileMentionedWLCBashToolsStartDotSH=`cat "$__pathOfLocalCacheFileOfRemoteBashRC_______" | grep '"$WLC_BASH_TOOLS___FOLDER_PATH/start.sh"'`

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


			rm    -f    "$__pathOfLocalCacheFileOfRemoteBashRC_______"


			if  [ -z "$remoteAutorunFileMentionedTempAutorunStatements_" ] && [ -z "$remoteAutorunFileMentionedWLCBashToolsStartDotSH" ]; then
				echo
				colorful -n "Appending temp autorun statements to locally cached \".bash_profile\"..."    textGreen

				echo "if [ -d ~/$wlcBashToolsRemotePreDeploymentFolderName______________ ]; then       # $tempStatementMarkerString" >> "$__pathOfLocalCacheFileOfRemoteBashProfile__"
				echo "    cd ~/$wlcBashToolsRemotePreDeploymentFolderName______________                # $tempStatementMarkerString" >> "$__pathOfLocalCacheFileOfRemoteBashProfile__"
				echo "    ./to-install-wlc-bash-tools-locally.sh    --no-interactions                  # $tempStatementMarkerString" >> "$__pathOfLocalCacheFileOfRemoteBashProfile__"
				echo "    sed -i '/${tempStatementMarkerString____________________}/d' ~/.bash_profile # $tempStatementMarkerString" >> "$__pathOfLocalCacheFileOfRemoteBashProfile__"
				echo "    logout                                                                       # $tempStatementMarkerString" >> "$__pathOfLocalCacheFileOfRemoteBashProfile__"
				echo "fi                                                                               # $tempStatementMarkerString" >> "$__pathOfLocalCacheFileOfRemoteBashProfile__"


				listOfItemsToSend+=("$__pathOfLocalCacheFileOfRemoteBashProfile__")



                # Value of `0` means we should actually
                # inject and utilize some temp auto-run statements.
				return 0
			fi


			rm    -f    "$__pathOfLocalCacheFileOfRemoteBashProfile__"



            # Value of `1 means there are no needs
            # to inject or utilize any temp auto-run statements.
            # It's ok to simply take the so-called standard way,
            # aka the wlc-bash-tools way, to auto deploy a new instance.
			return 1
		}


		function setup-standard-signal-file-for-remote-auto-deployment {
			local ___remotePreDeploymentFolderName___="${1:29}" # --pre-deployment-folder-name="..."
			local ___localWorkingTempFolderPath__________="${2:22}" # --working-folder-path="..."

			local ___remoteSignalFilesContainingFolderPathAtLocal___="$___localWorkingTempFolderPath__________/$WLC_BASH_TOOLS___FOLDER_NAME___OF_SIGNALS"
			mkdir    -p    "$___remoteSignalFilesContainingFolderPathAtLocal___"

			local ___remoteSignalFile_1_pathAtLocalCache___="$___remoteSignalFilesContainingFolderPathAtLocal___/${WLC_BASH_TOOLS___FILE_NAME___OF_SIGNAL_OF_NEW_INSTANCE_TO_DEPLOY}"
			echo $___remotePreDeploymentFolderName___ > "$___remoteSignalFile_1_pathAtLocalCache___"

			local ___remoteSignalFile_2_pathAtLocalCache___="$___remoteSignalFilesContainingFolderPathAtLocal___/${WLC_BASH_TOOLS___FILE_NAME___OF_SIGNAL_OF_AUTO_LOGGING_OUT}"
			touch    "$___remoteSignalFile_2_pathAtLocalCache___"

			listOfItemsToSend+=("$___remoteSignalFilesContainingFolderPathAtLocal___")

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
		colorful -n "$_sourceFolderPath_"    textGreen

		colorful -- "Target host:   "
		colorful -n "$_remoteID_"            textMagenta



		local timeStamp=`date +%Y-%m-%d_%H-%M-%S`

        local stageReturnCode

		# something like "wlc-bash-tools___new-one-to-deploy___1979-03-19_12-34-56"
		local wlcBashToolsRemotePreDeploymentFolderName="${WLC_BASH_TOOLS___FOLDER_NAME_PREFIX___OF_NEW_INSTANCE_TO_DEPLOY}___${timeStamp}"
		local localTempWorkingFolderName="${_remoteID_}___${timeStamp}"
		local _localTempWorkingFolderPath_="${WLC_BASH_TOOLS___FOLDER_PATH___OF_CACHE}/deployments-to-remote-machines/${localTempWorkingFolderName}"
		mkdir    -p    "$_localTempWorkingFolderPath_"




		echo3



        local _decidedRemoteComputerName_
        local _remoteComputerNameDefaultPrefix_
        local pathOfPreferredComputerNamePrefixFileInThePackage="$sourceFolderPath/$WLC_BASH_TOOLS___FOLDER_NAME/$WLC_BASH_TOOLS___FOLDER_NAME___OF_ASSETS/default-computer-name-prefix"
        if [ -f "$pathOfPreferredComputerNamePrefixFileInThePackage" ]; then
            _remoteComputerNameDefaultPrefix_=`cat "$pathOfPreferredComputerNamePrefixFileInThePackage"`
        fi
        wlc--design_computer_name_for_remote_machine--core \
            --remote-host-name-or-ip-address="$remoteHostNameOrIPAddress" \
            --default-computer-name-prefix="$_remoteComputerNameDefaultPrefix_" \
            _decidedRemoteComputerName_

        stageReturnCode=$?
        if [ $stageReturnCode -gt 0 ]; then
            return $stageReturnCode
        fi



		try-to-setup-non-standard-trigger-for-deployment-on-a-brand-new-remote-machine \
			--pre-deployment-folder-name="$wlcBashToolsRemotePreDeploymentFolderName" \
				   --working-folder-path="$_localTempWorkingFolderPath_" \
                             --remote-id="$_remoteID_"



		local valueOfOneMeansShouldTakeStandardWay=$?
		if [ "$valueOfOneMeansShouldTakeStandardWay" -eq 1 ]; then
			setup-standard-signal-file-for-remote-auto-deployment \
				--pre-deployment-folder-name="$wlcBashToolsRemotePreDeploymentFolderName" \
					   --working-folder-path="$_localTempWorkingFolderPath_"
		fi










		# ########################## MAKING DUPLICATIONS ########################## #
		# echo
		# echo
		# colorful -n "Making duplications, so that files can be put in correct folder at remote machine..."    textGreen

		local wlcBashToolsRemotePreDeploymentFolderPathAtLocal="$_localTempWorkingFolderPath_/$wlcBashToolsRemotePreDeploymentFolderName"

		if [          -d "$wlcBashToolsRemotePreDeploymentFolderPathAtLocal" ]; then
			rm    -rf    "$wlcBashToolsRemotePreDeploymentFolderPathAtLocal"
		fi

		mkdir    -p                               "$wlcBashToolsRemotePreDeploymentFolderPathAtLocal"
		cp       -r    "$_sourceFolderPath_"/.    "$wlcBashToolsRemotePreDeploymentFolderPathAtLocal"

		listOfItemsToSend+=("$wlcBashToolsRemotePreDeploymentFolderPathAtLocal")
		# ######################################################################### #




        echo
        colorful -- 'Saving decided computer name, which is "'    textGreen
        colorful -- "$_decidedRemoteComputerName_"    textMagenta
        colorful -n '", into file...'    textGreen
        echo "$_decidedRemoteComputerName_" > "$wlcBashToolsRemotePreDeploymentFolderPathAtLocal/$WLC_BASH_TOOLS___FOLDER_NAME/$WLC_BASH_TOOLS___FOLDER_NAME___OF_ASSETS/computer-name"






		# local __debug_sourceItemPath__
		# echo; echo; for __debug_sourceItemPath__ in ${listOfItemsToSend[@]}; do
		# 	if   [ -f "$__debug_sourceItemPath__" ]; then
		# 		echo -e "\e[30;42mDEBUG\e[0m \${listOfItemsToSend[@]}   File: \e[32m$__debug_sourceItemPath__\e[0m"
		# 	elif [ -d "$__debug_sourceItemPath__" ]; then
		# 		echo -e "\e[30;42mDEBUG\e[0m \${listOfItemsToSend[@]} Folder: \e[35m$__debug_sourceItemPath__\e[0m"
		# 	fi
		# done; echo


		echo
		echo


		echo -e "Inside of \"\e[34m${WLC_BASH_TOOLS___FOLDER_NAME___OF_CACHE}/.../\e[32m${localTempWorkingFolderName}\e[0m\","
		echo -e "these items will be s-copied:"
		wlc-print-direct-children    "$_localTempWorkingFolderPath_"


		echo
		echo


		echo -e "Inside of \"\e[34m${WLC_BASH_TOOLS___FOLDER_NAME___OF_CACHE}/.../\e[32m${wlcBashToolsRemotePreDeploymentFolderName}\e[0m\","
		echo -e "these items will be s-copied:"
		wlc-print-direct-children    "$wlcBashToolsRemotePreDeploymentFolderPathAtLocal"




		echo3

		colorful -- 'Now s-copying '             textGreen
		colorful -- "wlc bash tools"             textMagenta
		colorful -n ' to remote machine...'      textGreen

		scp    -rq    ${listOfItemsToSend[@]}    $_remoteID_:~    # $listOfItemsToSend 不可以有引号！



		echo


		colorful -n "Now SSH connect to remote once, for triggering auto deployment at remote" textGreen
		echo5

		# 主动连接一次，以使【远程主机】上：
		#    1) 旧有的 wlc-bash-tools 版的 .bashrc，
		#    2) 或者上方 try-to-setup-non-standard-trigger-for-deployment-on-a-brand-new-remote-machine 代码在【远程主机】留下的临时代码
		# 能够被执行。
		ssh    "$_remoteID_"
		echo5
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

    if [ $# -eq 1 ]; then
        if [[ ! "$1" =~ ^-- ]] && [[ ! "$1" =~ ^-.$ ]]; then
            remoteHostRawValue="$1"
            remoteHostNameOrIPAddressIsProvided=1
            shift
        fi
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
    echo

    if [ ! -z "$duplicatedArgumentEncountered" ]; then
        wlc-print-error    "Duplicated argument \"\e[33m${duplicatedArgumentEncountered}\e[31m\"."
        wlc_bash_tools--deploy_to_remote--print-help
        return 99
    fi


    local remoteHostNameOrIPAddress
    local remoteUserNameInRemoteHostRawValue

    wlc-validate-host-id-or-ip-address-with-optional-user-name    "$remoteHostRawValue"    remoteHostNameOrIPAddress    remoteUserNameInRemoteHostRawValue
    stageReturnCode=$?
	if [ $stageReturnCode -gt 0 ]; then
		wlc-print-error    "Invalid value \"\e[33m$remoteHostRawValue\e[31m\" for argument \"\e[32m--to-host=\e[31m\"."
        wlc_bash_tools--deploy_to_remote--print-help
		return 1
	fi


    # echo -e "\e[30;42mDEBUG\e[0m\n    remoteHostNameOrIPAddress=\"\e[33m${remoteHostNameOrIPAddress}\e[0m\"\n    remoteUserNameInRemoteHostRawValue=\"\e[33m${remoteUserNameInRemoteHostRawValue}\e[0m\""


    if [ $remoteUserNameIsProvededSeparately -gt 0 ] && [ ! -z "$remoteUserNameInRemoteHostRawValue" ] && [ "$remoteUserName" != "$remoteUserNameInRemoteHostRawValue" ]; then
        wlc-print-error    "Remote user name was provided both in \e[33m--to-host=\"${remoteHostRawValue}\"\e[31m and \e[33m--remote-user-name=\"${remoteUserName}\"\e[31m."
        wlc_bash_tools--deploy_to_remote--print-help
        return 2
    fi

    if [ ! -z "$remoteUserNameInRemoteHostRawValue" ]; then
        remoteUserName="$remoteUserNameInRemoteHostRawValue"
    fi

    if [ -z "$remoteUserName" ]; then
        remoteUserName='root'
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

    if [[ "$sourceFolderPath" =~ ^\ *~/ ]]; then
        sourceFolderPath="$HOME/${sourceFolderPath#*~/}"
    fi



    if [ "$sourceFolderPath" == "$HOME" ] || [ "$sourceFolderPath" == ~ ]; then
        echo
        wlc-print-error    "Cannot deploy \e[32m~\e[31m instance of \e[33m$WLC_BASH_TOOLS___FOLDER_NAME\e[31m to remote."
        return 30
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
        echo

        return 31
    fi






    echo3


    wlc-ssh-copy-id    "$remoteID"
    stageReturnCode=$?
    if [ $stageReturnCode -gt 0 ]; then
        return $stageReturnCode
    fi



    wlc_bash_tools--deploy_to_remote--core    --from-source-package-folder-path="$sourceFolderPath"   --to-host="$remoteID"
    stageReturnCode=$?
    if [ $stageReturnCode -gt 0 ]; then
        return $stageReturnCode
    fi



    echo3
    wlc-print-message-of-source    'function'    'wlc_bash_tools--deploy_to_remote'
    print-DONE
    echo3
}


function wlc--design_computer_name_for_remote_machine {
    local nameOfThisFunction='wlc--design_computer_name_for_remote_machine'
    local NAME_OF_FILE_FOR_CARRYING_COMPUTER_NAME='computer-name'


    function wlc--design_computer_name_for_remote_machine--print_help {
        local colorOfArgumentName='textGreen'
        local colorOfArgumentValue='textMagenta'
        local colorOfMarkers='textBlue'

        echo

        colorful -n 'Usage:'


        colorful -- "    $nameOfThisFunction"
        colorful -n ' \\'

        colorful -- "        --remote-id="                                   $colorOfArgumentName
        colorful -- "\"<remote host name or ip, user name is optional>\""    $colorOfArgumentValue
        colorful -n ' \\'

        colorful -- "        [ "                                  $colorOfMarkers
        colorful -- "--default-computer-name-prefix="             $colorOfArgumentName
        colorful -- "\"<a computer name of simply a prefix>\""    $colorOfArgumentValue
        colorful -- " ]"                                          $colorOfMarkers
        echo
        echo

        colorful -- "    $nameOfThisFunction"
        colorful -n ' \\'

        colorful -- "        "                                               $colorOfArgumentName
        colorful -- "\"<remote host name or ip, user name is optional>\""    $colorOfArgumentValue
        colorful -n ' \\'

        colorful -- "        [ "                                  $colorOfMarkers
        colorful -- "\"<a computer name of simply a prefix>\""    $colorOfArgumentValue
        colorful -- " ]"                                          $colorOfMarkers
        echo
        echo




        colorful -n 'Examples:'

        colorful -- "    $nameOfThisFunction"
        colorful -- "    --remote-id="    $colorOfArgumentName
        colorful -- "19.79.3.19"          $colorOfArgumentValue
        echo
        echo

        colorful -- "    $nameOfThisFunction"
        colorful -- "    19.79.3.19"          $colorOfArgumentValue
        echo
        echo

        colorful -- "    $nameOfThisFunction"
        colorful -- "    --remote-id="        $colorOfArgumentName
        colorful -- "wulechuan@19.79.3.19"    $colorOfArgumentValue
        echo
        echo

        colorful -- "    $nameOfThisFunction"
        colorful -- "    root@test-machine"    $colorOfArgumentValue
        colorful -- "    \"my-docker\""        $colorOfArgumentValue
        echo
        echo

        colorful -- "    $nameOfThisFunction"
        colorful -- "    root@test-machine"                  $colorOfArgumentValue
        colorful -- "    --default-computer-name-prefix="    $colorOfArgumentName
        colorful -- "\"my-docker\""                          $colorOfArgumentValue
        echo
        echo

        colorful -- "    $nameOfThisFunction"
        colorful -- "    --remote-id="     $colorOfArgumentName
        colorful -- "root@test-machine"    $colorOfArgumentValue
        colorful -- "    \"my-docker\""    $colorOfArgumentValue
        echo
        echo

        colorful -- "    $nameOfThisFunction"
        colorful -n ' \\'
        colorful -- "        --remote-id="    $colorOfArgumentName
        colorful -- "19.79.3.19"              $colorOfArgumentValue
        colorful -n ' \\'
        colorful -- "        --default-computer-name-prefix="    $colorOfArgumentName
        colorful -- "\"my-docker\""                              $colorOfArgumentValue
        echo
        echo
    }

    echo

    if [ $# -eq 0 ]; then
        wlc--design_computer_name_for_remote_machine--print_help
        return 0
    fi

    if [ $# -gt 2 ]; then
        wlc-print-message-of-source    'function'    "$nameOfThisFunction"
        wlc-print-error    -1    "Two many arguments provided."

        echo
        colorful -n "$VE_line_60"
        wlc--design_computer_name_for_remote_machine--print_help
        return 3
    fi



    if [ -z "$1" ]; then
        wlc-print-message-of-source    'function'    "$nameOfThisFunction"
        wlc-print-error    -1    "\e[33m\$1\e[31m is required."

        echo
        colorful -n "$VE_line_60"
        wlc--design_computer_name_for_remote_machine--print_help
        return 3
    fi



    local remoteIDRawValue="$1"
    if [[ "$remoteIDRawValue" =~ ^--remote-id= ]]; then
        remoteIDRawValue="${remoteIDRawValue:12}" # --remote-id="..."
    fi


    local remoteComputerNameDefaultPrefix="$2"
    if [[ "$remoteComputerNameDefaultPrefix" =~ ^--default-computer-name-prefix= ]]; then
        remoteComputerNameDefaultPrefix="${remoteComputerNameDefaultPrefix:31}" # --default-computer-name-prefix="..."
    fi


    local remoteHostNameOrIPAddress
    local remoteUserName


    wlc-validate-host-id-or-ip-address-with-optional-user-name    "$remoteIDRawValue"    remoteHostNameOrIPAddress    remoteUserName
    stageReturnCode=$?
	if [ $stageReturnCode -gt 0 ]; then
		wlc-print-error    "Invalid value \"\e[33m$remoteIDRawValue\e[31m\" for argument \"\e[32m\$1\e[31m\"."
        wlc_bash_tools--deploy_to_remote--print-help
		return 1
	fi


    if [ -z "$remoteUserName" ]; then
        remoteUserName='root'
        colorful -- 'Remote user name'    textBrightCyan
        colorful -- ' was not provided. Thus "'    textGreen
        colorful -- 'root'    textMagenta
        colorful -n '" is assumed.'    textGreen
        echo
    fi

    local remoteID="${remoteUserName}@${remoteHostNameOrIPAddress}"




    local decidedRemoteComputerName
    wlc--design_computer_name_for_remote_machine--core \
        --remote-host-name-or-ip-address="$remoteHostNameOrIPAddress" \
        --default-computer-name-prefix="$remoteComputerNameDefaultPrefix" \
        decidedRemoteComputerName


    local pathOfLocalWorkingTempFolder="$WLC_BASH_TOOLS___FOLDER_PATH___OF_CACHE/design-computer-name-for-${remoteID}"
    mkdir    -p    "$pathOfLocalWorkingTempFolder"

    local pathOfLocalFileForCarryingComputerNameOfRemoteMachine="$pathOfLocalWorkingTempFolder/$NAME_OF_FILE_FOR_CARRYING_COMPUTER_NAME"
    local subPathOfRemoteFolderToPutTheFileForCarryingComputerName="$WLC_BASH_TOOLS___FOLDER_NAME/$WLC_BASH_TOOLS___FOLDER_NAME___OF_ASSETS"

    echo "$decidedRemoteComputerName" > "$pathOfLocalFileForCarryingComputerNameOfRemoteMachine"


    echo3
    colorful -n 'Now trying to send the file of computer name to remote...'    textGreen
    ssh    "$remoteID"    "mkdir    -p    ~/'${subPathOfRemoteFolderToPutTheFileForCarryingComputerName}'"

    scp    -q    "$pathOfLocalFileForCarryingComputerNameOfRemoteMachine"    "$remoteID:~/'${subPathOfRemoteFolderToPutTheFileForCarryingComputerName}'"




    echo

    rm    -rf    "$pathOfLocalWorkingTempFolder"

    if [ $? -eq 0 ]; then

        colorful -n 'Temp folder:'                     textRed
        colorful -- '    "'                            textRed
        colorful -n "$pathOfLocalWorkingTempFolder"    textYellow
        colorful -n '" has been deleted.'              textRed

    else

        wlc-print-error    "Failed to delete temp folder:"

        colorful -- '    "'                            textRed
        colorful -n "$pathOfLocalWorkingTempFolder"    textYellow
        colorful -n '"'                                textRed

    fi
}

function wlc--design_computer_name_for_remote_machine--core {
    # $1: -remote-host-name-or-ip-address="..."
    # $2: --default-computer-name-prefix="..."
    # $3: <output> the decided computer name.

    local REMOTE_COMPUTER_NAME_DEFAULT_PREFIX='computer'



    if [ $# -ne 3 ]; then
        wlc-print-message-of-source    'function'    "wlc--design_computer_name_for_remote_machine--core"
        wlc-print-error    -1    "Must provide 3 arguments, and 3rd of which must be a variable reference."
        return 3
    fi






    local ___remote_raw_name___="${1:33}"                     # --remote-host-name-or-ip-address="..."
    local ___remote_computer_name_default_prefix___="${2:31}" # --default-computer-name-prefix="..."

    # echo -e "\e[30;42mDEBUG\e[0m"
    # echo  -e "   ___remote_raw_name___=\"\e[33m$___remote_raw_name___\e[0m\""
    # echo  -e "   ___remote_computer_name_default_prefix___=\"\e[33m$___remote_computer_name_default_prefix___\e[0m\""

    echo3
    wlc-print-header "Design the computer name for the remote machine:"

    local ___remoteComputerNamePrefix___
    local ___remoteComputerName___

    if [[ "$___remote_raw_name___" =~ [0-9\.]+ ]]; then
        local ___safeStringOfIPAddressToUseInComputerName___=$___remote_raw_name___
        ___safeStringOfIPAddressToUseInComputerName___=${___safeStringOfIPAddressToUseInComputerName___//./-}
        ___safeStringOfIPAddressToUseInComputerName___="-ip-${___safeStringOfIPAddressToUseInComputerName___}"

        if [ ! -z "$___remote_computer_name_default_prefix___" ]; then
            ___remoteComputerNamePrefix___="$___remote_computer_name_default_prefix___"
        else
            ___remoteComputerNamePrefix___="$REMOTE_COMPUTER_NAME_DEFAULT_PREFIX"
        fi

        ___remoteComputerName___="${___remoteComputerNamePrefix___}${___safeStringOfIPAddressToUseInComputerName___}"

    else
        ___remoteComputerName___="$___remote_raw_name___"
    fi



    colorful -- 'I suggest you to input a descriptive '                   textGreen
    colorful -- 'computer name'                                           textMagenta
    colorful -n ' for the remote machine, simply for easy recognition.'   textGreen

    colorful -n 'You may skip this by press the <ENTER> key directly.'

    colorful -- '(30 seconds for decision, default is "'
    colorful -- "$___remoteComputerName___"   textGreen
    colorful -n '")'

    colorful -- "The remote computer name: "

    local            userInputComputerNameForRemoteMachine
    read    -t 30    userInputComputerNameForRemoteMachine
    stageReturnCode=$?
    if [ $stageReturnCode -gt 0 ]; then
        echo
    fi

    if [ -z "$userInputComputerNameForRemoteMachine" ]; then
        echo '<Skipped>'
    else
        ___remoteComputerName___="$userInputComputerNameForRemoteMachine"
    fi


    echo
    colorful -n "$VE_line_70"                  textGreen
    colorful -- 'Computer name of "'           textGreen
    colorful -- "$___remote_raw_name___"       textBrightCyan
    colorful -- '" decided to be "'            textGreen
    colorful -- "$___remoteComputerName___"    textMagenta
    colorful -n '"'                            textGreen
    colorful -n "$VE_line_70"                  textGreen
    echo



    eval "$3=$___remoteComputerName___"
}
