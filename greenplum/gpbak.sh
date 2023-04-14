
#!/bin/bash
source /usr/local/greenplum-db/greenplum_path.sh
export MASTER_DATA_DIRECTORY=/data/gpseg-1
export GPPORT=5432

BAKDIR=/gpbak
NOW=$(date +%Y-%m-%d)
DBNAME=(zdyf)

function DbBackup()
{
	echo "begin backup......$NOW";
	gpssh -f /home/gpadmin/conf/hosts -e "mkdir -pv /gpbak/$NOW";
	gpbackup --backup-dir /gpbak/$NOW/zdyf  --compression-level 6 --jobs 4 --dbname zdyf;
}

function RmOldBak()
{
	mothago=$(date -d "1 month ago" +%s)
	for oldbak in $(ls -l /gpbak|egrep "^d"|awk '{print $9}')
	do
		oldbakdate=$(date -d $oldbak +%s)
		echo "$oldbakdate $mothago"
		if [[ $monthago -ge $oldbakdate ]];then
			echo "delet old bak: $oldbak"
			gpssh -f /home/gpadmin/conf/hosts -e "rm -rf /gpbak/$oldbak"
		fi
	done
}

DbBackup
RmOldBak