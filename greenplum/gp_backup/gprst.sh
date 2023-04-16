#!/bin/bash

function main() {
    gprestore --timestamp 20230414192741 --redirect-db dusen --create-db --backup-dir /gpbak/2023-04-14/dip_test/gpseg-1/backups/20230414/20230414192741 --jobs 8
}

main
