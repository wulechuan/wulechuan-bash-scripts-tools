function compareTwoValues {
	local __result__
	local __va__="$1"
	local __vb__="$2"
	shift
	shift
	_compareTwoValues    __result__    "$__va__"   "$__vb__"   $*
	if [ $? -eq 0 ]; then
		echo $__result__
	fi
}

function _compareTwoValues {
	# This function is useful for comparing two version strings, like 3.1.9-final vs 5.1.5-gold.
	# So:
	#     ONLY integers and strings are supported.
	#     Floating points, exp numbers are NOT supported.
	#
	# $1: the result
	# $2: value 1
	# $3: value 2

	if [ $# -lt 1 ]; then
		colorful -n 'Too few arguments for function "_compareTwoValues"'   textRed
		return 6
	fi

	if [ $# -gt 3 ]; then
		colorful -n 'Too many arguments for function "_compareTwoValues"'   textRed
		return 7
	fi


	local resultOf__comparingTwoValues

	local __VA__="$2"
	local __VB__="$3"



	local __VA__is_a_number='no'
	local __VB__is_a_number='no'

	if [[ "$__VA__" =~ ^[+-]?[0-9]+$ ]]; then
		__VA__is_a_number='yes'
	fi

	if [[ "$__VB__" =~ ^[+-]?[0-9]+$ ]]; then
		__VB__is_a_number='yes'
	fi




	if   [   -z "$__VA__" ] && [   -z "$__VB__" ]; then

		resultOf__comparingTwoValues='both-absent'

	elif [ ! -z "$__VA__" ] && [   -z "$__VB__" ]; then

		resultOf__comparingTwoValues='B-absents'

	elif [   -z "$__VA__" ] && [ ! -z "$__VB__" ]; then

		resultOf__comparingTwoValues='A-absents'

	elif [ "$__VA__is_a_number" == 'yes' ] && [ "$__VB__is_a_number" == 'yes' ]; then

		if [ "$__VA__" -gt "$__VB__" ]; then
			resultOf__comparingTwoValues='number-A-is-larger'
		elif [ "$__VA__" -eq "$__VB__" ]; then
			resultOf__comparingTwoValues='equal-numbers'
		else
			resultOf__comparingTwoValues='number-A-is-smaller'
		fi

	elif [ "$__VA__" == "$__VB__" ]; then

		resultOf__comparingTwoValues='equal-strings'

	else

		resultOf__comparingTwoValues='different-strings'

	fi

	eval "$1=$resultOf__comparingTwoValues"
}
