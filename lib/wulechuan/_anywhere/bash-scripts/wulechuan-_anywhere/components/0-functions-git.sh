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

    local codeOnLinux=/usr/bin/code
    local codeOnWindows="c:/Program Files/Microsoft VS Code/Code.exe"

    if [ -f $codeOnLinux ]; then

        git config --global core.editor $codeOnLinux
        succeeded=1

    elif [ -f "$codeOnWindows" ]; then

        git config --global core.editor "\"$codeOnWindows\""
        succeeded=1
    
    fi

    if [ $succeeded -eq 1 ]; then
        echo 'GIT: editor set to Microsoft Visual Studio Code'
    else
        echo -e "GIT:\e[31m Failed to set editor to Microsoft Visual Studio Code\e[0;0m"
    fi
}