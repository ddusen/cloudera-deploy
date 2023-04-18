#!/bin/bash

#author: Sen Du
#email: dusen@gennlife.com
#created: 2023-04-18 15:00:00
#updated: 2023-04-18 15:00:00

set -e 
source 00_env

# 清理 java 服务
function clean_java() {
    cat config/vm_info | while read ipaddr name passwd
    do
        echo -e "$CSTART>>>>$ipaddr$CEND";
        ssh -n $ipaddr "unlink /usr/java/default";
        ssh -n $ipaddr "sed -i '/JAVA_HOME/d' /etc/profile";
        ssh -n $ipaddr "rm -rf /opt/jdk1.8.0_202";
    done
}

# 清理 mysql 服务
function clean_mysql() {
    echo -e "$CSTART>>>>$(hostname -I)$CEND"
    systemctl stop mysql*
    yum remove -y mysql*
    yum remove -y MySQL*
}

# 清理所有服务器上的 cloudera 服务
function clean_cloudera() {
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
    echo -e "$CSTART>unsafe_clean.sh$CEND"
    echo -e "$CSTART>>clean_java$CEND"
    clean_java || true

    echo -e "$CSTART>>clean_mysql$CEND"
    clean_mysql || true

    echo -e "$CSTART>>clean_cloudera$CEND"
    clean_cloudera || true
}

main
