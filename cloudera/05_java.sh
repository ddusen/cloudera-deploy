#!/bin/bash

#author: Sen Du
#email: dusen@gennlife.com
#created: 2023-04-16 14:00:00
#updated: 2023-04-16 14:00:00

set -e 

# 从httpd私有软件库，下载 jdk
function download_jdk() {
    echo -e "$CSTART>>>>wget -O /tmp/jdk-8u202-linux-x64.tar.gz http://$HTTPD_SERVER/cloudera/packages/jdk-8u202-linux-x64.tar.gz$CEND"
    wget -O /tmp/jdk-8u202-linux-x64.tar.gz http://$HTTPD_SERVER/cloudera/packages/jdk-8u202-linux-x64.tar.gz
}

# 安装 jdk 到所有节点
function install_jdk() {
    tar -xf /tmp/jdk-8u202-linux-x64.tar.gz -C /opt/

    cat config/vm_info | while read ipaddr name passwd
    do
        scp -r /opt/jdk1.8.0_202  $ipaddr:/opt
        scp -r config/jdk_profile  $ipaddr:/tmp/
        ssh $ipaddr "sed -i '/JAVA_HOME/d' /etc/profile"
        ssh $ipaddr "cat /tmp/jdk_profile >> /etc/profile"
        ssh $ipaddr "source /etc/profile"
        ssh $ipaddr "mkdir /usr/java; ln -s /opt/jdk1.8.0_202 /usr/java/default"
    done
}

function main() {
    echo -e "$CSTART>05_java.sh$CEND"

    echo -e "$CSTART>>download_jdk$CEND"
    download_jdk

    echo -e "$CSTART>>install_jdk$CEND"
    install_jdk
}

main
