#!/bin/bash -e
#
# Copyright (c) 2024 Kurva Prashanth <krvprashanth@riseup.net>
#
# Permission is hereby granted, free of charge, to any person obtaining a copy
# of this software and associated documentation files (the "Software"), to deal
# in the Software without restriction, including without limitation the rights
# to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
# copies of the Software, and to permit persons to whom the Software is
# furnished to do so, subject to the following conditions:
#
# The above copyright notice and this permission notice shall be included in
# all copies or substantial portions of the Software.
#
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
# THE SOFTWARE.



SCRIPT_DIR=$(cd "$(dirname "$0")" && pwd)

# Check if the script is running as root
if [ "$(id -u)" -ne 0 ]; then
    echo "This script must be run as root" >&2
    exit 1
fi

# Ensure /etc/osmocom exists and backup existing files
mkdir -p /etc/osmocom/
if [ "$(ls -A /etc/osmocom/)" ]; then
    echo "Backing up existing configuration files..."
    mv /etc/osmocom/* /etc/osmocom/backup/
fi

# Remove all existing files
rm -rf /etc/osmocom/*

# Copy configuration files from the specified directory to /etc/osmocom
echo "Copying configuration files from $SCRIPT_DIR/../rootfs/etc/osmocom/..."
cp -r "$SCRIPT_DIR/../rootfs/etc/osmocom/"* /etc/osmocom/

# Check if the copy was successful
if [ $? -eq 0 ]; then
    echo "Configuration files copied successfully."
else
    echo "Error copying configuration files." >&2
    exit 1
fi

