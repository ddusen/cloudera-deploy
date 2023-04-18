#!/bin/bash

#author: Sen Du
#email: dusen@gennlife.com
#created: 2023-04-16 15:00:00
#updated: 2023-04-16 15:00:00

set -e 
source 00_env

# 从httpd私有软件库，下载 mysql5.6
function download_mysql() {
    echo -e "$CSTART>>>>$(hostname -I)$CEND"
    wget -O /tmp/mysql5.6.tar.gz $HTTPD_SERVER/others/mysql5.6.tar.gz
}

# 安装 mysql5.6
function install_mysql() {
    echo -e "$CSTART>>>>$(hostname -I)$CEND"
    mkdir -p /tmp/mysql5.6/rpm
    tar -zxvf /tmp/mysql5.6.tar.gz -C /tmp/mysql5.6/rpm
    rpm -ivh /tmp/mysql5.6/rpm/*.rpm || true # 忽略报错
}

# 配置 mysql5.6
function config_mysql() {
    echo -e "$CSTART>>>>$(hostname -I)$CEND"
    cp /etc/my.cnf /etc/my.cnf.bak;
    cp config/my.cnf /etc/my.cnf;
}

# 重启 mysql
function restart_mysql() {
    echo -e "$CSTART>>>>$(hostname -I)$CEND"
    systemctl restart mysql;
    systemctl enable mysql;
    chkconfig mysql on
}

# 更新数据库，在 mysql 中创建用户，添加新用户和数据库
function update_database() {
    echo -e "$CSTART>>>>$(hostname -I)$CEND"
    default_passwd=$(cat /root/.mysql_secret |grep password|awk '{print $18}')
    mysql -uroot -p"${default_passwd}" --connect-expired-password -e "SET PASSWORD = PASSWORD('$MYSQL_ROOT_PASSWD');"
    sed -i "s/$default_passwd/$MYSQL_ROOT_PASSWD/" /root/.mysql_secret
    mysql -uroot -p"$MYSQL_ROOT_PASSWD" -e "SOURCE config/create_dbs.sql"
}

# 安装mysql插件：mysql-connector-java
function install_mysql_connector() {
    echo -e "$CSTART>>>>$(hostname -I)$CEND"
    mkdir -p /usr/share/java
    wget -O /tmp/mysql-connector-java-5.1.46.tar.gz $HTTPD_SERVER/others/mysql-connector-java-5.1.46.tar.gz
    tar -zxvf /tmp/mysql-connector-java-5.1.46.tar.gz -C /tmp/
    cp /tmp/mysql-connector-java-5.1.46/mysql-connector-java-5.1.46-bin.jar /usr/share/java/mysql-connector-java.jar
}

function main() {
    echo -e "$CSTART>07_mysql.sh$CEND"

    echo -e "$CSTART>>download_mysql$CEND"
    download_mysql

    echo -e "$CSTART>>install_mysql$CEND"
    install_mysql

    echo -e "$CSTART>>config_mysql$CEND"
    config_mysql

    echo -e "$CSTART>>restart_mysql$CEND"
    restart_mysql

    echo -e "$CSTART>>update_database$CEND"
    update_database

    echo -e "$CSTART>>install_mysql_connector$CEND"
    install_mysql_connector

}

main
