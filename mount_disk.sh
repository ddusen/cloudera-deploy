#!/bin/bash

#author: Sen Du
#email: dusen@gennlife.com
#created: 2023-04-16 15:00:00
#updated: 2023-04-16 15:00:00

set -e 
source 00_env

########################### 此脚本请手动一步一步执行 ###########################

# 1.查看虚拟机磁盘列表
function show_disk() {
    cat config/vm_info.bak | grep -v "^#" | grep -v "^$" | while read ipaddr name passwd
    do 
        echo -e "$CSTART>>>>$ipaddr$CEND"
        ssh -n $ipaddr "lsblk"
    done
}

# 2.格式化磁盘
function format_disk() {
    cat config/vm_info.bak | grep -v "^#" | grep -v "^$" | while read ipaddr name passwd
    do 
        echo -e "$CSTART>>>>$ipaddr$CEND"
        ssh -n $ipaddr "mkfs.xfs /dev/sde"
        ssh -n $ipaddr "mkfs.xfs /dev/sdf"
        ssh -n $ipaddr "mkfs.xfs /dev/sdg"
    done
}

# 3.获取磁盘UUID
function get_disk_uuid() {
    cat config/vm_info.bak | grep -v "^#" | grep -v "^$" | while read ipaddr name passwd
    do 
        echo -e "$CSTART>>>>$ipaddr$CEND"
        ssh -n $ipaddr "blkid"
    done
}

