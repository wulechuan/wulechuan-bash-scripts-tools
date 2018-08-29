function setup-hostname {
    local ipAddress=`hostname -I`
    ipAddress=${ipAddress//./-}
    hostname "$userNameInHostName-bandwagon-$ipAddress"
    exec bash -l
}