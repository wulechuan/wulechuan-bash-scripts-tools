function __unnamed_organization_docker_welcome_for_non_root_user__ {
    local currentUserName=`getCurrentUserName`

    echo
    echo -e "${darkline50}"

    if [ "$copywritingLanguage" = "zh_CN" ]; then
        colorful -- "    $currentUserName"           textBlue
        colorful -n "，你好！"                        textGreen

        colorful -- "    欢迎使用【名字不告诉你的公司】的 Docker ["  textGreen
        colorful -- $(hostname -I | cut -d' ' -f2)   textMagenta
        colorful -n "]！" textGreen
    fi
    if [ "$copywritingLanguage" = "en_US" ]; then
        colorful -- "    Hi,"                         textGreen
        colorful -- "$currentUserName"                textBlue
        colorful -n "!"                               textGreen

        colorful -- "    Welcome to unnamed-organization docker ["   textGreen
        colorful -- $(hostname -I | cut -d' ' -f2)    textMagenta
        colorful -n "]!"                              textGreen
    fi

    echo -e "${darkline50}"
    echo



    if [ "$copywritingLanguage" = "zh_CN" ]; then
        colorful -- "现在，于 Docker 中将身份切换到 root 用户。" textYellow
    fi
    if [ "$copywritingLanguage" = "en_US" ]; then
        colorful -- "let's switch to root user "             textYellow
    fi
}


function update-root-bash-scripts__and-then__sudo-with-dash-i {
    set-color textBlue

    sudo /bin/cp  -f "/home/users/${myCompanyLDPAUserName}/unnamed-organization-docker-for-developer-root-user/.bashrc"                    /root/
    sudo /bin/cp  -f "/home/users/${myCompanyLDPAUserName}/unnamed-organization-docker-for-developer-root-user/.bash_profile"              /root/
    sudo /bin/cp -rf "/home/users/${myCompanyLDPAUserName}/unnamed-organization-docker-for-developer-root-user/$wlcBashScriptsFolderName"  /root/
    sudo -i
}
