#!/bin/bash

#author: Sen Du
#email: dusen@gennlife.com
#created: 2023-04-16 14:00:00
#updated: 2023-04-16 14:00:00

set -e 

# 安装 cloudera manager agent
function install_agent() {
    for i in `cat config/all_nodes`
    do 
        ssh $i "yum install -y http://$HTTPD_SERVER/cloudera/cm6/6.3.1/cloudera-manager-daemons-6.3.1-1466458.el7.x86_64.rpm"
        ssh $i "yum install -y http://$HTTPD_SERVER/cloudera/cm6/6.3.1/cloudera-manager-agent-6.3.1-1466458.el7.x86_64.rpm"
    done
}

# 配置 cloudera manager agent
function config_agent() {
    for i in `cat config/all_nodes`
    do 
        ssh $i "cp /etc/cloudera-scm-agent/config.ini /etc/cloudera-scm-agent/config.ini.bak"
        scp config/cm_agent $i:/etc/cloudera-scm-agent/config.ini
        ssh $i "chmod 644 /etc/cloudera-scm-agent/config.ini"
    done
}

# 重启 cloudera manager agent
function restart_agent() {
    for i in `cat config/all_nodes`
    do 
        ssh $i "systemctl restart cloudera-scm-agent; systemctl enable cloudera-scm-agent"
    done
}

function main() {
    echo "08_cm_agent.sh"

    echo -e '$CSTART>>>>install_agent'
    install_agent

    echo -e '$CSTART>>>>config_agent'
    config_agent

    echo -e '$CSTART>>>>restart_agent'
    restart_agent
}

main
