function make-an-ssh-key-for-unnamed-organization-ldap-user {
    echo "LDPA email address: $myCompanyLDPAUserName@myCompanyEmailDomainName"

    ssh-keygen -I $myCompanyLDPAUserName@myCompanyEmailDomainName -C "$myCompanyLDPAUserName@myCompanyEmailDomainName ($ipSuffixForDockerForDeveloper$thisDockerIPSuffix)"
    if [ $? = 0 ]; then
        set-color textGreen
        cat ~/.ssh/id_rsa.pub
        clear-color

        echo -e "Please copy-paste the ssh pub key shown above to your browser"
        read
    fi
}