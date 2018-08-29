function setup-shadowsocks {
    local VE_line='────────────────────────────────────────────────────────────'

    local userNameInHostName
    if [ ! -z "$1" ]; then
        userNameInHostName=$1
    else
        userNameInHostName='wulechuan'
    fi



    while true; do
        echo
        echo
        echo $VE_line
        echo -e "Would you like to change \033[31mpassword\033[0;0m for \033[31mroot\033[0;0m user now?"
        echo $VE_line
        echo -en "[yes/no] "
        read shouldChangeRootPassword

        case $shouldChangeRootPassword in
            [yY][eE][sS])
                echo -e "Change \033[31mpassword\033[0;0m for \033[31mroot\033[0;0m user"
                passwd root
                break
            ;;

            [nN][oO])
                echo
                echo -e "Skipped."
                break
            ;;
        esac
    done



    echo
    echo
    echo $VE_line
    echo -e "Install \033[32mepel-relase\033[0;0m"
    echo $VE_line
    yum -y install epel-release



    echo
    echo
    echo $VE_line
    echo -e "Install \033[32mpip\033[0;0m (for python)"
    echo $VE_line
    # yum -y install python-pip
    cd
    curl https://bootstrap.pypa.io/get-pip.py -o get-pip.py
    python get-pip.py




    echo
    echo
    echo $VE_line
    echo -e "Install \033[32mshadowsocks\033[0;0m"
    echo $VE_line
    pip install shadowsocks




    if [ ! -d "/etc/shadowsocks" ]; then
        echo
        echo
        echo $VE_line
        echo -e "Create folder \"\033[93m/etc/shadowsocks/\033[0;0m\""
        echo $VE_line
        mkdir /etc/shadowsocks
    fi



    local shadowsocksTemplatesFolder="$HOME/shadowsocks-templates"
    echo
    echo
    if [ -f "/etc/shadowsocks/shadowsocks.json" ]; then
        echo $VE_line
        echo -e "File \"\033[92m/etc/shadowsocks/shadowsocks.json\033[0;0m\" already exists."
        echo -e "But you might need to edit it still."
        echo -e "\033[93mSkip just for now.\033[0;0m"
        echo $VE_line
    else
        if [ -f "$shadowsocksTemplatesFolder/shadowsocks.json" ]; then
            echo $VE_line
            echo -e "Copy \"\033[34m~/shadowsocks-template/shadowsocks.json\033[0;0m\""
            echo -e "  to \"\033[92m/etc/shadowsocks/shadowsocks.json\033[0;0m\""
            echo $VE_line

            cp "$shadowsocksTemplatesFolder/shadowsocks.json" /etc/shadowsocks/
            vi /etc/shadowsocks/shadowsocks.json
        else
            echo $VE_line
            echo -e "File \"\033[34m~/shadowsocks-templates/shadowsocks.json\033[0;0m\" \033[31mnot found\033[0;0m."
            echo -e "Please \033[93mmanually\033[0;0m create and edit this file:"
            echo -e "    \"\033[92m/etc/shadowsocks/shadowsocks.json\033[0;0m\"."
            echo $VE_line
        fi
    fi



    echo
    echo
    if [ -f "/etc/systemd/system/shadowsocks.service" ]; then
        echo $VE_line
        echo -e "\"\033[92m/etc/systemd/system/shadowsocks.service\033[0;0m\" already exists."
        echo -e "But you might need to edit it still."
        echo -e "\033[93mSkip just for now.\033[0;0m"
        echo $VE_line
        echo

        systemctl status shadowsocks.service
    else
        if [ -f "$shadowsocksTemplatesFolder/shadowsocks.json" ]; then
            echo $VE_line
            echo -e "Copy \"\033[34m~/shadowsocks-templates/shadowsocks.service\033[0;0m\""
            echo -e "  to \"\033[92m/etc/systemd/system/shadowsocks.service\033[0;0m\""
            echo $VE_line

            cp "$shadowsocksTemplatesFolder/shadowsocks.service" /etc/systemd/system/shadowsocks.service
            systemctl enable shadowsocks.service
            systemctl start  shadowsocks.service
            systemctl status shadowsocks.service
        else
            echo $VE_line
            echo -e "\"\033[34m~/shadowsocks-templates/shadowsocks.service\033[0;0m\" \033[31mnot found\033[0;0m."
            echo -e "Please \033[93mmanually\033[0;0m create and edit this file:"
            echo -e "    \"\033[92m/etc/systemd/system/shadowsocks.service\033[0;0m\"."
            echo -e " and then run these commands:"
            echo -e "    systemctl enable shadowsocks.service"
            echo -e "    systemctl start  shadowsocks.service"
            echo -e "    systemctl status shadowsocks.service"
            echo $VE_line
        fi
    fi
}
