#!/bin/bash

#申明gp相关参数
source /usr/local/greenplum-db/greenplum_path.sh
export MASTER_DATA_DIRECTORY=/data/gpseg-1
export GPPORT=5432

#定义备份目录
BAKDIR=/data/mirror02
#获取当前日期
NOW=$(date  +%Y-%m-%d)
#设置需要备份的数据库名称
DBNAME=(gdsrm gpdb )

#备份函数
function DbBackup()
{
    echo "创建备份文件$BAKDIR/$NOW  $bakdb";
    #创建当前日期文件夹
    gpssh -f /home/gpadmin/scripts/seg_hosts  -e "mkdir $BAKDIR/$NOW";
    #循环备份所有库到当前日期文件夹下
    for bakdb in ${DBNAME[@]}
    do
        NOW1=$(date  +%Y-%m-%d[%H:%M:%S])
        echo "$NOW1 开始备份 $bakdb ";
        #pg_dump -Fc $bakdb -f $BAKDIR/$NOW/$bakdb.dump;
        gpbackup --dbname $bakdb --jobs 4 --backup-dir $BAKDIR/$NOW
    done
}

#清理函数
function RmOldBak()
{
	weekago=$(date -d "7 days ago" +%s)
	for oldbak in $(ls -l $BAKDIR|egrep "^d"|awk '{print $9}')
	do
		oldbakdate=$(date -d $oldbak +%s)
		echo "$oldbakdate $weekago"
		if [[ $weekago -ge $oldbakdate ]];then
			echo "删除旧备份: $oldbak"
			# gpssh -f /home/gpadmin/conf/hosts -e "rm -rf $BAKDIR/$oldbak"
		fi
	done
}

NOW1=$(date  +%Y-%m-%d[%H:%M:%S])

echo -e "$NOW1 文件检查清理开始  =========="
RmOldBak

echo -e "$NOW1 备份开始 =========================="
DbBackup
