#!/bin/bash
cd /opt/CDH-6.3.1/scripts/cm_cdh
# 安装cm-daemon
yum install -y rpm/cloudera-manager-daemons-6.3.1-1466458.el7.x86_64.rpm
# 安装cm-agent
yum install -y rpm/cloudera-manager-agent-6.3.1-1466458.el7.x86_64.rpm
cp config.ini /etc/cloudera-scm-agent/config.ini
chmod 644 /etc/cloudera-scm-agent/config.ini
systemctl start cloudera-scm-agent
systemctl enable cloudera-scm-agent
