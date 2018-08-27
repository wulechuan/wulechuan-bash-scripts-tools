if [ -f ~/bash-scripts/start.sh ]; then
    source ~/bash-scripts/start.sh
fi

___temp_pwd_inside_bashrc___=`pwd`
___should_goto_convenient_folder___='false'

if [ "$___temp_pwd_inside_bashrc___" = '/cygdrive/c/Users/wulechuan' ]; then
    ___should_goto_convenient_folder___='true'
else
    if [ "$___temp_pwd_inside_bashrc___" = '/c/Users/wulechuan' ]; then
        ___should_goto_convenient_folder___='true'
    fi
fi

if [ $___should_goto_convenient_folder___ == 'true' ]; then
    cd "d:/projects/unnamed-organization/2018"
fi

unset ___temp_pwd_inside_bashrc___
unset ___should_goto_convenient_folder___
