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

# THIS SCRIPT INSTALLS THE NECESSARY PACKAGES FOR SETTING UP A GSM (2G) NETWORK 
# USING LIMESDR AND OSMOCOM SOFTWARE. 
# IT IS WRITTEN TO RUN ON DEBIAN.

# Ensure the script is run as root
if [ "$(id -u)" != "0" ]; then
   echo "This script must be run as root" 1>&2
   exit 1
fi

# Install extrepo if not already installed
if ! command -v extrepo &> /dev/null; then
    echo "Installing extrepo..."
    apt-get install -y extrepo
fi

# Enable Osmocom project repository
if ! extrepo show | grep -q "osmocom-latest"; then
    echo "Enabling Osmocom project repository..."
    extrepo enable osmocom-latest
else
    echo "Osmocom project repository is already enabled. Skipping to package installation."
fi

# Check for required dependencies
REQUIRED_DEPENDENCIES=("git" "telnet" "iptables" "limesuite" "osmo-hlr" "osmo-msc" \
                       "osmo-mgw" "osmo-stp" "osmo-bsc" "osmo-ggsn" "osmo-sgsn" \
                       "osmo-bts-trx" "osmo-trx-lms" "osmo-pcu" "osmo-cbc" "osmo-cbc-utils")

for dep in "${REQUIRED_DEPENDENCIES[@]}"; do
    if ! dpkg -l | grep -q "$dep"; then
        echo "$dep is not installed. Installing..."
        apt-get install -y "$dep"
    else
        echo "$dep is already installed."
    fi
done

echo "All required packages are installed successfully! 😉"
