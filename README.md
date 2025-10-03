# anti-netcut
This script automatically detects your network interface, Gateway IP, and MAC Address, then uses the `arp -s` command to lock the gateway's ARP entry in your system's cache. This prevents attackers from redirecting your traffic through their machine.
