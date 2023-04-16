#!/bin/bash

#author: Sen Du
#email: dusen@gennlife.com
#created: 2023-04-16 15:00:00
#updated: 2023-04-16 15:00:00

set -e 

# 从httpd私有软件库，下载 mysql5.6
function download_mysql() {
    echo -e "\t\t wget -P /tmp http://$HTTPD_SERVER/cloudera/packages/mysql5.6.tar.gz"
    wget -P /tmp http://$HTTPD_SERVER/cloudera/packages/mysql5.6.tar.gz
}

# 安装 mysql5.6
function install_mysql() {
    echo -e '\t\t mkdir -p /tmp/mysql5.6/rpm && tar -zxvf /tmp/mysql5.6.tar.gz -C /tmp/mysql5.6/rpm && yum install -y /tmp/mysql5.6/rpm/*.rpm'
    mkdir -p /tmp/mysql5.6/rpm && tar -zxvf /tmp/mysql5.6.tar.gz -C /tmp/mysql5.6/rpm && yum install -y /tmp/mysql5.6/rpm/*.rpm
}

# 配置 mysql5.6
function config_mysql() {
    echo -e '\t\t cp /etc/my.cnf /etc/my.cnf.bak && cp config/my.cnf /etc/my.cnf'
    cp /etc/my.cnf /etc/my.cnf.bak && cp config/my.cnf /etc/my.cnf
}

# 重启 mysql
function restart_mysql() {
    echo -e '\t\t systemctl start mysql; systemctl enable mysql'
    systemctl start mysql; systemctl enable mysql;
}

# 更新数据库，在 mysql 中创建用户，添加新用户和数据库
function update_database() {
    default_passwd=$(cat /root/.mysql_secret |grep password|awk '{print $18}')
    mysql -uroot -p"${default_passwd}" --connect-expired-password -e "SET PASSWORD = PASSWORD('$MYSQL_ROOT_PASSWD');"
    mysql -uroot -p"$MYSQL_ROOT_PASSWD" -e "SOURCE create_dbs.sql"
}

# 安装mysql插件：mysql-connector-java
function install_mysql_connector() {
    mkdir -p /usr/share/java
    wget -P /tmp http://$HTTPD_SERVER/cloudera/packages/mysql-connector-java-5.1.46.jar.tar.gz
    tar -zxvf /tmp/mysql-connector-java-5.1.46.jar.tar.gz -C /usr/share/java/
}

function main() {
    echo "07_mysql.sh"

    echo -e "\t download_mysql"
    download_mysql

    echo -e "\t install_mysql"
    install_mysql

    echo -e "\t config_mysql"
    config_mysql

    echo -e "\t restart_mysql"
    restart_mysql

    echo -e "\t update_database"
    update_database

    echo -e "\t install_mysql_connector"
    install_mysql_connector

}

main
