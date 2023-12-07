#!/usr/bin/env bashio

mkdir -p /share/snapfifo
mkdir -p /share/snapcast

config=/etc/snapserver.conf

if ! bashio::fs.file_exists '/etc/snapserver.conf'; then
    touch /etc/snapserver.conf ||
        bashio::exit.nok "Could not create snapserver.conf file on filesystem"
fi
bashio::log.info "Populating snapserver.conf..."



bashio::log.info "Starting SnapServer..."

/usr/bin/snapserver -c /etc/snapserver.conf
