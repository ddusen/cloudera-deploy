#!/bin/bash

#author: Sen Du
#email: dusen@gennlife.com
#created: 2023-04-16 19:00:00
#updated: 2023-04-16 19:00:00

set -e 

# 以下为安装 Cloudera 所需的环境变量
## 控制日志颜色：灰色
export CSTART='\033[37m'
export CEND='\033[0m'

## 文件名称
export FILENAME="cloudera.6.3.1466458.tar.gz"

## 中控机 IP
export CCC='10.0.5.224'

## httpd server ip
export HTTPD_SERVER='10.0.5.224'

## MySQL
export MYSQL_ROOT_PASSWD='@GennLife2015'
