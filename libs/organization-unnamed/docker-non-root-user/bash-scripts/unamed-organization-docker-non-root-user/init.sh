echo
echo -e "${darkline50}"

if [ "$copywritingLanguage" = "zh_CN" ]; then
    echo -e "${green}    ${blue}${currentUserName}${green}，你好！"
    echo -e "${green}    欢迎使用【某某组织】Docker [${brown}$(hostname -I | cut -d' ' -f2)${green}]！"
fi
if [ "$copywritingLanguage" = "en_US" ]; then
    echo -e "${green}    Hi, ${blue}${currentUserName}${green}!"
    echo -e "${green}    Welcome to unnamed organization docker [${brown}$(hostname -I | cut -d' ' -f2)${green}]!"
fi

echo -e "${darkline50}"
echo
