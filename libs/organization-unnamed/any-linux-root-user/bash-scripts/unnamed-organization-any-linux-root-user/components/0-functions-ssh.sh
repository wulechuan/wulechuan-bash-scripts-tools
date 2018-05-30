function unnamed-organization-ssh-key {
    echo "LDPA email address: $myLDPAUserName@unamed-organization.com"

    ssh-keygen -I $myLDPAUserName@unnamed-organization.com -C "$myLDPAUserName@unnamed-organization.com ($dockerIPPrefix$thisDockerIPSuffix)"
    if [ $? = 0 ]; then
        set-color textGreen
        cat ~/.ssh/id_rsa.pub
        clear-color

        echo -e "Please copy-paste the ssh pub key shown above to your browser"
        read
    fi
}