#!/bin/bash

#author: Sen Du
#email: dusen@gennlife.com
#created: 2023-04-16 10:00:00
#updated: 2023-04-16 10:00:00

set -e 

# 安装sshpass
function install_sshpass() {
    echo -e "$CSTART>>>>yum install -y sshpass$CEND"
    yum install -y sshpass
}

# 配置免密
function config_sshpass() {
    echo -e "$CSTART>>>>cat config/vm_info | while read ipaddr passwd; do sshpass -p \$passwd ssh-copy-id -o StrictHostKeyChecking=no \$ipaddr; done$CEND"
    cat config/vm_info | while read ipaddr passwd; do sshpass -p $passwd ssh-copy-id -o StrictHostKeyChecking=no $ipaddr; done
}

function main() {
    echo -e "$CSTART>01_sshpass.sh$CEND"
    echo -e "$CSTAET>>install_sshpass$CEND"
    install_sshpass

    echo -e "$CSTAET>>config_sshpass$CEND"
    config_sshpass
}

main
