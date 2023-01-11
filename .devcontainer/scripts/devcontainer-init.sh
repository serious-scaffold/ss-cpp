#!/usr/bin/env bash

set -e
echo "Running devcontainer-init.sh ..."

# Other feature environment configuration can be set below

echo "Invoking docker-init.sh ..."
exec /usr/local/share/docker-init.sh "$@"