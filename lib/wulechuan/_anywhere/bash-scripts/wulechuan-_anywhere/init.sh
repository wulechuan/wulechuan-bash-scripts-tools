if [ "$windowsCurrentUserName" = "wulechuan" ]; then
    copywritingLanguage="en_US"
fi

if [ "$windowsCurrentUserName" = "lechuan.wu" ]; then
    copywritingLanguage="en_US"
fi

___shouldUse16ColorsPrompt=0
___tputColors=`tput colors`
if [ $___tputColors -eq 8 ]; then
    ___shouldUse16ColorsPrompt=1

    if [ $envIsCygwin -eq 1 ]; then
        ___shouldUse16ColorsPrompt=0
    fi
fi
unset ___tputColors

if [ $___shouldUse16ColorsPrompt -eq 1 ]; then
    export PROMPT_COMMAND='_customize_prompt_with_git_branch_info_in_16_colors_';
else
    export PROMPT_COMMAND='_customize_prompt_with_git_branch_info_in_256_colors_'
fi
