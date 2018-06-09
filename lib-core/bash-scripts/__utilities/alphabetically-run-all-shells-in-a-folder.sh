function alphabetically-run-all-shells-in-a-folder {
    local folderOfActions=$1

    if [ ! -z "$folderOfActions" ] && [ -d "$folderOfActions" ]; then
        local actions=`ls $folderOfActions | grep .sh$`
        local action

        for action in $actions; do
            source "$folderOfActions/$action"
        done
    fi
}
