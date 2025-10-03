# Anti-NetCut (ARP Spoofing Countermeasure)

A simple, automatic **Bash script** to counter ARP spoofing attacks, like those performed by tools like NetCut, by setting a **Static ARP** entry for your network gateway.

## ⚡ Quick Description
This script **automatically detects** your network interface, Gateway IP, and MAC Address, then uses the `arp -s` command to **lock** the gateway's ARP entry in your system's cache. This prevents attackers from redirecting your traffic through their machine.

## 🚀 Installation & Usage

1. **Clone the repository:**
   ```bash
   git clone https://github.com/williamlaurent/anti-netcut.git
   cd anti-netcut
   ```
2. **Give execution permission:**
   ```bash
   chmod +x anti.sh
   ```
3. **Run the script (requires root privileges):**
   ```bash
   sudo ./anti-netcut.sh
   ```

## ⚠️ IMPORTANT NOTE 
The Static ARP lock set by this script is temporary and will be removed upon system reboot.
For persistent protection, you must configure the script to run automatically at startup (e.g., using a `systemd` service or a `@reboot` cron job).

## 📄 License
This project is licensed under the MIT License.
