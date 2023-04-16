# CDH 离线安装部署

先在一台机器安装 CM，然后通过 CM Web界面安装 CDH。

- CM 版本：6.3.1
- CDH 版本：6.3.2
- MySQL 版本：5.6
- Java 版本：1.8
- 系统版本：Centos 7.9

*****

## 一、CM 安装

### 1. 配置集群间ssh免密
- 需要修改 `config/vm_info` 文件
- [./cm/01_sshpass.sh](./cm/01_sshpass.sh)

### 2. 配置所有节点的 hosts
- 需要修改 `config/hosts`、`config/all_nodes` 文件
- [./cm/02_hosts.sh](./cm/02_hosts.sh)

### 3. 初始化系统环境
- [./cm/03_init.sh](./cm/03_init.sh)

### 4. 安装 httpd
- [./cm/04_httpd.sh](./cm/04_httpd.sh)

### 5. 安装 java
- 需要修改脚本中的 `HTTPD_SERVER` 变量
- [./cm/05_java.sh](./cm/05_java.sh)

### 6. 安装 ntp
- 需要修改 `config/ntp_clients` 中的 ntp server ip `10.0.5.224`
- [./cm/06_ntp.sh](./cm/06_ntp.sh)

### 7. 安装 mysql
- 需要修改脚本中的 `HTTPD_SERVER` 变量
- [./cm/07_mysql.sh](./cm/07_mysql.sh)

### 8. 安装 cloudera manager agent
- 需要修改脚本中的 `HTTPD_SERVER` 变量
- [./cm/08_cm_agent.sh](./cm/08_cm_agent.sh)

