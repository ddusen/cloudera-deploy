#!/bin/bash

#author: Sen Du
#email: dusen@gennlife.com
#created: 2023-04-16 10:00:00
#updated: 2023-04-16 10:00:00

set -e 

FILENAME="cloudera.6.3.1466458.tar.gz"

# 下载 cm、cdh 相关的软件
function download_files() {
    # wget -P /opt http://xxx/cloudera.6.3.1466458.tar.gz 
    # 把 cloudera.6.3.1466458.tar.gz 复制到中控机的 /opt 目录
    scp ~/Downloads/$FILENAME root@10.0.5.224:/opt/
}

# 解压到指定目录
function unzip_files() {
    dist_dir="/var/www/html/cloudera"
    echo -e "\t\t mkdir -p $dist_dir && tar -zxvf /opt/$FILENAME -C $dist_dir"
    mkdir -p $dist_dir && tar -zxvf /opt/$FILENAME -C $dist_dir
}

# 安装 httpd：用作私有化 cm、cdh 的软件仓库
function install_httpd() {
    echo -e "\t\t yum install -y httpd"
    yum install -y httpd
}

# 启动 httpd
function start_httpd() {
    echo -e "\t\t systemctl stop firewalld; systemctl enable httpd; systemctl start httpd"
    systemctl stop firewalld
    systemctl enable httpd
    systemctl start httpd
}

function main() {
    echo "04_httpd.sh"
    echo -e "\t download_files"
    download_files

    echo -e "\t unzip_files"
    unzip_files

    echo -e "\t install_httpd"
    install_httpd

    echo -e "\t start_httpd"
    start_httpd
}

main
