#!/bin/bash

#author: Sen Du
#email: dusen@gennlife.com
#created: 2023-04-16 16:00:00
#updated: 2023-04-16 16:00:00

set -e 

# 安装 cloudera manager server
function install_server() {
    for i in `cat config/all_nodes`
    do 
        ssh $i "yum install -y http://$HTTPD_SERVER/cloudera/cm6/6.3.1/cloudera-manager-server-6.3.1-1466458.el7.x86_64.rpm"
    done
}

# 配置 cloudera manager server
function config_server() {
    for i in `cat config/all_nodes`
    do 
        ssh $i "cp /etc/cloudera-scm-server/db.properties /etc/cloudera-scm-server/db.properties.bak"
        scp config/cm_server $i:/etc/cloudera-scm-server/db.properties
        ssh $i "chmod 644 /etc/cloudera-scm-server/config.ini"
    done
}

# 重启 cloudera manager server
function restart_server() {
    for i in `cat config/all_nodes`
    do 
        ssh $i "systemctl restart cloudera-scm-server; systemctl enable cloudera-scm-server"
    done
}

function main() {
    echo -e "$CSTART>09_cm_server.sh$CEND"

    echo -e "$CSTART>>>>install_server$CEND"
    install_server

    echo -e "$CSTART>>>>config_server$CEND"
    config_server

    echo -e "$CSTART>>>>restart_server$CEND"
    restart_server
}

main
