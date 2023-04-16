#!/bin/bash

#author: Sen Du
#email: dusen@gennlife.com
#created: 2023-04-16 14:00:00
#updated: 2023-04-16 14:00:00

set -e 

HTTPD_SERVER='10.0.5.224'

# 从httpd私有软件库，下载 jdk
function download_jdk() {
    echo -e "\t\t wget -P /tmp http://$HTTPD_SERVER/cloudera/packages/jdk-8u202-linux-x64.tar.gz"
    wget -P /tmp http://$HTTPD_SERVER/cloudera/packages/jdk-8u202-linux-x64.tar.gz
}

# 安装 jdk 到 cm 机器
function install_jdk() {
    tar -xf /tmp/jdk-8u202-linux-x64.tar.gz -C /opt/
    cat >> /etc/profile << EOF
export JAVA_HOME=/opt/jdk1.8.0_202
export PATH=\$JAVA_HOME/bin:\$PATH
export CLASSPATH=.:\$JAVA_HOME/lib/dt.jar:\$JAVA_HOME/lib/tools.jar
EOF
    source /etc/profile;
    mkdir /usr/java;
    ln -s /opt/jdk1.8.0_202 /usr/java/default
}

function main() {
    echo "05_java.sh"
    echo -e "\t download_jdk"
    download_jdk

    echo -e "\t install_jdk"
    install_jdk
}