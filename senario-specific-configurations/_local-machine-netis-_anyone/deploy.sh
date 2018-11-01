function __deploy_org_local_machine_anyone_to_special_git_repo__ {
	# senarioName 由外层函数调用该函数时隐含给出。
	# echo senarioName=$senarioName

	local gitRepoName='my-special-project'

	local gitRepoPath=`WinDrive d`"/projects/unnamed-org/$gitRepoName"
	local senarioDistPath="$___here/$___wlcBashScriptsBuildingOutputFolderName/_local-machine-wulechuan/$wlcLocalMachineFolderNameOfBashScriptsForDockers/$senarioName"

	echo
	echo

	if [ ! -z "$senarioName" ] && [ -d "$senarioDistPath" ] && [ -d "$gitRepoPath" ]; then


		rm   -rf  "$gitRepoPath/$senarioName"
		cp   -r   "$senarioDistPath"   "$gitRepoPath"



		colorful -n "$VE_line_60"            textCyan

		colorful -n 'Successfully deployed'  textCyan

		colorful -n "$VE_line_60"            textCyan

		echo     -n '    '
		colorful -- 'Senario:'
		colorful -n " $senarioName"          textYellow

		colorful -- 'To git repo:'
		colorful -n " $gitRepoName"          textGreen

		colorful -n "$VE_line_60"            textCyan


	else


		colorful -n "$VE_line_60"        textRed

		colorful -n 'Failed to deploy'   textRed

		colorful -n "$VE_line_60"        textRed

		echo     -n '    '
		colorful -- 'Senario:'
		colorful -n " $senarioName"      textYellow

		colorful -- 'To git repo:'
		colorful -n " $gitRepoName"      textGreen

		colorful -n "$VE_line_60"        textRed


	fi

	echo
	echo

	unset -f __deploy_org_local_machine_anyone_to_special_git_repo__
}

__deploy_org_local_machine_anyone_to_special_git_repo__