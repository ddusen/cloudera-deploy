#!/bin/bash

#author: Sen Du
#email: dusen@gennlife.com
#created: 2023-04-16 16:00:00
#updated: 2023-04-16 16:00:00

set -e 
source 00_env

# 安装 cloudera manager server
function install_server() {
    echo -e "$CSTART>>>>$(hostname -I)$CEND"
    rpm -ivh $HTTPD_SERVER/cm6/6.3.1/cloudera-manager-server-6.3.1-1466458.el7.x86_64.rpm || true
}

# 配置 cloudera manager server
function config_server() {
    echo -e "$CSTART>>>>$(hostname -I)$CEND"
    cp /etc/cloudera-scm-server/db.properties /etc/cloudera-scm-server/db.properties.bak
    cp config/cm_server /etc/cloudera-scm-server/db.properties
    chmod 644 /etc/cloudera-scm-server/db.properties
}

# 重启 cloudera manager server
function restart_server() {
    echo -e "$CSTART>>>>$(hostname -I)$CEND"
    systemctl restart cloudera-scm-server; 
    systemctl enable cloudera-scm-server;
    chkconfig cloudera-scm-server on
}

function main() {
    echo -e "$CSTART>09_cm_server.sh$CEND"

    echo -e "$CSTART>>install_server$CEND"
    install_server

    echo -e "$CSTART>>config_server$CEND"
    config_server

    echo -e "$CSTART>>restart_server$CEND"
    restart_server
}

main
