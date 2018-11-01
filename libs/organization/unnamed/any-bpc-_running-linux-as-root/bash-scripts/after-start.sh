if [[ $- =~ i ]]; then
	if [ -f ~/customer-data-were-just-restored ]; then
		colorful -- 'Remove "' textRed
		colorful -- '~/customer-data-were-just-restored'   textYellow
		colorful -n '"'        textRed

		rm  ~/customer-data-were-just-restored

	elif [ -f ~/should-install-this-version ]; then
		echo
		colorful -n '──────────────────────────────────────────────────'   textGreen
		colorful -- 'Automatically install something, version: '           textGreen
		colorful -n "`cat ~/should-install-this-version`"               textMagenta
		colorful -n '──────────────────────────────────────────────────'   textGreen
		echo

		__install

	elif [ -f ~/was-just-installed ]; then
		if [ -d "$customerSourceDataFolderName" ]; then
			echo
			colorful -n '──────────────────────────────────────────────────'   textGreen
			colorful -n 'Automatically restore customer data (everything)  '   textGreen
			colorful -n '──────────────────────────────────────────────────'   textGreen
			echo

			restore-customer-everything
		else
			rm  ~/was-just-installed
		fi
	fi
fi