if [ $envIsWSL = 1 ]; then

    function WinDrive {
        echo "/mnt/$1"
    }

elif [ $envIsCygwin = 1 ]; then

    function WinDrive {
        echo "/cygdrive/$1"
    }

    # ***********************************
    alias start="cygstart"
    # ***********************************

elif [ $envIsGitBash = 1 ]; then

    function WinDrive {
        echo "/$1"
    }

else

    function WinDrive {
        echo "/$1"
    }

fi