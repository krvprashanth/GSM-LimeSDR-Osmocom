#!/bin/sh
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

# Prompt the user for IMSI, MSISDN, and Ki values
read -p "Enter IMSI: " IMSI
read -p "Enter MSISDN: " MSISDN
read -p "Enter Ki (Authentication Key): " KI

# Connect to OsmoHLR via telnet
(
echo "enable"
sleep 1

# Create a subscriber with the given IMSI
echo "subscriber imsi $IMSI create"
sleep 1

# Assign MSISDN to the subscriber
echo "subscriber imsi $IMSI update msisdn $MSISDN"
sleep 1

# Set the authentication parameters with the given Ki
echo "subscriber imsi $IMSI update aud2g comp128v1 ki $KI"
sleep 1

# Set network access mode to cs+ps
echo "subscriber imsi $IMSI update network-access-mode cs+ps"
sleep 1

# Show subscriber details
echo "subscriber imsi $IMSI show"
sleep 1

# Exit telnet
echo "exit"
) | telnet 127.0.0.1 4258

# Print success message
echo "Subscriber with IMSI $IMSI and MSISDN $MSISDN has been successfully added."

