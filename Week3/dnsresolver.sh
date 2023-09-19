#!/bin/bash

network_prefix=$1
dns_server=$2

# Ensure both arguments are provided
if [ -z "$network_prefix" ] || [ -z "$dns_server" ]; then
    echo "Usage: $0 [network_prefix] [dns_server]"
    exit 1
fi

# Loop through .2 to .254 and perform an nslookup
for i in $(seq 2 254); do
    host="$network_prefix.$i"
    result=$(nslookup $host $dns_server 2>&1)
    
    # Only show results that don't contain "can't find"
    if ! echo "$result" | grep -q "can't find"; then
        echo "$result"
    fi
done
