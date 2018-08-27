clearColor='\e[0;0m'

function colorful {
    # Usage: colorful -- wulechuan textBlack bgndCyan

    local colorSetting
    local clearColorMark
    local endChar


    if [ "$1" = '-n' ]; then
        endChar='\n'
    else
        endChar=''
    fi

    
    local color1=
    local color2=

    if [ ! -z "$3" ]; then
        map-color-name-into-ansi-code   $3   color1
    fi

    if [ ! -z "$4" ]; then
        map-color-name-into-ansi-code   $4   color2
    fi

    if [ -z "$color1" ] && [ -z "$color2" ]; then
        colorSetting=''
    elif [ ! -z "$color1" ] && [ ! -z "$color2" ]; then
        colorSetting='\e['${color1}';'${color2}'m'
    else
        colorSetting='\e['${color1}'m'
    fi


    if [ -z "$colorSetting" ]; then
        clearColorMark=''          # 故意不做【清除颜色】的动作
    else
        clearColorMark=$clearColor # 应该清除颜色
    fi


    echo -en ${colorSetting}$2${clearColorMark}${endChar}
}

function set-color {
    local color1=
    local color2=

    if [ ! -z "$1" ]; then
        map-color-name-into-ansi-code   $1   color1
    fi

    if [ ! -z "$2" ]; then
        map-color-name-into-ansi-code   $2   color2
    fi

    if [ -z "$color1" ] && [ -z "$color2" ]; then
        return 0
    elif [ ! -z "$color1" ] && [ ! -z "$color2" ]; then
        colorSetting='\e['${color1}';'${color2}'m'
    else
        colorSetting='\e['${color1}'m'
    fi

    echo -e $colorSetting
}

function clear-color {
    echo -e $clearColor
}


function append-string {
    # https://stackoverflow.com/questions/3236871/how-to-return-a-string-value-from-a-bash-function

    # --- Usage ---
    # myVar='hello '

    # append-string wulechuan to myVar
    # Notice that the 3rd argument has **no** $ sign prefixed.
    # Also notice the 2nd argument, which is 'to' here,
    # Tt's just a dummy argument.
    # Basically you can use any word here.

    # echo $myVar

	local old=${!3}
	eval "$3=\"$old\"\"$1\""
}

function get-color {
    # --- Usage ---
    # color1=textRed
    # color2=bgndWhite
    # colorEscapeString=
    #
    # Below 2 are identical:
    # Notice that the last argument has **no** $ sign prefixed.
    #
    # echo $colorEscapeString

    local color1=
    local color2=

    if [ -z "$1" ]; then
        return
    fi


    map-color-name-into-ansi-code       $1   color1


    if [ -z "$3" ]; then
        eval "$2='\\'\"e[${color1}m\""
    else
        map-color-name-into-ansi-code   $2   color2
        eval "$3='\\'\"e[${color1};${color2}m\""
    fi
}

function set-echo-color {
    # set-echo-color  $color1  $color2  colorEscapeString
    # set-echo-color  $color2  $color1  colorEscapeString


    local colorEscapeString=
    get-color   $1   $2   colorEscapeString

    echo -en $colorEscapeString
}

function clear-echo-color {
    echo -en "\e[0;0m"
}

function append-colorful-string-to {
    local colorEscapeString=
    get-color   $4   $5   colorEscapeString

    local endChar=''
    if [ "$2" = '-n' ]; then
        endChar='\n'
    fi

    local colorStringToAppend=
    colorStringToAppend=$colorEscapeString$3'\e[0;0m'$endChar

    append-string "$colorStringToAppend" to "$1"
}


function colorful2 {
    # Usage: colorful2 wulechuan textBlack bgndCyan

    if [ -z "$1" ]; then
        return
    fi

    local colorEscapeString=

    get-color   $2   $3   colorEscapeString

    if [ ! -z "$colorEscapeString" ]; then
        echo -e "$colorEscapeString$1\e[0;0m"
    else
        echo -e $1
    fi
}

function map-color-name-into-ansi-code {
    if [ -z "$1" ];                     then
        eval $2=''



    # classical foreground colors

    elif [ $1 == 'textBlack' ];         then
        eval $2=30

    elif [ $1 == 'textRed' ];           then
        eval $2=31

    elif [ $1 == 'textGreen' ];         then
        eval $2=32

    elif [ $1 == 'textYellow' ];        then
        eval $2=33

    elif [ $1 == 'textBlue' ];          then
        eval $2=34

    elif [ $1 == 'textMagenta' ];       then
        eval $2=35

    elif [ $1 == 'textCyan' ];          then
        eval $2=36

    elif [ $1 == 'textWhite' ];         then
        eval $2=37



    # classical background colors

    elif [ $1 == 'bgndBlack' ];         then
        eval $2=40

    elif [ $1 == 'bgndRed' ];           then
        eval $2=41

    elif [ $1 == 'bgndGreen' ];         then
        eval $2=42

    elif [ $1 == 'bgndYellow' ];        then
        eval $2=43

    elif [ $1 == 'bgndBlue' ];          then
        eval $2=44

    elif [ $1 == 'bgndMagenta' ];       then
        eval $2=45

    elif [ $1 == 'bgndCyan' ];          then
        eval $2=46

    elif [ $1 == 'bgndWhite' ];         then
        eval $2=47



    # morden foreground colors

    elif [ $1 == 'textBrightBlack' ];   then
        eval $2=90

    elif [ $1 == 'textBrightRed' ];     then
        eval $2=91

    elif [ $1 == 'textBrightGreen' ];   then
        eval $2=92

    elif [ $1 == 'textBrightYellow' ];  then
        eval $2=99

    elif [ $1 == 'textBrightBlue' ];    then
        eval $2=94

    elif [ $1 == 'textBrightMagenta' ]; then
        eval $2=95

    elif [ $1 == 'textBrightCyan' ];    then
        eval $2=96

    elif [ $1 == 'textBrightWhite' ];   then
        eval $2=97



    # morden background colors

    elif [ $1 == 'bgndBrightBlack' ];   then
        eval $2=100

    elif [ $1 == 'bgndBrightRed' ];     then
        eval $2=101

    elif [ $1 == 'bgndBrightGreen' ];   then
        eval $2=102

    elif [ $1 == 'bgndBrightYellow' ];  then
        eval $2=103

    elif [ $1 == 'bgndBrightBlue' ];    then
        eval $2=104

    elif [ $1 == 'bgndBrightMagenta' ]; then
        eval $2=105

    elif [ $1 == 'bgndBrightCyan' ];    then
        eval $2=106

    elif [ $1 == 'bgndBrightWhite' ];   then
        eval $2=107


    else
        eval $2=''


    fi
}