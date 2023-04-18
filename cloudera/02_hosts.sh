#!/bin/bash

#author: Sen Du
#email: dusen@gennlife.com
#created: 2023-04-16 11:00:00
#updated: 2023-04-16 11:00:00

set -e 
source 00_env.sh

# 配置所有节点的 hosts
function config_hosts() {
    echo -e "$CSTART>>>>cat config/vm_info | while read ipaddr name passwd; do scp config/hosts \$ipaddr:/etc/; done$CEND"
    cat config/vm_info | while read ipaddr name passwd; do scp config/hosts $ipaddr:/etc/; done
}

# 配置所有节点的 hostname
function config_hostname() {
    echo -e "$CSTART>>>>cat config/vm_info | while read ipaddr name passwd; do ssh -n \$ipaddr \"echo \"hostname=\$hostname\" >> /etc/sysconfig/network\"; done$CEND"
    cat config/vm_info | while read ipaddr name passwd; do ssh -n $ipaddr "echo 'hostname=$name' > /etc/sysconfig/network"; done
}

function main() {
    echo -e "$CSTART>02_hosts.sh$CEND"
    echo -e "$CSTART>>config_hosts$CEND"
    config_hosts

    echo -e "$CSTART>>config_hostname$CEND"
    config_hostname
}

main
