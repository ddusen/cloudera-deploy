#!/bin/bash

#author: Sen Du
#email: dusen@gennlife.com
#created: 2023-04-16 21:00:00
#updated: 2023-04-16 21:00:00

set -e 

# 重启机器
function reboot() {
    echo -e "$CSTART>>>>cat config/vm_info | while read ipaddr name passwd; do echo $ipaddr; ssh -n $ipaddr "reboot"; done$CEND"
    cat config/vm_info | while read ipaddr name passwd; do echo $ipaddr; ssh -n $ipaddr "reboot || true"; done
}

function main() {
    reboot
}

main
