#!/bin/bash

#author: Sen Du
#email: dusen@gennlife.com
#created: 2023-04-16 14:00:00
#updated: 2023-04-16 14:00:00

set -e 

# 从httpd私有软件库，下载 jdk
function download_jdk() {
    echo -e "\t\t wget -P /tmp http://$HTTPD_SERVER/cloudera/packages/jdk-8u202-linux-x64.tar.gz"
    wget -P /tmp http://$HTTPD_SERVER/cloudera/packages/jdk-8u202-linux-x64.tar.gz
}

# 安装 jdk 到所有节点
function install_jdk() {
    tar -xf /tmp/jdk-8u202-linux-x64.tar.gz -C /opt/

    for i in `cat config/all_nodes`
    do
        scp -r /opt/jdk1.8.0_202  $i:/opt
        scp -r /config/jdk_profile  $i:/tmp/
        ssh $i "cat /tmp/jdk_profile >> /etc/profile"
        ssh $i "source /etc/profile"
        ssh $i "mkdir /usr/java && ln -s /opt/jdk1.8.0_202 /usr/java/default"
    done
}

function main() {
    echo "05_java.sh"
    echo -e "\t download_jdk"
    download_jdk

    echo -e "\t install_jdk"
    install_jdk
}

main
