function getVersionSegmentsFrom {
    # $2: will be chief version number or empty
    # $3: will be sub   version number or empty
    # $4: will be patch version string or empty. Well, in most cases it's a number as well

	# example:
	# $ getVersionSegmentsFrom  4.1.6-beta  vc  vs  vp
	# $ echo $vc
	# 4
	# $ echo $vs
	# 1
	# $ echo $vp
	# 6-beta

    local inputVersionString="$1"
    # echo DEBUG: inputVersionString=$inputVersionString

    local versionSegment0=''
    local versionSegment1=''
    local versionSegment2=''

    local versionSegments

    if [ ! -z "$inputVersionString" ]; then
        local oldIFS
        oldIFS=$IFS
        IFS='.'
        versionSegments=($inputVersionString)
        IFS=$oldIFS
    fi

    if [ $# -ge 2 ]; then
        if [ ! -z "${versionSegments[0]}" ]; then
            versionSegment0=${versionSegments[0]}
        fi

        eval "$2=$versionSegment0"
    fi

    if [ $# -ge 3 ]; then
        if [ ! -z "${versionSegments[1]}" ]; then
            versionSegment1=${versionSegments[1]}
        fi

        eval "$3=$versionSegment1"
    fi

    if [ $# -ge 4 ]; then
        if [ ! -z "${versionSegments[2]}" ]; then
            versionSegment2=${versionSegments[2]}
        fi

        eval "$4=$versionSegment2"
    fi
}

function comparing_two_versions: {
    local versionA="$1"
    local versionB="$3"
    local mode="$2"

    local VAS1
    local VAS2
    local VAS3

    local VBS1
    local VBS2
    local VBS3

    getVersionSegmentsFrom    $versionA    VAS1    VAS2    VAS3
    getVersionSegmentsFrom    $versionB    VBS1    VBS2    VBS3

    if [ -z "$VAS1" ]; then
        colorful -- "Invalid \$1 as version A: \""    textRed
        colorful -- "$versionA"                       textYellow
        colorful -n "\"."                             textRed
        return 101
    fi

    if [ -z "$VBS1" ]; then
        colorful -- "Invalid \$3 as version B: \""    textRed
        colorful -- "$versionB"                       textYellow
        colorful -n "\"."                             textRed
        return 103
    fi

    if     [ "$mode" != 'is-higher-than' ] \
        && [ "$mode" != 'is-lower-than' ] \
        && [ "$mode" != 'satisfies' ] \
        && [ "$mode" != 'exactly-equals-to' ]
    then
        colorful -- "Invalid \$2 as comparison mode: \""    textRed
        colorful -- "$mode"                                 textYellow
        colorful -n "\"."                                   textRed
        return 102
    fi


    local resultVS1s
    local resultVS2s
    local resultVS3s

    _compareTwoValues    resultVS1s    "$VAS1"    "$VBS1"
    _compareTwoValues    resultVS2s    "$VAS2"    "$VBS2"
    _compareTwoValues    resultVS3s    "$VAS3"    "$VBS3"




    local result='no'

    if   [ "$mode" == 'is-higher-than' ]; then

        if   [ "$resultVS1s" == 'number-A-is-larger' ]; then
            result='yes'
        elif   [ "$resultVS1s" == 'equal-numbers' ] \
            || [ "$resultVS1s" == 'equal-strings' ]
        then
            if [ "$resultVS2s" == 'number-A-is-larger' ]; then
                result='yes'
            elif   [ "$resultVS2s" == 'equal-numbers' ] \
                || [ "$resultVS2s" == 'equal-strings' ]
            then
                if [ "$resultVS3s" == 'number-A-is-larger' ]; then
                    result='yes'
                fi
            fi
        fi

    elif [ "$mode" == 'is-lower-than' ]; then

        if   [ "$resultVS1s" == 'number-A-is-smaller' ]; then
            result='yes'
        elif   [ "$resultVS1s" == 'equal-numbers' ] \
            || [ "$resultVS1s" == 'equal-strings' ]
        then
            if [ "$resultVS2s" == 'number-A-is-smaller' ]; then
                result='yes'
            elif   [ "$resultVS2s" == 'equal-numbers' ] \
                || [ "$resultVS2s" == 'equal-strings' ]
            then
                if [ "$resultVS3s" == 'number-A-is-smaller' ]; then
                    result='yes'
                fi
            fi
        fi

    elif [ "$mode" == 'satisfies' ]; then

        if   [ "$resultVS1s" == 'number-A-is-larger' ]; then
            result='yes'
        elif   [ "$resultVS1s" == 'equal-numbers' ] \
            || [ "$resultVS1s" == 'equal-strings' ]
        then

            if     [ "$resultVS2s" == 'number-A-is-larger' ] \
                || [ "$resultVS2s" == 'B-absents' ] \
                || [ "$resultVS2s" == 'both-absent' ]
            then
                result='yes'
            elif   [ "$resultVS2s" == 'equal-numbers' ] \
                || [ "$resultVS2s" == 'equal-strings' ]
            then

                if     [ "$resultVS3s" == 'number-A-is-larger' ] \
                    || [ "$resultVS3s" == 'B-absents' ] \
                    || [ "$resultVS3s" == 'both-absent' ]
                then
                    result='yes'
                elif   [ "$resultVS3s" == 'equal-numbers' ] \
                    || [ "$resultVS3s" == 'equal-strings' ]
                then
                    result='yes'
                fi
            fi
        fi

    elif [ "$mode" == 'exactly-equals-to' ]; then

        if     [ "$resultVS1s" == 'equal-numbers' ] \
            || [ "$resultVS1s" == 'equal-strings' ]
        then

            if     [ "$resultVS2s" == 'equal-numbers' ] \
                || [ "$resultVS2s" == 'equal-strings' ]
            then

                if     [ "$resultVS3s" == 'equal-numbers' ] \
                    || [ "$resultVS3s" == 'equal-strings' ]
                then
                    result='yes'
                fi
            fi
        fi

    fi

    echo $result
}