#!/bin/bash

finish() {
    apache2ctl -k stop
    service redis-server stop
    exit 0
}

trap 'finish' SIGTERM

service redis-server start && /linkr/check_db.sh && apache2ctl -D FOREGROUND &
wait

