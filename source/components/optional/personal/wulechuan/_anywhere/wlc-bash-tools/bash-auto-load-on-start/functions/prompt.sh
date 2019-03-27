export GIT_PS1_SHOWDIRTYSTATE=true
export GIT_PS1_SHOWUNTRACKEDFILES=true
export GIT_PS1_SHOWUPSTREAM="auto"
export GIT_PS1_HIDE_IF_PWD_IGNORED=true


WLC_RAINBOW_PROMPT___256_COLORED___PALETTE_COLOR_1=210
WLC_RAINBOW_PROMPT___256_COLORED___PALETTE_COLOR_2=216
WLC_RAINBOW_PROMPT___256_COLORED___PALETTE_COLOR_3=229
WLC_RAINBOW_PROMPT___256_COLORED___PALETTE_COLOR_4=120
WLC_RAINBOW_PROMPT___256_COLORED___PALETTE_COLOR_5=49
WLC_RAINBOW_PROMPT___256_COLORED___PALETTE_COLOR_6=87
WLC_RAINBOW_PROMPT___256_COLORED___PALETTE_COLOR_7=45
WLC_RAINBOW_PROMPT___256_COLORED___PALETTE_COLOR_8=39
WLC_RAINBOW_PROMPT___256_COLORED___PALETTE_COLOR_9=69
WLC_RAINBOW_PROMPT___256_COLORED___PALETTE_COLOR_10=63
WLC_RAINBOW_PROMPT___256_COLORED___GIT_INFO_COLOR_1=219 # for prompt whose colors are in backgrounds
WLC_RAINBOW_PROMPT___256_COLORED___GIT_INFO_COLOR_2=223 # for prompt whose colors are in texts
WLC_RAINBOW_PROMPT___256_COLORED___GIT_INFO_COLOR_OF_BRACKETS=246

