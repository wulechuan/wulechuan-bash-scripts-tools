___home=$(cd && pwd)
___RegExp_cygdrive='^/cygdrive/'
___RegExp_windows_subsystem_linux='^/home/'

envIsCygwin=0
envIsGitBash=0
envIsWSL=0

if [[ $___home =~ $___RegExp_cygdrive ]]; then
    function WinDrive {
        echo "/cygdrive/$1"
    }
    envIsCygwin=1

    alias start="cygstart"
elif [[ $___home =~ $___RegExp_windows_subsystem_linux ]]; then
    function WinDrive {
        echo "/mnt/$1"
    }
    envIsWSL=1
else
    # if [ -f /c/Windows/explorer.exe ]; then
    #     envIsGitBash=1
    # fi

    function WinDrive {
        echo "/$1"
    }
fi

unset ___home
unset ___RegExp_cygdrive
unset ___RegExp_windows_subsystem_linux