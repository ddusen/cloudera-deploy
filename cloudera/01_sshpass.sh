#!/bin/bash

#author: Sen Du
#email: dusen@gennlife.com
#created: 2023-04-16 10:00:00
#updated: 2023-04-16 10:00:00

set -e 

# 安装sshpass
function install_sshpass() {
    echo -e '\t\t yum install -y sshpass'
    yum install -y sshpass
}

# 配置免密
function config_sshpass() {
    echo -e '\t\t cat config/vm_info | while read ipaddr passwd; do sshpass -p $passwd ssh-copy-id -o StrictHostKeyChecking=no $ipaddr; done'
    cat config/vm_info | while read ipaddr passwd; do sshpass -p $passwd ssh-copy-id -o StrictHostKeyChecking=no $ipaddr; done
}

function main() {
    echo '01_sshpass.sh'
    echo -e '\t install_sshpass'
    install_sshpass

    echo -e '\t config_sshpass'
    config_sshpass
}

main
