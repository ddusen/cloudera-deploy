for i in `cat /opt/soft/cdh-bog/config/all_nodes`
do

scp -r /opt/soft/cdh-bog/jdk1.8.0_202/  $i:/opt
scp -r /opt/soft/cdh-bog/config/jdk_profile  $i:/tmp/
ssh $i  "cat /tmp/jdk_profile  >> /etc/profile"



done
