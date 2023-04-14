#!/bin/bash

function main() {
    gprestore --timestamp 20230414010008 --backup-dir /gpbak/2023-04-14 --jobs 8
}

main
