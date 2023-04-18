## gpbackup

### 备份脚本
- 每天执行一次全量备份，历史备份保留7天

```bash
vi /home/gpadmin/scripts/gpbak.sh
```
- [gpbak.sh](gpbak.sh)

### 还原脚本
- 手动执行
```bash
vi /home/gpadmin/scripts/gprst.sh
```
- [gprst.sh](gprst.sh)

### 配置定时任务
- 每三天的凌晨一点执行备份
```c
crontab -l
0 1 */3 * *  nohup /bin/bash /home/gpadmin/scripts/gpbackup.sh 2>&1 > /tmp/gpbackup.log &
```

### Examples:
- gpbackup:
```bash
gpbackup --backup-dir /tmp/ --compression-level 6 --jobs 4 --dbname omopcdm_test_new

20230417:17:52:32 gpbackup:gpadmin:gpmaster-242:029350-[INFO]:-gpbackup version = 1.20.3
20230417:17:52:33 gpbackup:gpadmin:gpmaster-242:029350-[INFO]:-Greenplum Database Version = 6.11.2 build commit:d611e78af2c5a6561ccbbaf2b4652138410f9aeb
20230417:17:52:33 gpbackup:gpadmin:gpmaster-242:029350-[INFO]:-Starting backup of database omopcdm_test_new
20230417:17:52:33 gpbackup:gpadmin:gpmaster-242:029350-[INFO]:-Backup Timestamp = 20230417175232
20230417:17:52:33 gpbackup:gpadmin:gpmaster-242:029350-[INFO]:-Backup Database = omopcdm_test_new
20230417:17:52:33 gpbackup:gpadmin:gpmaster-242:029350-[INFO]:-Gathering table state information
20230417:17:52:33 gpbackup:gpadmin:gpmaster-242:029350-[INFO]:-Acquiring ACCESS SHARE locks on tables
Locks acquired:  39 / 39 [==============================================================] 100.00% 0s
20230417:17:52:33 gpbackup:gpadmin:gpmaster-242:029350-[INFO]:-Gathering additional table metadata
20230417:17:52:33 gpbackup:gpadmin:gpmaster-242:029350-[INFO]:-Getting partition definitions
20230417:17:52:33 gpbackup:gpadmin:gpmaster-242:029350-[INFO]:-Getting storage information
20230417:17:52:33 gpbackup:gpadmin:gpmaster-242:029350-[INFO]:-Getting child partitions with altered schema
20230417:17:52:33 gpbackup:gpadmin:gpmaster-242:029350-[INFO]:-Metadata will be written to /tmp/gpseg-1/backups/20230417/20230417175232/gpbackup_20230417175232_metadata.sql
20230417:17:52:33 gpbackup:gpadmin:gpmaster-242:029350-[INFO]:-Writing global database metadata
20230417:17:52:33 gpbackup:gpadmin:gpmaster-242:029350-[INFO]:-Global database metadata backup complete
20230417:17:52:33 gpbackup:gpadmin:gpmaster-242:029350-[INFO]:-Writing pre-data metadata
20230417:17:52:34 gpbackup:gpadmin:gpmaster-242:029350-[INFO]:-Pre-data metadata metadata backup complete
20230417:17:52:34 gpbackup:gpadmin:gpmaster-242:029350-[INFO]:-Writing post-data metadata
20230417:17:52:36 gpbackup:gpadmin:gpmaster-242:029350-[INFO]:-Post-data metadata backup complete
20230417:17:52:36 gpbackup:gpadmin:gpmaster-242:029350-[INFO]:-Writing data to file
Tables backed up:  39 / 39 [============================================================] 100.00% 0s
20230417:17:52:36 gpbackup:gpadmin:gpmaster-242:029350-[INFO]:-Data backup complete
20230417:17:52:56 gpbackup:gpadmin:gpmaster-242:029350-[INFO]:-Found neither /usr/local/greenplum-db-6.11.2/bin/gp_email_contacts.yaml nor /home/gpadmin/gp_email_contacts.yaml
20230417:17:52:56 gpbackup:gpadmin:gpmaster-242:029350-[INFO]:-Email containing gpbackup report /tmp/gpseg-1/backups/20230417/20230417175232/gpbackup_20230417175232_report will not be sent
20230417:17:52:56 gpbackup:gpadmin:gpmaster-242:029350-[INFO]:-Backup completed successfully
```

- gprestore:
```bash
gprestore --backup-dir /tmp --timestamp 20230417175232 --redirect-db omopcdm_test_new --create-db --jobs 8

20230417:17:58:53 gprestore:gpadmin:gpmaster-242:029952-[INFO]:-Restore Key = 20230417175232
20230417:17:58:53 gprestore:gpadmin:gpmaster-242:029952-[INFO]:-gpbackup version = 1.20.3
20230417:17:58:53 gprestore:gpadmin:gpmaster-242:029952-[INFO]:-gprestore version = 1.20.3
20230417:17:58:53 gprestore:gpadmin:gpmaster-242:029952-[INFO]:-Greenplum Database Version = 6.11.2 build commit:d611e78af2c5a6561ccbbaf2b4652138410f9aeb
20230417:17:58:54 gprestore:gpadmin:gpmaster-242:029952-[INFO]:-Creating database
20230417:17:58:54 gprestore:gpadmin:gpmaster-242:029952-[INFO]:-Database creation complete for: omopcdm_test_new
20230417:17:58:55 gprestore:gpadmin:gpmaster-242:029952-[INFO]:-Restoring pre-data metadata
Pre-data objects restored:  82 / 82 [===================================================] 100.00% 1s
20230417:17:58:56 gprestore:gpadmin:gpmaster-242:029952-[INFO]:-Pre-data metadata restore complete
Tables restored:  39 / 39 [=============================================================] 100.00% 0s
20230417:17:58:56 gprestore:gpadmin:gpmaster-242:029952-[INFO]:-Data restore complete
20230417:17:58:56 gprestore:gpadmin:gpmaster-242:029952-[INFO]:-Restoring post-data metadata
Post-data objects restored:  130 / 130 [================================================] 100.00% 0s
20230417:17:58:57 gprestore:gpadmin:gpmaster-242:029952-[INFO]:-Post-data metadata restore complete
20230417:17:58:57 gprestore:gpadmin:gpmaster-242:029952-[INFO]:-Found neither /usr/local/greenplum-db-6.11.2/bin/gp_email_contacts.yaml nor /home/gpadmin/gp_email_contacts.yaml
20230417:17:58:57 gprestore:gpadmin:gpmaster-242:029952-[INFO]:-Email containing gprestore report /tmp/gpseg-1/backups/20230417/20230417175232/gprestore_20230417175232_20230417175853_report will not be sent
20230417:17:58:57 gprestore:gpadmin:gpmaster-242:029952-[INFO]:-Restore completed successfully
```

### Refs:
- http://docs-cn.greenplum.org/v6/utility_guide/admin_utilities/gpbackup.html
- http://docs-cn.greenplum.org/v6/utility_guide/admin_utilities/gprestore.html
