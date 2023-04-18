#!/bin/bash

#author: Sen Du
#email: dusen@gennlife.com
#created: 2023-04-16 10:00:00
#updated: 2023-04-16 10:00:00

set -e 
source 00_env.sh

# 安装一些基础软件，便于后续操作
function install_base() {
    echo -e "$CSTART>>>>cat config/vm_info | while read ipaddr name passwd; do ssh -n \$ipaddr \"yum install -y wget net-tools epel-release htop\"; done$CEND"
    cat config/vm_info | while read ipaddr name passwd; do ssh -n $ipaddr "yum install -y wget net-tools epel-release htop"; done
}

# 备份一些配置文件
function backup_configs(){
    echo -e "$CSTART>>>>cat config/vm_info | while read ipaddr name passwd; do ssh -n \$ipaddr \"mkdir -p /opt/backup_sys_configs;\"; done$CEND"
    cat config/vm_info | while read ipaddr name passwd; do ssh -n $ipaddr "mkdir -p /opt/backup_sys_configs;"; done

    echo -e "$CSTART>>>>cat config/vm_info | while read ipaddr name passwd; do ssh -n \$ipaddr \"cp /etc/security/limits.conf /opt/backup_sys_configs;\"; done$CEND"
    cat config/vm_info | while read ipaddr name passwd; do ssh -n $ipaddr "cp /etc/security/limits.conf /opt/backup_sys_configs;"; done

    echo -e "$CSTART>>>>cat config/vm_info | while read ipaddr name passwd; do ssh -n \$ipaddr \"cp /etc/security/limits.d/20-nproc.conf /opt/backup_sys_configs;\"; done$CEND"
    cat config/vm_info | while read ipaddr name passwd; do ssh -n $ipaddr "cp /etc/security/limits.d/20-nproc.conf /opt/backup_sys_configs;"; done

    echo -e "$CSTART>>>>cat config/vm_info | while read ipaddr name passwd; do ssh -n \$ipaddr \"cp /etc/sysctl.conf /opt/backup_sys_configs;\"; done$CEND"
    cat config/vm_info | while read ipaddr name passwd; do ssh -n $ipaddr "cp /etc/sysctl.conf /opt/backup_sys_configs;"; done

    echo -e "$CSTART>>>>cat config/vm_info | while read ipaddr name passwd; do ssh -n \$ipaddr \"cp /etc/ssh/sshd_config /opt/backup_sys_configs\"; done$CEND"
    cat config/vm_info | while read ipaddr name passwd; do ssh -n $ipaddr "cp /etc/ssh/sshd_config /opt/backup_sys_configs"; done
}

# 禁用 hugepage
function disable_hugepage(){
    echo -e "$CSTART>>>>cat config/vm_info | while read ipaddr name passwd; do ssh -n \$ipaddr \"grubby --update-kernel=ALL --args='transparent_hugepage=never'\"; done$CEND"
    cat config/vm_info | while read ipaddr name passwd; do ssh -n $ipaddr "grubby --update-kernel=ALL --args='transparent_hugepage=never'"; done

    echo -e "$CSTART>>>>cat config/vm_info | while read ipaddr name passwd; do ssh -n \$ipaddr \"sed -i '/^#RemoveIPC=no/cRemoveIPC=no' /etc/systemd/logind.conf; systemctl restart systemd-logind.service\"; done$CEND"
	cat config/vm_info | while read ipaddr name passwd; do ssh -n $ipaddr "sed -i '/^#RemoveIPC=no/cRemoveIPC=no' /etc/systemd/logind.conf; systemctl restart systemd-logind.service"; done
}

# 关闭 selinux
function disable_selinux(){
	echo -e "$CSTART>>>>cat config/vm_info | while read ipaddr name passwd; do ssh -n \$ipaddr \"sed -i '/^SELINUX=/cSELINUX=disabled\" /etc/selinux/config;\"; done$CEND"
    cat config/vm_info | while read ipaddr name passwd; do ssh -n $ipaddr "sed -i '/^SELINUX=/cSELINUX=disabled' /etc/selinux/config;"; done
}

# 配置ssh
function config_ssh(){
	echo -e "$CSTART>>>>cat config/vm_info | while read ipaddr name passwd; do ssh -n \$ipaddr \"sed -i '/^#UseDNS/cUseDNS no' /etc/ssh/sshd_config;\"; done$CEND"
    cat config/vm_info | while read ipaddr name passwd; do ssh -n $ipaddr "sed -i '/^#UseDNS/cUseDNS no' /etc/ssh/sshd_config;"; done

	echo -e "$CSTART>>>>cat config/vm_info | while read ipaddr name passwd; do ssh -n \$ipaddr \"sed -i '/^GSSAPIAuthentication/cGSSAPIAuthentication no' /etc/ssh/sshd_config;\"; done$CEND"
    cat config/vm_info | while read ipaddr name passwd; do ssh -n $ipaddr "sed -i '/^GSSAPIAuthentication/cGSSAPIAuthentication no' /etc/ssh/sshd_config;"; done

	echo -e "$CSTART>>>>cat config/vm_info | while read ipaddr name passwd; do ssh -n \$ipaddr \"sed -i '/^GSSAPICleanupCredentials/cGSSAPICleanupCredentials no' /etc/ssh/sshd_config;\"; done$CEND"
    cat config/vm_info | while read ipaddr name passwd; do ssh -n $ipaddr "sed -i '/^GSSAPICleanupCredentials/cGSSAPICleanupCredentials no' /etc/ssh/sshd_config;"; done

	echo -e "$CSTART>>>>cat config/vm_info | while read ipaddr name passwd; do ssh -n \$ipaddr \"sed -i '/^#MaxStartups/cMaxStartups 10000:30:20000\" /etc/ssh/sshd_config;\"; done$CEND"
    cat config/vm_info | while read ipaddr name passwd; do ssh -n $ipaddr "sed -i '/^#MaxStartups/cMaxStartups 10000:30:20000' /etc/ssh/sshd_config;"; done
}

# 配置网络策略
function config_network(){
	echo -e "$CSTART>>>>cat config/vm_info | while read ipaddr name passwd; do ssh -n \$ipaddr \"chkconfig iptables off; chkconfig ip6tables off; chkconfig postfix off;\"; done$CEND"
    cat config/vm_info | while read ipaddr name passwd; do ssh -n $ipaddr "chkconfig iptables off; chkconfig ip6tables off; chkconfig postfix off;"; done

	echo -e "$CSTART>>>>cat config/vm_info | while read ipaddr name passwd; do ssh -n \$ipaddr \"systemctl disable postfix; systemctl disable libvirtd; systemctl disable firewalld;\"; done$CEND"
    cat config/vm_info | while read ipaddr name passwd; do ssh -n $ipaddr "systemctl disable postfix; systemctl disable libvirtd; systemctl disable firewalld;"; done
}

function main() {
    echo -e "$CSTART>03_init.sh$CEND"

    echo -e "$CSTART>>install_base$CEND"
    install_base

    echo -e "$CSTART>>backup_configs$CEND"
    backup_configs

    echo -e "$CSTART>>disable_hugepage$CEND"
    disable_hugepage

    echo -e "$CSTART>>disable_selinux$CEND"
    disable_selinux

    echo -e "$CSTART>>config_ssh$CEND"
    config_ssh

    echo -e "$CSTART>>config_network$CEND"
    config_network
}

main
