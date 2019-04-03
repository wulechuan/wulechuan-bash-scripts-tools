function detect-remote-file {
	if [ -z "$1" ] || [ -z "$2" ] || [ -z "$3" ] || [ -z "$4" ]; then
		console.error    "function detect-remote-file {}: \$1, \$2, \$3 and \$4 are all required."
		return 1
	fi


	local remoteHostAndHost="$1"
	local signalFileRemoteLocationPath="$2"
	local signalFileName="$3"
	local signalFileLocalTempStoragePath="$4"
	local shouldEchoFullContentOfLocalTempFileAndThenDeleteIt='no'

	if [ "$5" == '--print-signal-file-content' ]; then
		shouldEchoFullContentOfLocalTempFileAndThenDeleteIt='yes'
	fi

	local signalFileLocalFullPath="$signalFileLocalTempStoragePath/$signalFileName"




	scp    -q    "$remoteHostAndHost:$signalFileRemoteLocationPath/$signalFileName"    "$signalFileLocalTempStoragePath/"

	if [ -f "$signalFileLocalFullPath" ]; then

		if [ "$shouldEchoFullContentOfLocalTempFileAndThenDeleteIt" == 'yes' ]; then
			cat    "$signalFileLocalFullPath"
			rm     "$signalFileLocalFullPath"
		else
			echo 'yes'
		fi
	else
		if [ "$shouldEchoFullContentOfLocalTempFileAndThenDeleteIt" != 'yes' ]; then
			echo 'no'
		fi
	fi
}
