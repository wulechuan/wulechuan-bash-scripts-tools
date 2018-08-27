function print-repository-location {
	echo

	local splashString=''
	append-colorful-string-to splashString -n "$VE_line_70" textBlue
	append-colorful-string-to splashString -- "Location: "  textBlue
	append-colorful-string-to splashString -n "$___here"    textCyan
	append-colorful-string-to splashString -n "$VE_line_70" textBlue

	echo -e "$splashString"
}

print-repository-location