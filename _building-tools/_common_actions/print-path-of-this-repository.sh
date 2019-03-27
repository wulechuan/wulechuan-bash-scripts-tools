function print-path-of-this-repository {
	echo
	colorful -n "$VE_line_70" textBlue
	colorful -- "Location: "  textBlue
	colorful -n "$___here"    textCyan
	colorful -n "$VE_line_70" textBlue
	echo
}

print-path-of-this-repository