#!/bin/bash

#author: Sen Du
#email: dusen@gennlife.com
#created: 2023-04-16 10:00:00
#updated: 2023-04-16 10:00:00

set -e 

# 安装一些基础软件，便于后续操作
function install_base() {
    echo -e '\t\t for i in `cat config/all_nodes`; do ssh $i "yum install -y wget net-tools epel-release htop"; done'
    for i in `cat config/all_nodes`; do ssh $i "yum install -y wget net-tools epel-release htop"; done
}

# 备份一些配置文件
function backup_configs(){
    echo -e '\t\t for i in `cat config/all_nodes`; do ssh $i `mkdir -p /opt/backup_sys_configs;`; done'
    for i in `cat config/all_nodes`; do ssh $i `mkdir -p /opt/backup_sys_configs;`; done

    echo -e '\t\t for i in `cat config/all_nodes`; do ssh $i `cp /etc/security/limits.conf /opt/backup_sys_configs;`; done'
    for i in `cat config/all_nodes`; do ssh $i `cp /etc/security/limits.conf /opt/backup_sys_configs;`; done

    echo -e '\t\t for i in `cat config/all_nodes`; do ssh $i `cp /etc/security/limits.d/20-nproc.conf /opt/backup_sys_configs;`; done'
    for i in `cat config/all_nodes`; do ssh $i `cp /etc/security/limits.d/20-nproc.conf /opt/backup_sys_configs;`; done

    echo -e '\t\t for i in `cat config/all_nodes`; do ssh $i `cp /etc/sysctl.conf /opt/backup_sys_configs;`; done'
    for i in `cat config/all_nodes`; do ssh $i `cp /etc/sysctl.conf /opt/backup_sys_configs;`; done

    echo -e '\t\t for i in `cat config/all_nodes`; do ssh $i `cp /etc/ssh/sshd_config /opt/backup_sys_configs`; done'
    for i in `cat config/all_nodes`; do ssh $i `cp /etc/ssh/sshd_config /opt/backup_sys_configs`; done
}

# 禁用 hugepage
function disable_hugepage(){
    echo -e '\t\t for i in `cat config/all_nodes`; do ssh $i `grubby --update-kernel=ALL --args="transparent_hugepage=never"`; done'
    for i in `cat config/all_nodes`; do ssh $i `grubby --update-kernel=ALL --args="transparent_hugepage=never"`; done

    echo -e '\t\t for i in `cat config/all_nodes`; do ssh $i `sed -i "/^#RemoveIPC=no/cRemoveIPC=no" /etc/systemd/logind.conf; systemctl restart systemd-logind.service`; done'
	for i in `cat config/all_nodes`; do ssh $i `sed -i "/^#RemoveIPC=no/cRemoveIPC=no" /etc/systemd/logind.conf; systemctl restart systemd-logind.service`; done
}

# 关闭 selinux
function disable_selinux(){
	echo -e '\t\t for i in `cat config/all_nodes`; do ssh $i `sed -i "/^SELINUX=/cSELINUX=disabled" /etc/selinux/config;`; done'
    for i in `cat config/all_nodes`; do ssh $i `sed -i "/^SELINUX=/cSELINUX=disabled" /etc/selinux/config;`; done
}

# 配置ssh
function config_ssh(){
	echo -e '\t\t for i in `cat config/all_nodes`; do ssh $i `sed -i "/^#UseDNS/cUseDNS no" /etc/ssh/sshd_config;`; done'
    for i in `cat config/all_nodes`; do ssh $i `sed -i "/^#UseDNS/cUseDNS no" /etc/ssh/sshd_config;`; done

	echo -e '\t\t for i in `cat config/all_nodes`; do ssh $i `sed -i "/^GSSAPIAuthentication/cGSSAPIAuthentication no" /etc/ssh/sshd_config;`; done'
    for i in `cat config/all_nodes`; do ssh $i `sed -i "/^GSSAPIAuthentication/cGSSAPIAuthentication no" /etc/ssh/sshd_config;`; done

	echo -e '\t\t for i in `cat config/all_nodes`; do ssh $i `sed -i "/^GSSAPICleanupCredentials/cGSSAPICleanupCredentials no" /etc/ssh/sshd_config;`; done'
    for i in `cat config/all_nodes`; do ssh $i `sed -i "/^GSSAPICleanupCredentials/cGSSAPICleanupCredentials no" /etc/ssh/sshd_config;`; done

	echo -e '\t\t for i in `cat config/all_nodes`; do ssh $i `sed -i "/^#MaxStartups/cMaxStartups 10000:30:20000" /etc/ssh/sshd_config;`; done'
    for i in `cat config/all_nodes`; do ssh $i `sed -i "/^#MaxStartups/cMaxStartups 10000:30:20000" /etc/ssh/sshd_config;`; done
}

# 配置网络策略
function config_network(){
	echo -e '\t\t for i in `cat config/all_nodes`; do ssh $i `chkconfig iptables off; chkconfig ip6tables off; chkconfig postfix off;`; done'
    for i in `cat config/all_nodes`; do ssh $i `chkconfig iptables off; chkconfig ip6tables off; chkconfig postfix off;`; done

	echo -e '\t\t for i in `cat config/all_nodes`; do ssh $i `systemctl disable postfix; systemctl disable libvirtd; systemctl disable firewalld;`; done'
    for i in `cat config/all_nodes`; do ssh $i `systemctl disable postfix; systemctl disable libvirtd; systemctl disable firewalld;`; done
}

function main() {
    echo '03_init.sh'
    echo -e '\t install_base'
    install_base

    echo -e '\t backup_configs'
    backup_configs

    echo -e '\t disable_hugepage'
    disable_hugepage

    echo -e '\t disable_selinux'
    disable_selinux

    echo -e '\t config_ssh'
    config_ssh

    echo -e '\t config_network'
    config_network
}

main
