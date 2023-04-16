#!/bin/bash
#
#执行完本脚本后需要设置同步时间 1.服务器 2.hosts文件 3.hostname设置

#获取centos主版本号
NTPSERVER=172.30.22.11
CENTOS_VERSION=$(cat /etc/redhat-release|sed -r 's/.* ([0-9]+)\..*/\1/')

function JdkProfile(){
tar -xf jdk-8u202-linux-x64.tar.gz -C /opt/
cat >> /etc/profile << EOF
export JAVA_HOME=/opt/jdk1.8.0_202
export PATH=\$JAVA_HOME/bin:\$PATH
export CLASSPATH=.:\$JAVA_HOME/lib/dt.jar:\$JAVA_HOME/lib/tools.jar
EOF
source /etc/profile;
mkdir /usr/java;
ln -s /opt/jdk1.8.0_202 /usr/java/default
}

function ChangeHosts(){
cat >> /etc/hosts << EOF
10.0.1.101   cdh-cm-01
10.0.1.103   cdh-master-01
10.0.1.104   cdh-master-02 
10.0.1.105   cdh-master-03
10.0.1.106   cdh-data-01
10.0.1.107   cdh-data-02
10.0.1.108   cdh-data-03
10.0.1.109   cdh-data-04
EOF
}

function AddDisk(){
#       mkdir -pv /data/vdb /data/vdc;
#       mkfs.xfs /dev/vdb;
#       blkid /dev/vdb|awk '{print $2" /data/primary xfs   defaults        0 0"}' >> /etc/fstab;
#       mkfs.xfs /dev/vdc;
#       blkid /dev/vdc|awk '{print $2" /data/mirror xfs   defaults        0 0"}' >> /etc/fstab;
#       mount -a;
        echo "pass"
}

function Sys7BakFile(){
        mkdir /opt/bakfile;
        cp /etc/security/limits.conf /opt/bakfile;
        cp /etc/security/limits.d/20-nproc.conf /opt/bakfile;
        cp /etc/sysctl.conf  /opt/bakfile;
}


function Sys7Profile(){
cat > /etc/security/limits.conf << EOF
* soft nofile 65536
* hard nofile 65536
* soft nproc 131072
* hard nproc 131072
* soft core unlimited
EOF
cat > /etc/security/limits.d/20-nproc.conf << EOF
* soft nproc 10240
root soft nproc unlimited
EOF
cat > /etc/sysctl.conf << EOF
vm.swappiness = 10
EOF
echo never > /sys/kernel/mm/transparent_hugepage/defrag
echo never > /sys/kernel/mm/transparent_huagepage/enabled
echo "echo never > /sys/kernel/mm/transparent_hugepage/defrag" >> /etc/rc.d/rc.local
echo "echo never > /sys/kernel/mm/transparent_huagepage/enabled" >> /etc/rc.d/rc.local
}


function Sys7DisableThp(){
    grubby --update-kernel=ALL --args="transparent_hugepage=never";
	sed -i "/^#RemoveIPC=no/cRemoveIPC=no" /etc/systemd/logind.conf;
	systemctl restart systemd-logind.service;
}

function DisableSelinux(){
	#关闭selinux
	sed -i "/^SELINUX=/cSELINUX=disabled" /etc/selinux/config;
}

function SshConfig(){
	#更改ssh相关配置
	sed -i "/^#UseDNS/cUseDNS no" /etc/ssh/sshd_config;
	sed -i "/^GSSAPIAuthentication/cGSSAPIAuthentication no" /etc/ssh/sshd_config;
	sed -i "/^GSSAPICleanupCredentials/cGSSAPICleanupCredentials no" /etc/ssh/sshd_config;
	sed -i "/^#MaxStartups/cMaxStartups 10000:30:20000" /etc/ssh/sshd_config;
}

function OffService(){
	chkconfig iptables off;
	chkconfig ip6tables off;
	chkconfig postfix off;
}

function DisableService(){
	systemctl disable postfix;
    systemctl disable libvirtd;
	systemctl disable firewalld;
}

function NtpSync(){
	#yum install -y ntpdate
	#echo "*/5 * * * * /usr/sbin/ntpdate $NTPSERVER" >> /var/spool/cron/root
        yum install chrony -y
}

#cd /opt/CDH-6.3.1/scripts/sysinit_and_mysql
cd /opt/soft/cdh-bog/CDH-6.3.1/scripts/sysinit_and_mysql
if [[ $CENTOS_VERSION -eq 7 ]];then
	DisableSelinux
	SshConfig
	Sys7DisableThp
	NtpSync
	chmod +x /etc/rc.d/rc.local;
#	AddDisk
	Sys7BakFile
	Sys7Profile
#	ChangeHosts
	JdkProfile
fi

#重启远程主机
#init 6
