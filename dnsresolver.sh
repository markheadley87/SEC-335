#!/bin/bash

network_prefix=$1
dns_server=$2

# Ensure both arguments are provided
if [ -z "$network_prefix" ] || [ -z "$dns_server" ]; then
    echo "Usage: $0 [network_prefix] [dns_server]"
    exit 1
fi

# Loop through 1 to 254 and perform a DNS lookup
for i in $(seq 1 254); do
    host="$network_prefix.$i"
    result=$(nslookup $host $dns_server 2>/dev/null)
    
    # Check if the result contains an address field
    if echo "$result" | grep -q "Address:"; then
        echo "$host resolves to $(echo "$result" | grep 'Address:' | tail -n1 | awk '{print $NF}')"
    else
        echo "$host does not resolve"
    fi
done
