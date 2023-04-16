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

function main() {
    echo '02_hosts.sh'
    
    echo -e '\t config_hosts'
    config_hosts
}

main
