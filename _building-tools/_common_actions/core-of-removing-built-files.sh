#!/bin/bash
# To clean existing distribution if any

function wlc_bash_tools--remove_exisiting_built_files--core {
    local somthingDeleted

    function deleteSomething {
        if [ $# -gt 3 ]; then
            local _descriotionOfThingsToDelete="$2"

            shift # --description
            shift # value of --description, aka _descriotionOfThingsToDelete
            shift # --items

            if [ ! -z "$*" ]; then
                rm    -rf    $*

                somthingDeleted='yes'
                colorful --  'Deleted: '                       textRed
                echo     -en '<this repository>/'
                colorful -- "$_descriotionOfThingsToDelete"    textBlack   bgndRed
                echo
            fi
        fi
    }



    echo
    colorful -n "$VE_line_70"    textRed


    if [ -d "$___pathOf_buildOutputRootFolder" ]; then
        deleteSomething \
            --description "$___subPathOf_buildOutputRootFolder" \
            --items       "$___pathOf_buildOutputRootFolder"
    fi


    deleteSomething \
        --description "$___subPathOf_sourceRootFolderOfAllComponents/core/**/*.wlc-filled-bash-template" \
        --items       `find "$___pathOf_sourceRootFolderOfAllComponents/core/" -name "*.wlc-filled-bash-template"`


    deleteSomething \
        --description "$___subPathOf_sourceRootFolderOfAllComponents/optional/**/*.wlc-filled-bash-template" \
        --items       `find "$___pathOf_sourceRootFolderOfAllComponents/optional/" -name "*.wlc-filled-bash-template"`



    if [ -z "$somthingDeleted" ]; then
        echo "Nothing was deleted."
    fi

    colorful -n "$VE_line_70"    textRed
    echo
    echo


    unset -f wlc_bash_tools--remove_exisiting_built_files--core
}

wlc_bash_tools--remove_exisiting_built_files--core