# 4.修改 /etc/fstab 文件
function modify_fstab() {
    ssh -n 172.20.3.27 "echo 'UUID="5a89c064-1011-487c-ab2c-f01586976e6d" /dfs/dn/data4  xfs     defaults        0 0' >> /etc/fstab"
    ssh -n 172.20.3.27 "echo 'UUID="a7c4c7e9-57e2-4ecc-88f3-9ff9321faacb" /dfs/dn/data5  xfs     defaults        0 0' >> /etc/fstab"
    ssh -n 172.20.3.27 "echo 'UUID="2eb65cdd-f8fe-4d03-af7d-bb8db9acbbee" /dfs/dn/data6  xfs     defaults        0 0' >> /etc/fstab"

    ssh -n 172.20.3.28 "echo 'UUID="3a8ff610-b14c-414f-9f0f-92c5a75926c2" /dfs/dn/data4  xfs     defaults        0 0' >> /etc/fstab"
    ssh -n 172.20.3.28 "echo 'UUID="365e938e-338e-4012-ae21-6651385eba48" /dfs/dn/data5  xfs     defaults        0 0' >> /etc/fstab"
    ssh -n 172.20.3.28 "echo 'UUID="bdcc6f46-9bec-4a37-b095-8a39a79cc7c1" /dfs/dn/data6  xfs     defaults        0 0' >> /etc/fstab"

    ssh -n 172.20.3.29 "echo 'UUID="bd0c5fc0-02c7-4b75-97e1-8bedf015ab57" /dfs/dn/data4  xfs     defaults        0 0' >> /etc/fstab"
    ssh -n 172.20.3.29 "echo 'UUID="38cd9e3a-dabd-4ab4-9863-48f4edd92d35" /dfs/dn/data5  xfs     defaults        0 0' >> /etc/fstab"
    ssh -n 172.20.3.29 "echo 'UUID="ece4a2eb-dd18-4815-b3d5-cde499986c08" /dfs/dn/data6  xfs     defaults        0 0' >> /etc/fstab"

    ssh -n 172.20.3.30 "echo 'UUID="88f2c64f-613b-49fa-a109-f8daf8ec0b89" /dfs/dn/data4  xfs     defaults        0 0' >> /etc/fstab"
    ssh -n 172.20.3.30 "echo 'UUID="5b31c3c4-81f9-4467-9e2b-90833108ce16" /dfs/dn/data5  xfs     defaults        0 0' >> /etc/fstab"
    ssh -n 172.20.3.30 "echo 'UUID="a5c3a486-53fa-40e7-b8bd-8c6d000e485f" /dfs/dn/data6  xfs     defaults        0 0' >> /etc/fstab"

    ssh -n 172.20.3.31 "echo 'UUID="09c9f585-5d6d-42d3-ad78-5c4522f9b5e8" /dfs/dn/data4  xfs     defaults        0 0' >> /etc/fstab"
    ssh -n 172.20.3.31 "echo 'UUID="49029a4c-d86d-40bf-8699-b6f9779e040d" /dfs/dn/data5  xfs     defaults        0 0' >> /etc/fstab"
    ssh -n 172.20.3.31 "echo 'UUID="ba5a0806-83c6-4b29-b03b-f67e5ae72b5d" /dfs/dn/data6  xfs     defaults        0 0' >> /etc/fstab"

    ssh -n 172.20.3.32 "echo 'UUID="0ccc2477-fdf2-4d08-a9f1-dceb65a4fc59" /dfs/dn/data4  xfs     defaults        0 0' >> /etc/fstab"
    ssh -n 172.20.3.32 "echo 'UUID="4970d829-de9e-45a8-ba85-803aaec83bb0" /dfs/dn/data5  xfs     defaults        0 0' >> /etc/fstab"
    ssh -n 172.20.3.32 "echo 'UUID="8c96666d-74e2-43b8-a439-f6871dfd47c4" /dfs/dn/data6  xfs     defaults        0 0' >> /etc/fstab"

    ssh -n 172.20.3.33 "echo 'UUID="14d40a47-e901-456b-ad65-f2a75698b09f" /dfs/dn/data4  xfs     defaults        0 0' >> /etc/fstab"
    ssh -n 172.20.3.33 "echo 'UUID="d3142ae3-e756-476b-bcaf-a2511ee264fc" /dfs/dn/data5  xfs     defaults        0 0' >> /etc/fstab"
    ssh -n 172.20.3.33 "echo 'UUID="2e7f7808-1ddb-46f8-817b-a890ffe6fc25" /dfs/dn/data6  xfs     defaults        0 0' >> /etc/fstab"

    ssh -n 172.20.3.34 "echo 'UUID="f22e36b9-c487-4124-818c-b0d7f7062a38" /dfs/dn/data4  xfs     defaults        0 0' >> /etc/fstab"
    ssh -n 172.20.3.34 "echo 'UUID="e3212bda-b187-4570-ab63-483a4a3f34df" /dfs/dn/data5  xfs     defaults        0 0' >> /etc/fstab"
    ssh -n 172.20.3.34 "echo 'UUID="a6ca209d-f18b-445f-b6fc-c544421c16a1" /dfs/dn/data6  xfs     defaults        0 0' >> /etc/fstab"
}

function check_modify_fstab() {
    cat config/vm_info.bak | grep -v "^#" | grep -v "^$" | while read ipaddr name passwd
    do 
        echo -e "$CSTART>>>>$ipaddr$CEND"
        ssh -n $ipaddr "cat /etc/fstab"
    done
}

# 5.挂载磁盘
function mount_disk() {
    cat config/vm_info.bak | grep -v "^#" | grep -v "^$" | while read ipaddr name passwd
    do 
        echo -e "$CSTART>>>>$ipaddr$CEND"
        ssh -n $ipaddr "mkdir -p /dfs/dn/data4"
        ssh -n $ipaddr "mkdir -p /dfs/dn/data5"
        ssh -n $ipaddr "mkdir -p /dfs/dn/data6"
        ssh -n $ipaddr "mount -a"
    done
}

function check_mount() {
    cat config/vm_info.bak | grep -v "^#" | grep -v "^$" | while read ipaddr name passwd
    do 
        echo -e "$CSTART>>>>$ipaddr$CEND"
        ssh -n $ipaddr "df -h"
    done
}
