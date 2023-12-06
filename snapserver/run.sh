#!/usr/bin/env bashio

mkdir -p /share/snapfifo
mkdir -p /share/snapcast

config=/etc/snapserver.conf

if ! bashio::fs.file_exists '/etc/snapserver.conf'; then
    touch /etc/snapserver.conf ||
        bashio::exit.nok "Could not create snapserver.conf file on filesystem"
fi
bashio::log.info "Populating snapserver.conf..."

# Start creation of configuration Hardcoded

echo "[http]"
echo "enabled = true"
echo "bind_to_address = 0.0.0.0"
echo "port = 1780"
echo "doc_root = /usr/share/snapserver/snapweb"

echo "[stream]"
echo "source = airplay:///shairport-sync?name=Airplay&devicename=snap1"

echo "sampleformat = 44100:16:2"
echo "codec = flac"

bashio::log.info "Starting SnapServer..."

/usr/bin/snapserver -c /etc/snapserver.conf
