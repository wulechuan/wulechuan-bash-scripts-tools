function clear_files_in_folder {
	if    [ -z "$1" ] \
	   || [ "$1" == / ] \
	   || [ "$1" == '/' ] || [ "$1" == "/" ] \
	   || [ "$1" == ~ ] \
	   || [ "$1" == '~' ] || [ "$1" == "~" ];
	then
		colorful -n "DANGER Folder to delete items from."    textBlack    bgndRed
		return 999
	fi

	if [[ $1 =~ [\*\?] ]]; then
		colorful -n "INVALID Folder to delete items from."    textBlack    bgndRed
		return 998
	fi

	local theFolder=$1
	local itemNamePatternForListing=''
	local itemNamePatternForDeletion=/*
	local itemNamePatternForDisplay='*'
	local patternIsInFactEmpty='yes'

	if [[ ! "$theFolder" =~ /$ ]]; then
		theFolder="$theFolder/"
	fi

	if [ ! -z "$2" ]; then
		patternIsInFactEmpty='no'
		itemNamePatternForListing=/$2
		itemNamePatternForDeletion=/$2
		itemNamePatternForDisplay=$2
	fi


	local existingItems=`ls    $theFolder`

	if   [ -z "$existingItems" ]; then

		colorful -- 'The folder "'
		colorful -- "$theFolder"    textYellow
		colorful -n '" was already empty. Nothing to delete.'

		return
	fi




	local existingMatchedItems



	if [ "$patternIsInFactEmpty" == 'yes' ]; then
		existingMatchedItems=`ls    ${theFolder}`
	else
		existingMatchedItems=`ls    -d    ${theFolder}${itemNamePatternForListing}`
	fi

	if [ -z "$existingMatchedItems" ]; then

		colorful -- 'The folder "'
		colorful -- "$theFolder"                      textYellow
		colorful -- "\" contains zero items that match pattern ("
		colorful -- "${itemNamePatternForDisplay}"    textCyan
		colorful -n ")."
		colorful -n "Nothing to delete."

		return

	fi

	colorful -- 'Removing all items matching pattern "'    textRed
	colorful -- "$theFolder"                               textYellow
	colorful -- "${itemNamePatternForDisplay}"             textMagenta
	colorful -n '"...'                                     textRed





	rm    -rf    ${theFolder}${itemNamePatternForDeletion}




	existingItems=`ls    $theFolder`

	if   [ -z "$existingItems" ]; then
		existingMatchedItems=''
	else
		if [ "$patternIsInFactEmpty" == 'yes' ]; then
			existingMatchedItems=`ls    ${theFolder}`
		else
			existingMatchedItems=`ls    -d    ${theFolder}${itemNamePatternForListing}`
		fi
	fi


	if [ -z "$existingMatchedItems" ]; then

		colorful -- 'All items maching pattern "'    textRed
		colorful -- "$theFolder"                     textYellow
		colorful -- "$itemNamePatternForDisplay"     textMagenta
		colorful -n '" had removed.'                 textRed

	else

		colorful -- 'NOT all items matching pattern "'    textBlack    bgndRed
		colorful -- "$theFolder"                          textBlack    bgndYellow
		colorful -- "$itemNamePatternForDisplay"          textBlack    bgndMagenta
		colorful -n '" had removed.'                      textBlack    bgndRed

		echo -e  "\e[31mRemained items are:\e[0m"

		if [ "$patternIsInFactEmpty" == 'yes' ]; then
			existingMatchedItems=`ls    -1     ${theFolder}`
		else
			existingMatchedItems=`ls    -1d    ${theFolder}${itemNamePatternForListing}`
		fi

		echo

		return 127

	fi
}