function wlc_rainbow_prompt--setup {
	function build_rainbow_prompt_with_git_branch_info--in_256_colored_mode--and_set_colors_to_background {
		PS1=$clearColor'\n'                                                                    # New line


		PS1=$PS1'\[\033[38;5;16;48;5;'${WLC_RAINBOW_PROMPT___256_COLORED___PALETTE_COLOR_1}'m\]'$(date +"%m-%d")       # Month & Day
		PS1=$PS1'\[\033[38;5;16;48;5;'${WLC_RAINBOW_PROMPT___256_COLORED___PALETTE_COLOR_2}'m\]'' '                    # A <Space>
		PS1=$PS1'\[\033[38;5;16;48;5;'${WLC_RAINBOW_PROMPT___256_COLORED___PALETTE_COLOR_3}'m\]'$(date +"%H:%M:%S")    # Hour & Minute
		PS1=$PS1'\[\033[38;5;16;48;5;'${WLC_RAINBOW_PROMPT___256_COLORED___PALETTE_COLOR_4}'m\]'' '                    # A <space>

		PS1=$PS1'\[\033[38;5;16;48;5;'${WLC_RAINBOW_PROMPT___256_COLORED___PALETTE_COLOR_5}'m\]'$(getCurrentUserName)  # user
		PS1=$PS1'\[\033[38;5;16;48;5;'${WLC_RAINBOW_PROMPT___256_COLORED___PALETTE_COLOR_6}'m\]''@'                    # @
		PS1=$PS1'\[\033[38;5;16;48;5;'${WLC_RAINBOW_PROMPT___256_COLORED___PALETTE_COLOR_7}'m\]''\h'                   # host
		PS1=$PS1'\[\033[38;5;16;48;5;'${WLC_RAINBOW_PROMPT___256_COLORED___PALETTE_COLOR_8}'m\]'':'                    # :
		PS1=$PS1'\[\033[38;5;16;48;5;'${WLC_RAINBOW_PROMPT___256_COLORED___PALETTE_COLOR_9}'m\]''\w'                   # current working directory
		PS1=$PS1'\[\033[38;5;16;48;5;'${WLC_RAINBOW_PROMPT___256_COLORED___PALETTE_COLOR_10}'m\]'' '                   # A <space>


		local gitBranchInfo=`__git_ps1`
		if [ $WLC_RAINBOW_PROMPT___SHOULD_USE_DETAILED_BUT_SLOW_GIT_BRANCH_INFO_QUERY == 'yes' ]; then
			gitBranchInfo=${gitBranchInfo:2:-1}
		fi

		if [ ! -z "$gitBranchInfo" ]; then
			PS1=$PS1$clearColor'\n'
			PS1=$PS1'\[\033[38;5;'${WLC_RAINBOW_PROMPT___256_COLORED___GIT_INFO_COLOR_OF_BRACKETS}'m\]''['
			PS1=$PS1'\[\033[38;5;'${WLC_RAINBOW_PROMPT___256_COLORED___GIT_INFO_COLOR_1}'m\]'$gitBranchInfo
			PS1=$PS1'\[\033[38;5;'${WLC_RAINBOW_PROMPT___256_COLORED___GIT_INFO_COLOR_OF_BRACKETS}'m\]'']'
		fi


		PS1=$PS1$clearColor'\n'   # New line
		PS1=$PS1'$ '              # last prompt sign: $<space>
	}

	function build_rainbow_prompt_with_git_branch_info--in_256_colored_mode--and_set_colors_to_text {
		PS1=$clearColor'\n'                                                            # New line

		PS1=$PS1'\[\033[38;5;'${WLC_RAINBOW_PROMPT___256_COLORED___PALETTE_COLOR_1}'m\]'$(date +"%m-%d")        # Month & Day
		PS1=$PS1'\[\033[38;5;'${WLC_RAINBOW_PROMPT___256_COLORED___PALETTE_COLOR_2}'m\]'' '                     # A <Space>
		PS1=$PS1'\[\033[38;5;'${WLC_RAINBOW_PROMPT___256_COLORED___PALETTE_COLOR_3}'m\]'$(date +"%H:%M:%S")     # Hour & Minute
		PS1=$PS1'\[\033[38;5;'${WLC_RAINBOW_PROMPT___256_COLORED___PALETTE_COLOR_4}'m\]'' '                     # A <space>

		PS1=$PS1'\[\033[38;5;'${WLC_RAINBOW_PROMPT___256_COLORED___PALETTE_COLOR_5}'m\]'$(getCurrentUserName)   # user
		PS1=$PS1'\[\033[38;5;'${WLC_RAINBOW_PROMPT___256_COLORED___PALETTE_COLOR_6}'m\]''@'                     # @
		PS1=$PS1'\[\033[38;5;'${WLC_RAINBOW_PROMPT___256_COLORED___PALETTE_COLOR_7}'m\]''\h'                    # host
		PS1=$PS1'\[\033[38;5;'${WLC_RAINBOW_PROMPT___256_COLORED___PALETTE_COLOR_8}'m\]'':'                     # :
		PS1=$PS1'\[\033[38;5;'${WLC_RAINBOW_PROMPT___256_COLORED___PALETTE_COLOR_9}'m\]''\w'                    # current working directory
		PS1=$PS1'\[\033[38;5;'${WLC_RAINBOW_PROMPT___256_COLORED___PALETTE_COLOR_10}'m\]'' '                    # A <space>


		local gitBranchInfo=`__git_ps1`
		if [ $WLC_RAINBOW_PROMPT___SHOULD_USE_DETAILED_BUT_SLOW_GIT_BRANCH_INFO_QUERY == 'yes' ]; then
			gitBranchInfo=${gitBranchInfo:2:-1}
		fi

		if [ ! -z "$gitBranchInfo" ]; then
			PS1=$PS1$clearColor'\n'
			PS1=$PS1'\[\033[38;5;'${WLC_RAINBOW_PROMPT___256_COLORED___GIT_INFO_COLOR_OF_BRACKETS}'m\]''['
			PS1=$PS1'\[\033[38;5;'${WLC_RAINBOW_PROMPT___256_COLORED___GIT_INFO_COLOR_2}'m\]'$gitBranchInfo
			PS1=$PS1'\[\033[38;5;'${WLC_RAINBOW_PROMPT___256_COLORED___GIT_INFO_COLOR_OF_BRACKETS}'m\]'']'
		fi


		PS1=$PS1$clearColor'\n'   # New line
		PS1=$PS1'$ '              # last prompt sign: $<space>
	}

	function build_rainbow_prompt_with_git_branch_info--in_16_colored_mode--and_set_colors_to_background {
		PS1=$clearColor'\n'                                                                    # New line


		local dateString=$(date +"%m-%d")
		local clockString=$(date +"%H:%M:%S")
		local userName=`getCurrentUserName`
		local computerName=`hostname`
		local currentFolder='\w'

		PS1="$PS1"$(
			colorful "$dateString "      textBlack    bgndRed
			colorful "$clockString "     textBlack    bgndRed
			colorful "$userName"         textBlack    bgndYellow
			colorful '@'                 textBlack    bgndGreen
			colorful "$computerName"     textBlack    bgndCyan
			colorful ':'                 textBlack    bgndBlue
			colorful "$currentFolder"    textBlack    bgndMagenta
		)

		local gitBranchInfo=`__git_ps1`
		if [ $WLC_RAINBOW_PROMPT___SHOULD_USE_DETAILED_BUT_SLOW_GIT_BRANCH_INFO_QUERY == 'yes' ]; then
			gitBranchInfo=${gitBranchInfo:2:-1}
		fi

		if [ ! -z "$gitBranchInfo" ]; then
			PS1="$PS1\n"$(
				colorful '['                 textBlack
				colorful "$gitBranchInfo"    textGreen
				colorful ']'                 textBlack
			)
		fi

		PS1="$PS1\n\$ "
	}

	function build_rainbow_prompt_with_git_branch_info--in_16_colored_mode--and_set_colors_to_text {
		PS1=$clearColor'\n'                                                                    # New line


		local dateString=$(date +"%m-%d")
		local clockString=$(date +"%H:%M:%S")
		local userName=`getCurrentUserName`
		local computerName=`hostname`
		local currentFolder='\w'

		PS1="$PS1"$(
			colorful "$dateString "      textRed
			colorful "$clockString "     textRed
			colorful "$userName"         textYellow
			colorful '@'                 textGreen
			colorful "$computerName"     textCyan
			colorful ':'                 textBlue
			colorful "$currentFolder"    textMagenta
		)

		local gitBranchInfo=`__git_ps1`
		if [ $WLC_RAINBOW_PROMPT___SHOULD_USE_DETAILED_BUT_SLOW_GIT_BRANCH_INFO_QUERY == 'yes' ]; then
			gitBranchInfo=${gitBranchInfo:2:-1}
		fi

		if [ ! -z "$gitBranchInfo" ]; then
			PS1="$PS1\n"$(
				colorful '['                 textBlack
				colorful "$gitBranchInfo"    textGreen
				colorful ']'                 textBlack
			)
		fi

		PS1="$PS1\n\$ "
	}





	local tempShouldTryLoadGNU__git_ps1=1

	if [ -z "$WLC_RAINBOW_PROMPT___SHOULD_USE_DETAILED_BUT_SLOW_GIT_BRANCH_INFO_QUERY" ]; then
		WLC_RAINBOW_PROMPT___SHOULD_USE_DETAILED_BUT_SLOW_GIT_BRANCH_INFO_QUERY="no"
	fi


	if [ $WLC_RAINBOW_PROMPT___SHOULD_USE_DETAILED_BUT_SLOW_GIT_BRANCH_INFO_QUERY != 'yes' ]; then
		tempShouldTryLoadGNU__git_ps1=0
	fi


	local gitPromptFilePath="$WLC_BASH_TOOLS___FOLDER_PATH/bash-from-3rd-parties/git-prompt/git-prompt.sh"

	if [ $tempShouldTryLoadGNU__git_ps1 -eq 1 ] && [ -f "$gitPromptFilePath" ]; then
		source    "$gitPromptFilePath";
	fi

	local foundThe__git_ps1_function=`declare -f __git_ps1 > /dev/null; echo $?`

	if [ $foundThe__git_ps1_function -ne 0 ]; then
		function __git_ps1 { # This is a simplified version of __git_ps1 if we have no GNU source code.
			git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/\1/'
		}
	else
		if [[ "$-" =~ i ]]; then
			echo "Use Detailed __git_ps1, which is licensed under GNU GPL 2.0"
		fi
	fi





	local shouldUse16ColorsPrompt=0





	if [ $envIsLinux = 1 ] || [ $envIsCygwin = 1 ] || [ $envIsGitBash = 1 ]; then
		shouldUse16ColorsPrompt=0
	else
		local tputColorsCount=`tput colors`
		if [ $tputColorsCount = 8 ]; then
			shouldUse16ColorsPrompt=1
		fi
	fi

	if [ $envIsVSCode = 1 ]; then
		shouldUse16ColorsPrompt=1
	fi





	if [ $shouldUse16ColorsPrompt -eq 1 ]; then
		if [ "$WLC_RAINBOW_PROMPT___COLORS_ARE_IN_BACKGROUND_INSTEAD_OF_TEXTS" == 'yes' ]; then
			export PROMPT_COMMAND='build_rainbow_prompt_with_git_branch_info--in_16_colored_mode--and_set_colors_to_background';
		else
			export PROMPT_COMMAND='build_rainbow_prompt_with_git_branch_info--in_16_colored_mode--and_set_colors_to_text';
		fi
	else
		if [ "$WLC_RAINBOW_PROMPT___COLORS_ARE_IN_BACKGROUND_INSTEAD_OF_TEXTS" == 'yes' ]; then
			export PROMPT_COMMAND='build_rainbow_prompt_with_git_branch_info--in_256_colored_mode--and_set_colors_to_background'
		else
			export PROMPT_COMMAND='build_rainbow_prompt_with_git_branch_info--in_256_colored_mode--and_set_colors_to_text'
		fi
	fi
}
