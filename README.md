# CDH 离线安装部署

先在一台机器安装 CM，然后通过 CM Web界面安装 CDH。

- CM 版本：6.3.1
- CDH 版本：6.3.2
- MySQL 版本：5.6
- Java 版本：1.8
- 系统版本：Centos 7.9

*****

## 前提

1. 从公司云盘下载软件包 cloudera-parcels.6.3.1466458.tar.gz 到脚本执行机器中。
- http://119.254.145.21:12225/owncloud/index.php/s/WIRsdWWQgnB1jHa
- 如果网盘链接失效，去网盘目录下找该包：03-大数据/01-CDH/cloudera-parcels.6.3.1466458.tar.gz

> 备用网盘：https://www.aliyundrive.com/s/nLvmmaDd3fA

2. 把压缩包解压到 /var/www/html 目录下
```bash
tar -zxvf cloudera-parcels.6.3.1466458.tar.gz -C /var/www/html/
```

## 一、CM 安装

### 0. 配置环境变量
- 需要手动补充该文件中的配置项
- [./00_env](./00_env)

### 1. 配置集群间ssh免密
- 需要修改 `config/vm_info` 文件
- [./01_sshpass.sh](./01_sshpass.sh)

### 2. 配置所有节点的 hosts
- 需要修改 `config/hosts`、`config/all_nodes` 文件
- [./02_hosts.sh](./02_hosts.sh)

### 3. 初始化系统环境
- [./03_init.sh](./03_init.sh)

### 4. 安装 httpd
- [./04_httpd.sh](./04_httpd.sh)

### 5. 安装 java
- [./05_java.sh](./05_java.sh)

### 6. 安装 ntp
- 需要修改 `config/ntp_clients` 中的 ntp server ip `10.0.5.224`
- [./06_ntp.sh](./06_ntp.sh)

### 7. 安装 mysql
- [./07_mysql.sh](./07_mysql.sh)

### 8. 安装 cloudera manager agent
- 需要 `config/cm_agent` 中的 `server_host` 变量
- [./08_cm_agent.sh](./08_cm_agent.sh)

### 9. 安装 cloudera manager server
- 需要 `config/cm_server` 中的 `*.host` 变量
- [./09_cm_server.sh](./09_cm_server.sh)

*****

## 二、CDH 安装

### 1. 许可证选择
- [cdh-01](./images/cdh-01.png)

### 2. 主机选择
