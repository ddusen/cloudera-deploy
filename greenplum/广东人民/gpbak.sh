
#!/bin/bash
source /usr/local/greenplum-db/greenplum_path.sh
export MASTER_DATA_DIRECTORY=/data/gpseg-1
export GPPORT=5432

BAKDIR=/gpbak
NOW=$(date +%Y-%m-%d)
DBNAME=(gdsrm)

function DbBackup()
{
	echo "begin backup......$NOW";
	gpssh -f /home/gpadmin/conf/hosts -e "mkdir -pv $BAKDIR/$NOW";
	gpbackup --backup-dir $BAKDIR/$NOW/$DBNAME --compression-level 6 --jobs 4 --dbname $DBNAME;
	echo "end backup.$NOW";
}

function RmOldBak()
{
	weekago=$(date -d "7 days ago" +%s)
	for oldbak in $(ls -l $BAKDIR|egrep "^d"|awk '{print $9}')
	do
		oldbakdate=$(date -d $oldbak +%s)
		echo "$oldbakdate $weekago"
		if [[ $weekago -ge $oldbakdate ]];then
			echo "delete old bak: $oldbak"
			gpssh -f /home/gpadmin/conf/hosts -e "rm -rf $BAKDIR/$oldbak"
		fi
	done
}

DbBackup
RmOldBak