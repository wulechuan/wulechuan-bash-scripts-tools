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
}

function detectEnv {
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

    if [ $shouldNotShowResult = 0 ]; then
        showEnv
    fi
}
