function create-folder-with-random-number-suffix {
    local ___createRandomFolder_nameOfThisFunction___='create-folder-with-random-number-suffix'

    local __randomNamedFolderNamePrefix___
    local __randomNamedFolderParentPath___

    function create-folder-with-random-number-suffix--print_help {
        local ___createRandomFolder_colorOfArgumentName___='textGreen'
        local ___createRandomFolder_colorOfArgumentValue___='textMagenta'
        local ___createRandomFolder_colorOfMarkers___='textBlue'

        echo

        if [ "$1" == '--should-print-separation-line' ]; then
            colorful -n "$VE_line_60"
            echo
        fi

        colorful -n 'Usage:'

        colorful -- "    $___createRandomFolder_nameOfThisFunction___"
        colorful -n ' \\'

        colorful -- "        [ "    $___createRandomFolder_colorOfMarkers___
        colorful -- "--folder-name-prefix="       $___createRandomFolder_colorOfArgumentName___
        colorful -- "\"<folder name prefix>\""    $___createRandomFolder_colorOfArgumentValue___
        colorful -- " ]"    $___createRandomFolder_colorOfMarkers___
        colorful -n ' \\'

        colorful -- "        [ "    $___createRandomFolder_colorOfMarkers___
        colorful -- "--parent-folder-path="       $___createRandomFolder_colorOfArgumentName___
        colorful -- "\"<path of the parent folder of folder to create>\""    $___createRandomFolder_colorOfArgumentValue___
        colorful -- " ]"    $___createRandomFolder_colorOfMarkers___
        colorful -n ' \\'

        colorful -- "        \"<ref var for accepting the result folder path>\""    $___createRandomFolder_colorOfArgumentValue___
        colorful -n ' \\'


        colorful -- "        [ "    $___createRandomFolder_colorOfMarkers___
        colorful -- "\"<ref var for accepting the result folder name>\""    $___createRandomFolder_colorOfArgumentValue___
        colorful -- " ]"    $___createRandomFolder_colorOfMarkers___
        echo
        echo




        colorful -n 'Examples:'

        colorful -- "    local "    $___createRandomFolder_colorOfMarkers___
        colorful -n "my-result-folder-path"    $___createRandomFolder_colorOfArgumentValue___

        colorful -- "    $___createRandomFolder_nameOfThisFunction___"

        colorful -- "    --folder-name-prefix="    $___createRandomFolder_colorOfArgumentName___
        colorful -- "my-temp-folder--"    $___createRandomFolder_colorOfArgumentValue___

        colorful -- "    my-result-folder-path"    $___createRandomFolder_colorOfArgumentName___
        echo
        echo

        colorful -- "    local "    $___createRandomFolder_colorOfMarkers___
        colorful -n "temp-folder-path"    $___createRandomFolder_colorOfArgumentValue___

        colorful -- "    $___createRandomFolder_nameOfThisFunction___"
        colorful -n ' \\'

        colorful -- "    --folder-name-prefix="    $___createRandomFolder_colorOfArgumentName___
        colorful -- "my-working-folder--"    $___createRandomFolder_colorOfArgumentValue___

        colorful -- "    --parent-folder-path="    $___createRandomFolder_colorOfArgumentName___
        colorful -- "~/my-cache"    $___createRandomFolder_colorOfArgumentValue___

        colorful -- "    temp-folder-path"    $___createRandomFolder_colorOfArgumentName___
        echo
        echo
    }

    if [ $# -eq 0 ]; then
        create-folder-with-random-number-suffix--print_help
        return 0
    fi

    if [[ "$1" =~ ^--folder-name-prefix= ]]; then
        __randomNamedFolderNamePrefix___="${1:21}"
        shift
    fi

    if [[ "$1" =~ ^--parent-folder-path= ]]; then
        __randomNamedFolderParentPath___="${1:21}"
        shift
    fi

    if [ $# -eq 0 ]; then
        wlc-print-error    -1    "A ref variable must be provided to carry resulted folder path."
        create-folder-with-random-number-suffix--print_help    --should-print-separation-line
        return 3
    fi




    if [ -z "$__randomNamedFolderNamePrefix___" ]; then
        __randomNamedFolderNamePrefix___="_general_usage_temp_folder"
    fi

    if [ -z "$__randomNamedFolderParentPath___" ]; then
        __randomNamedFolderParentPath___="$WLC_BASH_TOOLS___FOLDER_PATH___OF_CACHE"
    fi

    local __randomNamedFolderName___
    local __randomNamedFolderPath___

    while true; do
        __randomNamedFolderName___="$__randomNamedFolderNamePrefix___--$RANDOM"
        __randomNamedFolderPath___="$__randomNamedFolderParentPath___/$__randomNamedFolderName___"

        if [ ! -d "$__randomNamedFolderPath___" ]; then
            mkdir    -p    "$__randomNamedFolderPath___"
            break
        fi
    done



    eval "$1=$__randomNamedFolderPath___"

    if [ $# -gt 1 ]; then
        eval "$2=$__randomNamedFolderName___"
    fi
}