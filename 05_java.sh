#!/bin/bash

#author: Sen Du
#email: dusen@gennlife.com
#created: 2023-04-16 14:00:00
#updated: 2023-04-16 14:00:00

set -e 
source 00_env

# 从httpd私有软件库，下载 jdk
function download_jdk() {
    echo -e "$CSTART>>>>$(hostname -I)$CEND"
    wget -O /tmp/jdk-8u202-linux-x64.tar.gz $HTTPD_SERVER/others/jdk-8u202-linux-x64.tar.gz
}

# 安装 jdk 到所有节点
function install_jdk() {
    cat config/vm_info | while read ipaddr name passwd
    do
        echo -e "$CSTART>>>>$ipaddr$CEND";
        scp -r /tmp/jdk-8u202-linux-x64.tar.gz $ipaddr:/tmp;
        ssh -n $ipaddr "tar -zxvf /tmp/jdk-8u202-linux-x64.tar.gz -C /opt/"
        scp -r config/jdk_profile  $ipaddr:/tmp/;
        ssh -n $ipaddr "sed -i '/JAVA_HOME/d' /etc/profile";
        ssh -n $ipaddr "cat /tmp/jdk_profile >> /etc/profile";
        ssh -n $ipaddr "source /etc/profile";
        ssh -n $ipaddr "mkdir -p /usr/java; ln -s /opt/jdk1.8.0_202 /usr/java/default" || true
    done
}

# 配置一些插件 jars
function config_jars() {
    cat config/vm_info | while read ipaddr name passwd
    do
        echo -e "$CSTART>>>>$ipaddr$CEND"
        ssh -n $ipaddr "mkdir -p /usr/share/java"
        ssh -n $ipaddr "wget -O /tmp/mysql-connector-java.jar.tar.gz $HTTPD_SERVER/others/mysql-connector-java.jar.tar.gz"
        ssh -n $ipaddr "tar -zxvf /tmp/mysql-connector-java.jar.tar.gz -C /usr/share/java"

        ssh -n $ipaddr "mkdir -p /usr/share/hive"
        ssh -n $ipaddr "wget -O /tmp/commons-httpclient-3.1.jar.tar.gz $HTTPD_SERVER/others/commons-httpclient-3.1.jar.tar.gz"
        ssh -n $ipaddr "wget -O /tmp/elasticsearch-hadoop-6.3.0.jar.tar.gz $HTTPD_SERVER/others/elasticsearch-hadoop-6.3.0.jar.tar.gz"
        ssh -n $ipaddr "tar -zxvf /tmp/commons-httpclient-3.1.jar.tar.gz -C /usr/share/hive"
        ssh -n $ipaddr "tar -zxvf /tmp/elasticsearch-hadoop-6.3.0.jar.tar.gz -C /usr/share/hive"
    done
}

function main() {
    echo -e "$CSTART>05_java.sh$CEND"

    echo -e "$CSTART>>download_jdk$CEND"
    download_jdk

    echo -e "$CSTART>>install_jdk$CEND"
    install_jdk
    
    echo -e "$CSTART>>config_jars$CEND"
    config_jars
}

main
