WLC_BASH_TOOLS___FOLDER_NAME="wlc-bash-tools"
WLC_BASH_TOOLS___FOLDER_PATH="$HOME/$WLC_BASH_TOOLS___FOLDER_NAME"






if [ -d "$WLC_BASH_TOOLS___FOLDER_PATH" ]; then

    if [ -f "$WLC_BASH_TOOLS___FOLDER_PATH/start.sh" ]; then


        # ************************************************* #
        # ************************************************* #
        # ************************************************* #
        source    "$WLC_BASH_TOOLS___FOLDER_PATH/start.sh"
        # ************************************************* #
        # ************************************************* #
        # ************************************************* #


    elif [[ $- =~ i ]]; then
        echo
        echo -e "\e[30;41mERROR:\e[0;31m File \"\e[33m${WLC_BASH_TOOLS___FOLDER_PATH}/start.sh\e[31m\" not found."
        echo -e "\e[31m       WLC Bash tools failed to boot [1].\e[0m"
        echo -e "       \e[35m.bashrc\e[0m"
        echo
    fi

elif [[ $- =~ i ]]; then
    echo
    echo -e "\e[30;41mERROR:\e[0;31m Folder \"\e[33m${WLC_BASH_TOOLS___FOLDER_PATH}\e[31m\" not found."
    echo -e "\e[31m       WLC Bash tools failed to boot [0].\e[0m"
    echo -e "       \e[35m.bashrc\e[0m"
    echo
fi
