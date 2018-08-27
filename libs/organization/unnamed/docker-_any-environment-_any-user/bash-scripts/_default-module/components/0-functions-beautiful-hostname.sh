function __unnamed_organization_docker_print_initialization_splash_ {
    echo -e "${darkline60}"

	if [ "$copywritingLanguage" = "zh_CN" ]; then
		echo -e "${green}  初始化docker${dark}[${noColor}${brown}${ipSuffixForDockerForDeveloper}${thisDockerIPSuffix}${green}${dark}]${noColor}.……"
	fi
	if [ "$copywritingLanguage" = "en_US" ]; then
		echo -e "${green}  Initializing docker${dark}[${noColor}${brown}${ipSuffixForDockerForDeveloper}${thisDockerIPSuffix}${green}${dark}]${noColor}..."
	fi

    echo -e "${darkline60}"
	echo
}

function __unnamed_organization_docker_detect_using_default_ugly_hostname_ {
	local regExpDockerDefaultHostName='^[1234567890abcdef]{6,12}$'
	local regExpPreferredHostNameHasLineBreak='.+\s$'

	local preferredHostName
	local preferredHostNameLength

	local decidedHostName

	if [[ "$HOSTNAME" =~ $regExpDockerDefaultHostName ]]; then

		if [ -f '/root/.preferred-hostname' ]; then
			preferredHostName=`cat /root/.preferred-hostname`

			if [[ "$preferredHostName" =~ $regExpPreferredHostNameHasLineBreak ]]; then
				preferredHostNameLength=${#preferredHostName}
				# echo preferredHostNameLength=$preferredHostNameLength

				preferredHostNameLength=$((preferredHostNameLength-1))
				# echo preferredHostNameLength=$preferredHostNameLength

				preferredHostName=${preferredHostName:0:$preferredHostNameLength}
				# echo preferredHostName=$preferredHostName
			fi

			decidedHostName=$preferredHostName
		# else
			# decidedHostName=``
		fi


		hostname "$decidedHostName"
		exec bash -l
	fi
}
