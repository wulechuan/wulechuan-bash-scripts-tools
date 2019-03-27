function try_to_unalias {
	local result=`alias | grep " $1="`
	if [ ! -z "$result" ]; then
		unalias "$1"
	fi
}
