#!/bin/bash

#author: Sen Du
#email: dusen@gennlife.com
#created: 2023-04-16 14:00:00
#updated: 2023-04-16 14:00:00

set -e 

# 移除旧版本 ntp
function remove_old_ntp() {
    echo -e "$CSTART>>>>yum remove -y chrony ntp$CEND"
    yum remove -y chrony ntp
}

# 安装 ntp
function install_ntp() {
    echo -e "$CSTART>>>>cat config/vm_info | while read ipaddr name passwd; do ssh -n \$ipaddr \"yum install -y ntp\"; done$CEND"
    cat config/vm_info | while read ipaddr name passwd; do ssh -n $ipaddr "yum install -y ntp"; done
}

# 备份 ntp config
function backup_ntp_config() {
    echo -e "$CSTART>>>>cat config/vm_info | while read ipaddr name passwd; do ssh -n \$ipaddr \"cp /etc/ntp.conf /etc/ntp.conf.bak\"; done$CEND"
    cat config/vm_info | while read ipaddr name passwd; do ssh -n $ipaddr "cp /etc/ntp.conf /etc/ntp.conf.bak"; done
}

# 配置 ntp server
function config_ntp_server() {
    echo -e "$CSTART>>>>cp config/ntp_server /etc/ntp.conf$CEND"
    cp config/ntp_server /etc/ntp.conf
}

# 配置 ntp clients
function config_ntp_clients() {
    echo -e "$CSTART>>>>cat config/vm_info | while read ipaddr name passwd; do scp config/ntp_clients \$ipaddr:/etc/ntp.conf; done$CEND"
    cat config/vm_info | while read ipaddr name passwd; do scp config/ntp_clients $ipaddr:/etc/ntp.conf; done
}

# 重启 ntp 服务
function restart_ntp() {
    echo -e "$CSTART>>>>cat config/vm_info | while read ipaddr name passwd; do ssh -n \$ipaddr \"systemctl restart ntpd; systemctl enable ntpd; timedatectl set-ntp true\"; done$CEND"
    cat config/vm_info | while read ipaddr name passwd; do ssh -n $ipaddr "systemctl restart ntpd; systemctl enable ntpd; timedatectl set-ntp true"; done
}

function main() {
    echo -e "$CSTART>06_ntp.sh$CEND"

    echo -e "$CSTART>>remove_old_ntp$CEND"
    remove_old_ntp

    echo -e "$CSTART>>install_ntp$CEND"
    install_ntp

    echo -e "$CSTART>>backup_ntp_config$CEND"
    backup_ntp_config

    echo -e "$CSTART>>config_ntp_server$CEND"
    config_ntp_server

    echo -e "$CSTART>>config_ntp_clients$CEND"
    config_ntp_clients

    echo -e "$CSTART>>restart_ntp$CEND"
    restart_ntp
}

main
