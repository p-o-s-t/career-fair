#!/bin/bash

# Management script for Network Scenario 2

ACTION=$1        # start, stop, reset

if [[ -z "$ACTION" ]]; then
    echo "Usage: $0 <start|stop|reset>"
    exit 1
fi

# Ensure we are in the directory of the script
cd "$(dirname "$0")" || exit

case "$ACTION" in
    start)
        echo "Starting Network Scenario 2..."
        docker compose up -d
        ;;
    stop)
        echo "Stopping Network Scenario 2..."
        docker compose down
        ;;
    reset)
        echo "Resetting Network Scenario 2 to clean state..."
        docker compose down -v
        docker compose up -d
        ;;
    *)
        echo "Invalid action: $ACTION"
        exit 1
        ;;
esac
