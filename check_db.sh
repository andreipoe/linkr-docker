#!/bin/sh

if [ ! -f /data/linkr.db ]; then
    cp /linkr/linkr_new.db /data/linkr.db
	chown www-data:www-data /data
	chown www-data:www-data /data/linkr.db
fi

