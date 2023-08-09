#!/bin/bash

#author: Sen Du
#email: dusen@gennlife.com
#created: 2023-04-16 10:00:00
#updated: 2023-04-16 10:00:00

set -e 
source 00_env

# 生成公钥私钥
function generate_key() {
    echo -e "$CSTART>>>>$(hostname -I)$CEND"
    echo n | ssh-keygen -t rsa -q -f "$HOME/.ssh/id_rsa" -N "" || true
}

# 安装sshpass
function install_sshpass() {
    echo -e "$CSTART>>>>$(hostname -I)$CEND"
    rpm -Uvh rpms/epel-release-7-14.noarch.rpm || true
    rpm -Uvh rpms/sshpass-1.06-2.el7.x86_64.rpm || true
}

# 配置免密
function config_sshpass() {
    cat config/vm_info | grep -v "^#" | grep -v "^$" | while read ipaddr name passwd
    do
        echo -e "$CSTART>>>>$ipaddr [$(date +'%Y-%m-%d %H:%M:%S')]$CEND"
        sshpass -p $passwd ssh-copy-id -o StrictHostKeyChecking=no $ipaddr
    done
}

function main() {	
    echo -e "$CSTART>01_sshpass.sh$CEND"

    echo -e "$CSTART>>generate_key$CEND"
    generate_key

    echo -e "$CSTART>>install_sshpass$CEND"
    install_sshpass

    echo -e "$CSTART>>config_sshpass$CEND"
    config_sshpass
}

main
