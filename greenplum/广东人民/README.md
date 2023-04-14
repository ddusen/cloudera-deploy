

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
- 每天凌晨一点执行备份
```c
crontab -l

0 1 * * * /bin/bash /home/gpadmin/scripts/gpbak.sh 2>&1 >> /tmp/gpbackup.log
```

### Refs:
- http://docs-cn.greenplum.org/v6/utility_guide/admin_utilities/gpbackup.html
- http://docs-cn.greenplum.org/v6/utility_guide/admin_utilities/gprestore.html
