function install-vmware-tools-for-linux {
    if [ ! -d /mnt/cdrom ]; then
        mkdir /mnt/cdrom
    fi

    mount /dev/cdrom /mnt/cdrom
    cd /mnt/cdrom
    local vmtPackageFileName=`ls | grep VMwareTools`

    echo ""
    echo -e "Package to use: "`colorful $vmtPackageFileName textGreen`
    echo ""

    cd /tmp
    tar zxpf "/mnt/cdrom/${vmtPackageFileName}"
    cd vmware-tools-distrib
    ./vmware-install.pl

    echo -e `colorful "如果安装失败，你可能需要:" textBlue`
    echo -e "    "`colorful "yum install kernel-devel" textGreen`
    echo ""
}

# function reinstall-vmware-tools-for-linux {
#     perl /usr/bin/vmware-config-tools.pl

#     echo -e `colorful "如果安装失败，你可能需要:" textBlue`
#     echo -e "    "`colorful "yum install kernel-devel" textGreen`
#     echo ""
# }