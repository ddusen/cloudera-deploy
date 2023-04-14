
```
su - gpadmin

crontab -l
0 1 * * 6 /bin/bash /home/gpadmin/scripts/gpbak.sh 2>&1 >> /tmp/gpbackup.log
```


```

```