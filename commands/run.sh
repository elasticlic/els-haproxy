#!/bin/bash
#
# run.sh
#
# Installs and runs els-haproxy.
#
# Usage: run.sh

set -e # stop on error
#set -x # verbose

# Check dependencies
command -v docker >/dev/null 2>&1 || { echo >&2 "To use this script, first install docker"; exit 1; }

# Check argument count
SCRIPTDIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

CONFIGDIR="$SCRIPTDIR"/../config

VERSION=1.7.9
IMAGE=haproxy:"$VERSION"

docker pull "$IMAGE"

# Remove an earlier container that might have exited
docker rm -f els-haproxy || true

docker run \
    -d \
    --name els-haproxy \
    -p 80:80 \
    -p 443:443 \
    -v "$CONFIGDIR":/usr/local/etc/haproxy:ro \
    "$IMAGE"

echo "------------"
echo "els-haproxy should now be running."
echo "Check stats at URL: <server domain or address>/stats ."
echo ""
echo "For further details, see README.md"
echo "------------"
