

### gpbackup 备份脚本
- 每天执行一次全量备份，历史备份保留7天

```bash
vi /home/gpadmin/scripts/gpbak.sh
```
- [gpbak.sh](gpbak.sh)

### 配置定时任务
- 每天凌晨一点执行备份
```c
crontab -l

0 1 * * * /bin/bash /home/gpadmin/scripts/gpbak.sh 2>&1 >> /tmp/gpbackup.log
```

