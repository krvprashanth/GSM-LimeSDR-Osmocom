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

# THIS SCRIPT CHECKS IF THE LIMESDR IS CONNECTED, UPDATED, AND WORKING PROPERLY.

# Ensure the script is run as root
if [ "$(id -u)" != "0" ]; then
   echo "This script must be run as root." 1>&2
   exit 1
fi

# Check if LimeUtil is installed
if ! command -v LimeUtil &> /dev/null; then
    echo "LimeUtil is not installed. Please install LimeSuite by running the 'install_osmocom_limesdr.sh' script before running this script." 1>&2
    exit 1
fi

# Update LimeSDR
echo "Updating LimeSDR..."
if ! LimeUtil --update; then
    echo "Failed to update LimeSDR. Please check your connection." 1>&2
    exit 1
else
    echo "LimeSDR updated successfully."
fi

# Run LimeQuickTest
echo "Running LimeQuickTest to check if the LimeSDR is working properly..."
if ! LimeQuickTest; then
    echo "LimeQuickTest failed. Please check your LimeSDR device." 1>&2
    exit 1
else
    echo "LimeQuickTest completed successfully. Your LimeSDR is working properly."
fi

