#!/usr/bin/env bashio

mkdir -p /share/snapfifo
mkdir -p /share/snapcast

config=/etc/snapserver.conf

if ! bashio::fs.file_exists '/etc/snapserver.conf'; then
    touch /etc/snapserver.conf ||
        bashio::exit.nok "Could not create snapserver.conf file on filesystem"
fi
bashio::log.info "Populating snapserver.conf..."

echo "[stream]" >> ${config}
for stream in $(bashio::config 'stream.streams'); do
    echo "stream = ${stream}" >> ${config}
done

bashio::log.info "Done stream bit..."

echo "codec = $(bashio::config 'stream.codec')" >> ${config}
echo "sampleformat = $(bashio::config 'stream.sampleformat')" >> ${config}

echo "[http]" >> ${config}
echo "enabled = $(bashio::config 'http.enabled')" >> ${config}
echo "bind_to_address = $(bashio::config 'http.bindtoaddress')" >> ${config}
echo "port = $(bashio::config 'http.port')" >> ${config}
echo "doc_root = $(bashio::config 'http.docroot')" >> ${config}

echo "[tcp]" >> ${config}
echo "enabled = $(bashio::config 'tcp.enabled')" >> ${config}

echo "[logging]" >> ${config}
echo "debug = $(bashio::config 'logging.enabled')" >> ${config}

echo "[server]" >> ${config}
echo "threads = $(bashio::config 'server.threads')" >> ${config}
echo "datadir = $(bashio::config 'server.datadir')" >> ${config}

bashio::log.info "Starting SnapServer..."

/usr/bin/snapserver -c /etc/snapserver.conf
