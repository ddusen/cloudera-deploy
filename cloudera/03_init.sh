#!/bin/bash

#author: Sen Du
#email: dusen@gennlife.com
#created: 2023-04-16 10:00:00
#updated: 2023-04-16 10:00:00

set -e 

# 安装一些基础软件，便于后续操作
function install_base() {
    echo -e '\t\t for i in `cat all_nodes`; do ssh $i "yum install -y wget net-tools epel-release htop"; done'
    for i in `cat all_nodes`; do ssh $i "yum install -y wget net-tools epel-release htop"; done
}

function main() {
    echo '03_init.sh'
}

main
