#!/bin/bash

#author: Sen Du
#email: dusen@gennlife.com
#created: 2023-04-16 11:00:00
#updated: 2023-04-16 11:00:00

set -e 

# 配置所有节点的 hosts
function config_hosts() {
    echo -e "$CSTART>>>>for i in `cat config/all_nodes`; do scp config/hosts \$i:/etc/ done$CEND"
    for i in `cat config/all_nodes`; do scp config/hosts $i:/etc/ ; done
}

# 配置所有节点的 hostname
function config_hostname() {
    echo -e "$CSTART>>>>cat config/hostnames | while read ipaddr hostname; do ssh $ipaddr `echo "hostname=$hostname" >> /etc/sysconfig/network`; done$CEND"
    cat config/hostnames | while read ipaddr hostname; do ssh $ipaddr `echo "hostname=$hostname" >> /etc/sysconfig/network`; done
}

function main() {
    echo -e "$CSTART>02_hosts.sh$CEND"
    echo -e "$CSTART>>config_hosts$CEND"
    config_hosts

    echo -e "$CSTAET>>config_hostname$CEND"
    config_hostname
}

main
