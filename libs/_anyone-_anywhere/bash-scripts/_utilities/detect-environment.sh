# 下方代码必须提前运行，因此不应置于 init.sh 中

function getCurrentUserName {
    local currentUserName=$USERNAME

    if [ -z "$USERNAME" ]; then
        currentUserName=`whoami`
    fi

    echo $currentUserName
}

function showEnv {
    function showOneEnv {
        local envName=$1
        local envValue=${!envName}
        local _color

        if [ $envValue = 1 ]; then
            _color='\e[32m'
        else
            _color='\e[0;0m'
        fi

        echo -e "$_color$envName=$envValue"
    }

    echo

    showOneEnv envIsWSL
    showOneEnv envIsLinux
    showOneEnv envIsCygwin
    showOneEnv envIsGitBash
    showOneEnv envIsVSCode
}

function detectEnv {
    envIsWSL=0
    envIsLinux=0
    envIsCygwin=0
    envIsGitBash=0
    envIsVSCode=0


    local shouldNotShowResult=$1
    [ ${shouldNotShowResult:=0} ]

    if [[ `uname -a` =~ Linux.*Microsoft ]]; then
        envIsWSL=1
    elif [ `uname` = Linux ]; then
        envIsLinux=1
    elif [[ `uname` =~ CYGWIN_NT ]]; then
        envIsCygwin=1
    elif [[ `uname` =~ MINGW64_NT ]]; then
        envIsGitBash=1
    fi

    local termProgram=echo $TERM_PROGRAM

    if [ ! -z "$termProgram" ]; then
        if [ $termProgram = vscode ]; then
            envIsVSCode=1
        fi
    fi

    if [ $shouldNotShowResult = 0 ]; then
        showEnv
    fi
}



detectEnv 1

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