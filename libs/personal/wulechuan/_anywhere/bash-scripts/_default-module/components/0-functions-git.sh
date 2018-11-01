function git-setup-user-account {
    git config --global user.name "$gitDefaultUserName"
    git config --global user.email "$gitDefaultUserEmail"
}

function git-add-aliases-to-config {
    git config --global alias.co checkout
    git config --global alias.nbr "checkout -b"
    git config --global alias.br branch
    git config --global alias.cm "commit -m"
    git config --global alias.recent "log -5"
    git config --global alias.pl pull
    git config --global alias.ps push
    git config --global alias.fc fetch
    git config --global alias.st status

    echo 'GIT: aliases added'
}

function git-enable-colors {
    git config --global color.ui true

    echo 'GIT: colors enabled'
}

function git-try-to-set-editor-as-ms-vscode {
    local succeeded=0

    local VSCodeOnLinux=/usr/bin/code
    local oldVSCodeOnWindows="c:/Program Files/Microsoft VS Code/Code.exe"

    local userNameOnWindows="$USERNAME"  # Wrong in <Cygwin>; Empty in <Linux>
    if [ -z "$userNameOnWindows" ]; then
        userNameOnWindows="$USER" # empty in <Git Bash>
    fi

    local newVSCodeOnWindows="c:/Users/$userNameOnWindows/AppData/Local/Programs/Microsoft VS Code/Code.exe"

    if [ -f $VSCodeOnLinux ]; then

        git config --global core.editor $VSCodeOnLinux
        succeeded=1

    elif [ -f "$oldVSCodeOnWindows" ]; then

        git config --global core.editor "\"$oldVSCodeOnWindows\""
        succeeded=1

    elif [ -f "$newVSCodeOnWindows" ]; then

        git config --global core.editor "\"$newVSCodeOnWindows\""
        succeeded=1

    fi

    if [ $succeeded -eq 1 ]; then
        echo 'GIT: editor set to Microsoft Visual Studio Code'
    else
        echo -e "GIT:\e[31m Failed to set editor to Microsoft Visual Studio Code\e[0;0m"
    fi
}