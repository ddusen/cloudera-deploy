#!/bin/bash

#author: Sen Du
#email: dusen@gennlife.com
#created: 2023-04-23 12:00:00
#updated: 2023-04-23 12:00:00

# 检查机器配置性能

set -e 
source 00_env

function check_cpu() {
    cat config/vm_info | while read ipaddr name passwd
    do
        echo -e "$CSTART>>>>$ipaddr$CEND";
        ssh -n $ipaddr "lscpu | grep CPU\(s\)"
    done
}

function check_mem() {
    cat config/vm_info | while read ipaddr name passwd
    do
        echo -e "$CSTART>>>>$ipaddr$CEND";
        ssh -n $ipaddr "free -h"
    done
}

function check_disk() {
    cat config/vm_info | while read ipaddr name passwd
    do
        echo -e "$CSTART>>>>$ipaddr$CEND";
        ssh -n $ipaddr "lsblk"
    done
}

function main() {
    echo -e "$CSTART>reboot.sh$CEND"

    echo -e "$CSTART>>check_cpu$CEND"
    check_cpu > check_cpu.log 2>&1
    
    echo -e "$CSTART>>check_mem$CEND"
    check_mem > check_mem.log 2>&1
    
    echo -e "$CSTART>>check_disk$CEND"
    check_disk > check_disk.log 2>&1
}

main
