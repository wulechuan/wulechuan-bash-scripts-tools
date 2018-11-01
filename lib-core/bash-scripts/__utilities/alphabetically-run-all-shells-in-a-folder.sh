function alphabetically-run-all-shells-in-a-folder {
    local folderOfActions=$1
    local actions
    local action

    if [ ! -z "$folderOfActions" ] && [ -d "$folderOfActions" ]; then
        # actions=`ls -A1 "$folderOfActions/*.sh"` # 这种写法无法应对找到零个 .sh 文件的情形。须额外的 if 语句来判断 ls 是否成功。
        actions=`ls "$folderOfActions" | grep \.sh$`

        for action in $actions; do
            source "$folderOfActions/$action"
        done
    fi
}
