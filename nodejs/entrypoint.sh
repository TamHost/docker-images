#!/bin/bash
cd /home/container

# Make internal Docker IP address available to processes.
INTERNAL_IP=$(ip route get 1 | awk '{print $(NF-2);exit}')
export INTERNAL_IP

# Print Node.js Version
node -v

# Replace Startup Variables
MODIFIED_STARTUP=$(echo -e ${STARTUP} | sed -e 's/{{/${/g' -e 's/}}/}/g')
printf "\033[1m\033[33mcontainer@tamhost~ \033[0m%s\n" "$MODIFIED_STARTUP"
echo "$MODIFIED_STARTUP"
# shellcheck disable=SC2086
eval "$MODIFIED_STARTUP"
