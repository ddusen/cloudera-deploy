#!/bin/bash

#author: Sen Du
#email: dusen@gennlife.com
#created: 2023-04-16 11:00:00
#updated: 2023-04-16 11:00:00

set -e 

# 配置所有节点的 hosts
function config_hosts() {
    echo -e '\t\t for i in `cat config/all_nodes`; do scp config/hosts $i:/etc/ done'
    for i in `cat config/all_nodes`; do scp config/hosts $i:/etc/ ; done
}

# 配置所有节点的 hostname
function config_hostname() {
    echo -e '\t\t cat config/hostnames | while read ipaddr hostname; do ssh $ipaddr `echo "hostname=$hostname"`; done'
    cat config/hostnames | while read ipaddr hostname; do ssh $ipaddr `echo "hostname=$hostname"`; done
}

function main() {
    echo '02_hosts.sh'

    echo -e '\t config_hosts'
    config_hosts

    echo -e '\t config_hostname'
    config_hostname
}

main
