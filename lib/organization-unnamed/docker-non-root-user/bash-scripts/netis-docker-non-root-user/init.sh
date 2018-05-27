echo
echo -e "${darkline50}"

if [ "$copywritingLanguage" = "zh_CN" ]; then
    echo -e "${green}    ${blue}${currentUserName}${green}，你好！"
    echo -e "${green}    欢迎使用【某某公司】Docker [${brown}$(hostname -I | cut -d' ' -f2)${green}]！"
fi
if [ "$copywritingLanguage" = "en_US" ]; then
    echo -e "${green}    Hi, ${blue}${currentUserName}${green}!"
    echo -e "${green}    Welcome to Unnamed Organization docker [${brown}$(hostname -I | cut -d' ' -f2)${green}]!"
fi

echo -e "${darkline50}"
echo



if [ "$copywritingLanguage" = "zh_CN" ]; then
    echo -e -n "${blue}现在，于 Docker 中将身份切换到 root 用户。"
fi
if [ "$copywritingLanguage" = "en_US" ]; then
    echo -e -n "${blue}let's switch to root user "
fi


sudo -i