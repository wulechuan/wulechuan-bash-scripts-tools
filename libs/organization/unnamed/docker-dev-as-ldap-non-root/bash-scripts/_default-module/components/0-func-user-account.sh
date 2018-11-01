function __welcome_for_non_root_user__ {
    local currentUserName=`getCurrentUserName`

    echo
    echo -e "${darkline50}"

    if [ "$copywritingLanguage" = "zh_CN" ]; then
        colorful -- "    $currentUserName"           textBlue
        colorful -n "，你好！"                        textGreen

        colorful -- "    欢迎 ["  textGreen
        colorful -- $(hostname -I | cut -d' ' -f2)   textMagenta
        colorful -n "]！" textGreen
    fi
    if [ "$copywritingLanguage" = "en_US" ]; then
        colorful -- "    Hi,"                         textGreen
        colorful -- "$currentUserName"                textBlue
        colorful -n "!"                               textGreen

        colorful -- "    Welcome to ["   textGreen
        colorful -- $(hostname -I | cut -d' ' -f2)    textMagenta
        colorful -n "]!"                              textGreen
    fi

    echo -e "${darkline50}"
    echo
}
