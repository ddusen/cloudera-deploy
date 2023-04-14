#!/bin/bash

#author: Sen Du
#email: dusen@gennlife.com
#created: 2023-04-07 17:58:00
#updated: 2023-04-07 17:58:00

# 安装 mydumper
# 执行备份

set -e 

user="root"
passwd=""
host=""
port=""
db=""
tables=""
thread=
path=""


install_mydumper() {

}

backup() {
    echo "mydumper -u %s -p %s -h %s -P %s -B %s -T %s --long-query-guard=300 -k -v 3 -t %d -o %s/mysql"
}

main() {

}

main

	cmd = fmt.Sprintf("mydumper -u %s -p %s -h %s -P %s -B %s -T %s --long-query-guard=300 -k -v 3 -t %d -o %s/mysql",
		c.MySQL.Source.User,
		c.MySQL.Source.Password,
		c.MySQL.Source.Host,
		c.MySQL.Source.Port,
		c.MySQL.Source.DB,
		tables,
		thread, // 线程数
		c.Path,
	)


OSSUTIL_CONF="
[Credentials]
language=$OSS_LANGUAGE
endpoint=http://$OSS_ENDPOINT
accessKeyID=$OSS_ACCESSKEYID
accessKeySecret=$OSS_ACCESSKEYSECRET
"

#安装 Ossutil
install_ossutil(){
    echo "wget https://gosspublic.alicdn.com/ossutil/1.7.5/ossutil64 \
        && mv ossutil64 /usr/bin/ossutil \
        && chmod +x /usr/bin/ossutil"

    wget https://gosspublic.alicdn.com/ossutil/1.7.5/ossutil64 \
        && mv ossutil64 /usr/bin/ossutil \
        && chmod +x /usr/bin/ossutil
}

#配置 Ossutil
configure_ossutil(){
    echo "echo \"$OSSUTIL_CONF\" > ~/.ossutilconfig"
    echo "$OSSUTIL_CONF" > ~/.ossutilconfig
}

#安装 Juicefs
install_juicefs(){
    echo "ossutil cp oss://juicefs-hex/lib/juicefs . \
        && mv juicefs /usr/bin/juicefs \
        && chmod +x /usr/bin/juicefs"

    ossutil cp oss://juicefs-hex/lib/juicefs . \
        && mv juicefs /usr/bin/juicefs \
        && chmod +x /usr/bin/juicefs
}

#配置 Juicefs
configure_juicefs(){
    echo "juicefs --debug format --storage oss --bucket https://$OSS_BUCKET.$OSS_ENDPOINT \
        --access-key $OSS_ACCESSKEYID --secret-key $OSS_ACCESSKEYSECRET \
        $META_CONF $OSS_DIR"

    juicefs --debug format --storage oss --bucket https://$OSS_BUCKET.$OSS_ENDPOINT \
        --access-key $OSS_ACCESSKEYID --secret-key $OSS_ACCESSKEYSECRET \
        $META_CONF $OSS_DIR
}

#挂载 OSS 到本地 /data
mount_oss(){
    echo "mkdir -p /$OSS_DIR"
    mkdir -p /$OSS_DIR
    
    echo "juicefs --debug mount -d $META_CONF /$OSS_DIR"
    juicefs --debug mount -d $META_CONF /$OSS_DIR
}

main(){
	install_ossutil
    configure_ossutil

    install_juicefs
    configure_juicefs

    mount_oss
}

main
