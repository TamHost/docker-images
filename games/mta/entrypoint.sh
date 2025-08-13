#!/bin/bash
cd /home/container

# Přidání staré MySQL knihovny, pokud chybí
if [ ! -f /usr/lib/x86_64-linux-gnu/libmysqlclient.so.16 ]; then
    echo "Stahuji libmysqlclient.so.16..."
    wget -q http://old-releases.ubuntu.com/ubuntu/pool/universe/m/mysql-dfsg-5.1/libmysqlclient16_5.1.31-1ubuntu2_amd64.deb -O /tmp/libmysqlclient16.deb
    dpkg -x /tmp/libmysqlclient16.deb /tmp/mysql
    cp /tmp/mysql/usr/lib/libmysqlclient.so.16 /usr/lib/x86_64-linux-gnu/
    rm -rf /tmp/mysql /tmp/libmysqlclient16.deb
fi

# Make internal Docker IP address available to processes.
INTERNAL_IP=$(ip route get 1 | awk '{print $(NF-2);exit}')
export INTERNAL_IP

# Replace Startup Variables
MODIFIED_STARTUP=$(echo -e $(echo -e ${STARTUP} | sed -e 's/{{/${/g' -e 's/}}/}/g'))
printf "\033[1m\033[33mcontainer@tamhost~ \033[0m%s\n" "$MODIFIED_STARTUP"

# Run the Server
eval ${MODIFIED_STARTUP}
