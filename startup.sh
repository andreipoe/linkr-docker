#!/bin/bash

finish() {
    apache2ctl -k stop
    service redis-server stop
    exit 0
}

trap 'finish' SIGTERM

# Remove any leftover apache2 run files just in case
rm -rf /var/run/lock/apache2/
rm -rf /var/run/apache2/

service redis-server start && /linkr/check_db.sh && apache2ctl -D FOREGROUND &
wait

