#!/bin/bash
mkdir mysql5.6/rpm
tar -xf mysql5.6/rpm/MySQL-5.6.51-1.el7.x86_64.rpm-bundle.tar -C mysql5.6/rpm
yum install -y mysql5.6/rpm/*.rpm
mv /etc/my.cnf /etc/my.cnf_bak
cp my.cnf /etc/my.cnf
systemctl start mysql
systemctl enable mysql
my=$(cat /root/.mysql_secret  |grep password|awk '{print $18}') && mysql -uroot -p"${my}" --connect-expired-password -e "SET PASSWORD = PASSWORD('@GennLife2015');"
mysql -uroot -p"@GennLife2015" -e "source create_dbs.sql"
mkdir -p /usr/share/java
tar -xf mysql5.6/mysql-connector-java-5.1.46.tar.gz -C mysql5.6/
cp mysql5.6/mysql-connector-java-5.1.46/mysql-connector-java-5.1.46.jar /usr/share/java/mysql-connector-java.jar
