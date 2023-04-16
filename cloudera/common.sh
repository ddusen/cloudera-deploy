#!/bin/bash

#author: Sen Du
#email: dusen@gennlife.com
#created: 2023-04-16 20:00:00
#updated: 2023-04-16 20:00:00

set -e 

## 控制日志颜色：灰色
START="\033[36m"
END="\033[0m"

function my_echo() {
    echo -e "$START$1$END"
}
