#!/bin/bash

#author: Sen Du
#email: dusen@gennlife.com
#created: 2023-04-16 21:00:00
#updated: 2023-04-16 21:00:00

set -e 
source 00_env

function mount_iso() {
    cat config/vm_info | while read ipaddr name passwd
    do
        echo -e "$CSTART>>>>$ipaddr$CEND";
        scp /opt/iso.tar.gz $ipaddr:/opt/
        ssh -n $ipaddr "tar -zxvf /opt/iso.tar.gz -C /"
    done
}

function config_iso() {
    cat config/vm_info | while read ipaddr name passwd
    do
        echo -e "$CSTART>>>>$ipaddr$CEND";
        
        ssh -n $ipaddr "rm -rf /etc/yum.repos.d/*"
        scp config/iso $ipaddr:/etc/yum.repos.d/default.repo
    done
}

function main() {
    echo -e "$CSTART>reboot.sh$CEND"

    echo -e "$CSTART>>mount_iso$CEND"
    mount_iso

    echo -e "$CSTART>>config_iso$CEND"
    config_iso
}

main
