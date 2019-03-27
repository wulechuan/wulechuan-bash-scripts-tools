function to-source-a-bash-file {
	local fileToLoad="$1"

	if [ -f "$fileToLoad" ]; then
		source    "$fileToLoad"
		return $?
	else
		console.error    "While trying to\e[33m source \e[31ma bash file, the file was not found:\n    \"\e[33m$fileToLoad\e[31m\""
		return 319
	fi
}