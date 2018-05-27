function getCurrentUserName {
    local currentUserName=$USERNAME

    if [ -z "$USERNAME" ]; then
        currentUserName=`whoami`
    fi

    echo $currentUserName
}