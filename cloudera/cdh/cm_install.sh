#!/bin/bash
#cd /opt/CDH-6.3.1/scripts/cm_cdh
cd /opt/soft/cdh-bog/CDH-6.3.1/scripts/cm_cdh
# 安装cm-daemon
yum install -y rpm/cloudera-manager-daemons-6.3.1-1466458.el7.x86_64.rpm
# 安装cm-server
yum install -y rpm/cloudera-manager-server-6.3.1-1466458.el7.x86_64.rpm
rm -f /etc/cloudera-scm-server/db.properties
cp db.properties  /etc/cloudera-scm-server/db.properties
chmod 644 /etc/cloudera-scm-server/db.properties
systemctl status cloudera-scm-server
systemctl enable cloudera-scm-server
# 安装cm-agent
yum install -y rpm/cloudera-manager-agent-6.3.1-1466458.el7.x86_64.rpm
rm -f /etc/cloudera-scm-agent/config.ini
cp config.ini /etc/cloudera-scm-agent/config.ini
chmod 644 /etc/cloudera-scm-agent/config.ini
systemctl start cloudera-scm-agent
systemctl enable cloudera-scm-agent
#mv CDH-6.3.2-1.cdh6.3.2.p0.1605554-el7.parcel* /opt/cloudera/parcel-repo
mkdir /opt/cloudera/parcel-repo
cp  cdh6_parcel/*    /opt/cloudera/parcel-repo
yum install -y httpd
#mkdir -pv /var/www/html/cdh6_parcel
#cp /opt/cloudera/parcel-repo/* /var/www/html/cdh6_parcel
cp -a cdh6_parcel /var/www/html/
systemctl start httpd
systemctl enable httpd
