#!/bin/bash

#author: Sen Du
#email: dusen@gennlife.com
#created: 2023-04-16 16:00:00
#updated: 2023-04-16 16:00:00

set -e 
source 00_env.sh

# 安装 cloudera manager server
function install_server() {
    echo -e "$CSTART>>>>rpm -ivh http://$HTTPD_SERVER/cloudera/cm6/6.3.1/cloudera-manager-server-6.3.1-1466458.el7.x86_64.rpm || true$CEND"
    rpm -ivh http://$HTTPD_SERVER/cloudera/cm6/6.3.1/cloudera-manager-server-6.3.1-1466458.el7.x86_64.rpm || true
}

# 配置 cloudera manager server
function config_server() {
    echo -e "$CSTART>>>>cp /etc/cloudera-scm-server/db.properties /etc/cloudera-scm-server/db.properties.bak$CEND"
    cp /etc/cloudera-scm-server/db.properties /etc/cloudera-scm-server/db.properties.bak

    echo -e "$CSTART>>>>cp config/cm_server /etc/cloudera-scm-server/db.properties$CEND"
    cp config/cm_server /etc/cloudera-scm-server/db.properties

    echo -e "$CSTART>>>>chmod 644 /etc/cloudera-scm-server/db.properties$CEND"
    chmod 644 /etc/cloudera-scm-server/db.properties
}

# 重启 cloudera manager server
function restart_server() {
    echo -e "$CSTART>>>>systemctl restart cloudera-scm-server; systemctl enable cloudera-scm-server$CEND"
    systemctl restart cloudera-scm-server; systemctl enable cloudera-scm-server
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
