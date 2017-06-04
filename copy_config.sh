#!/bin/sh

cd /linkr

if [ -f /config/flask.py ]; then
    cp /config/flask.py config/flask.py
fi

for d in options secrets; do
    for f in client server; do
        if [ -f /config/$d/$f.json ]; then
            cp /config/$d/$f.json config/$d/$f.json
        else
            cp config/$d/$f.json.template config/$d/$f.json
        fi
    done
done

