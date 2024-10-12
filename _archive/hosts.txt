#!/bin/bash

HOSTS_URL="https://raw.githubusercontent.com/StevenBlack/hosts/master/hosts"
OVERRIDES_FILE="./settings/hosts/hosts-overrides"
TARGET_DIR="./_builds/hosts"
TARGET_FILE="$TARGET_DIR/hosts"

if ! command -v wget &> /dev/null; then
    echo "Error: wget is not installed. Please install wget and try again."
    exit 1
fi

if [ ! -d "$TARGET_DIR" ]; then
    echo "Target directory '$TARGET_DIR' does not exist. Creating..."
    mkdir -p "$TARGET_DIR"
    if [ $? -ne 0 ]; then
        echo "Error: Failed to create directory '$TARGET_DIR'."
        exit 1
    fi
fi

echo "Fetching the latest hosts file..."
wget -q -O /tmp/latest-hosts "$HOSTS_URL"

if [ $? -ne 0 ]; then
    echo "Error: Failed to download hosts file."
    exit 1
fi

if [ -f "$OVERRIDES_FILE" ]; then
    echo "Appending overrides..."
    cat "$OVERRIDES_FILE" >> /tmp/latest-hosts
else
    echo "No overrides file found. Skipping appending."
fi

echo "Replacing the hosts file..."
mv /tmp/latest-hosts "$TARGET_FILE"

echo "Hosts file updated successfully."
