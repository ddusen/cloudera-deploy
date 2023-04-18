#!/bin/bash

#author: Sen Du
#email: dusen@gennlife.com
#created: 2023-04-16 14:00:00
#updated: 2023-04-16 14:00:00

set -e 
source 00_env.sh

# 安装 cloudera manager agent 依赖
function install_dependent() {
    cat config/vm_info | while read ipaddr name passwd
    do 
        echo -e "$CSTART>>>>$ipaddr$CEND";
        ssh -n $ipaddr "yum install -y bind-utils psmisc cyrus-sasl-plain cyrus-sasl-gssapi fuse portmap fuse-libs /lib/lsb/init-functions httpd mod_ssl openssl-devel python-psycopg2 MySQL-python libxslt || true";
    done
}

# 安装 cloudera manager agent
function install_agent() {
    cat config/vm_info | while read ipaddr name passwd
    do 
        echo -e "$CSTART>>>>$ipaddr$CEND";
        ssh -n $ipaddr "rpm -ivh http://$HTTPD_SERVER/cloudera/cm6/6.3.1/cloudera-manager-daemons-6.3.1-1466458.el7.x86_64.rpm || true";
        ssh -n $ipaddr "rpm -ivh http://$HTTPD_SERVER/cloudera/cm6/6.3.1/cloudera-manager-agent-6.3.1-1466458.el7.x86_64.rpm || true";
    done
}

# 配置 cloudera manager agent
function config_agent() {
    cat config/vm_info | while read ipaddr name passwd
    do 
        echo -e "$CSTART>>>>$ipaddr$CEND";
        ssh -n $ipaddr "cp /etc/cloudera-scm-agent/config.ini /etc/cloudera-scm-agent/config.ini.bak"
        scp config/cm_agent $ipaddr:/etc/cloudera-scm-agent/config.ini
        ssh -n $ipaddr "chmod 644 /etc/cloudera-scm-agent/config.ini"
    done
}

# 重启 cloudera manager agent
function restart_agent() {
    cat config/vm_info | while read ipaddr name passwd
    do 
        echo -e "$CSTART>>>>$ipaddr$CEND";
        ssh -n $ipaddr "systemctl restart cloudera-scm-agent; systemctl enable cloudera-scm-agent"
    done
}

function main() {
    echo -e "$CSTART>08_cm_agent.sh$CEND"

    echo -e "$CSTART>>>>install_dependent$CEND"
    install_dependent

    echo -e "$CSTART>>>>install_agent$CEND"
    install_agent

    echo -e "$CSTART>>>>config_agent$CEND"
    config_agent

    echo -e "$CSTART>>>>restart_agent$CEND"
    restart_agent
}

main
