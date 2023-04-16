#!/bin/bash

#author: Sen Du
#email: dusen@gennlife.com
#created: 2023-04-16 14:00:00
#updated: 2023-04-16 14:00:00

set -e 


# 移除旧版本 ntp
function remove_old_ntp() {
    echo -e '\t\t yum remove -y chrony ntp'
    yum remove -y chrony ntp
}

# 安装 ntp
function install_ntp() {
    echo -e '\t\t for i in `cat config/all_nodes`; do ssh $i `yum install -y ntp`; done'
    for i in `cat config/all_nodes`; do ssh $i `yum install -y ntp`; done
}

# 备份 ntp config
function backup_ntp_config() {
    echo -e '\t\t for i in `cat config/all_nodes`; do ssh $i `cp /etc/ntp.conf /etc/ntp.conf.bak`; done'
    for i in `cat config/all_nodes`; do ssh $i `cp /etc/ntp.conf /etc/ntp.conf.bak`; done
}

# 配置 ntp server
function config_ntp_server() {
    echo -e '\t\t cp config/ntp_server /etc/ntp.conf'
    cp config/ntp_server /etc/ntp.conf
}

# 配置 ntp clients
function config_ntp_clients() {
    echo -e '\t\t for i in `cat config/all_nodes`; do scp config/ntp_clients $i:/etc/ntp.conf; done'
    for i in `cat config/all_nodes`; do scp config/ntp_clients $i:/etc/ntp.conf; done
}

# 重启 ntp 服务
function restart_ntp() {
    echo -e '\t\t for i in `cat config/all_nodes`; do ssh $i `systemctl restart ntpd; systemctl enable ntpd; timedatectl set-ntp true`; done'
    for i in `cat config/all_nodes`; do ssh $i `systemctl restart ntpd; systemctl enable ntpd; timedatectl set-ntp true`; done
}

function main() {
    echo "06_ntp.sh"

    echo -e "\t remove_old_ntp"
    remove_old_ntp

    echo -e "\t install_ntp"
    install_ntp

    echo -e "\t backup_ntp_config"
    backup_ntp_config

    echo -e "\t config_ntp_server"
    config_ntp_server

    echo -e "\t config_ntp_clients"
    config_ntp_clients

    echo -e "\t restart_ntp"
    restart_ntp
}