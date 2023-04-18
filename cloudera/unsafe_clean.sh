#!/bin/bash

#author: Sen Du
#email: dusen@gennlife.com
#created: 2023-04-18 15:00:00
#updated: 2023-04-18 15:00:00

set -e 
source 00_env

# 清理所有服务器上的 cloudera 服务
function clean() {
    cat config/vm_info | while read ipaddr name passwd
    do
        echo -e "$CSTART>>>>$ipaddr$CEND";
        ssh -n $ipaddr "systemctl stop cloudera*"
        ssh -n $ipaddr "yum remove -y cloudera*"
        ssh -n $ipaddr "rm -rf /opt/cloudera*"
        ssh -n $ipaddr "rm -rf /etc/cloudera*"
    done
}

function main() {
    clean
}

main
