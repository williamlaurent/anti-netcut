#!/bin/bash

lock_arp_entry() {
    echo "--- Starting Anti-NetCut ARP Lock ---"

    INTERFACE=$(ip route | awk '/default/ {print $5; exit}')
    if [ -z "$INTERFACE" ]; then
        echo "❌ Error: Failed to detect active network interface."
        return 1
    fi
    echo "✅ Interface Detected: $INTERFACE"

    GATEWAY_IP=$(ip route | awk '/default/ {print $3; exit}')
    if [ -z "$GATEWAY_IP" ]; then
        echo "❌ Error: Failed to detect Gateway IP."
        return 1
    fi
    echo "✅ Gateway IP Detected: $GATEWAY_IP"

    ping -c 1 $GATEWAY_IP > /dev/null 2>&1
    
    GATEWAY_MAC=$(arp -n | awk -v ip="$GATEWAY_IP" '$1 == ip {print $3; exit}')

    if [ -z "$GATEWAY_MAC" ] || [ "$GATEWAY_MAC" == "(incomplete)" ]; then
        echo "❌ Error: Failed to get Gateway MAC Address. Check network connection."
        return 1
    fi
    echo "✅ Gateway MAC Detected: $GATEWAY_MAC"

    echo "Cleaning up old dynamic ARP entries for $GATEWAY_IP..."
    sudo arp -d $GATEWAY_IP 2> /dev/null

    echo "Setting Static ARP lock: $GATEWAY_IP -> $GATEWAY_MAC on $INTERFACE..."
    sudo arp -s $GATEWAY_IP $GATEWAY_MAC -i $INTERFACE

    if [ $? -eq 0 ]; then
        echo "👍 Success! ARP entry is now locked (Static)."
        echo "🛡️ Current Lock Status: $(arp -n | grep $GATEWAY_IP)"
        echo "--- Anti-NetCut Protection Active ---"
    else
        echo "❌ Failure: Failed to set Static ARP. Root privileges required."
        return 1
    fi
}

lock_arp_entry
