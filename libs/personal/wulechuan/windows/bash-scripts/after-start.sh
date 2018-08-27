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
    cd "d:/Users/wulechuan/Desktop/somewhere"
fi

unset ___temp_pwd_inside_bashrc___
unset ___should_goto_convenient_folder___
