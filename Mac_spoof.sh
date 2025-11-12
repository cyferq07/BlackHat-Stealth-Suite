#!/data/data/com.termux/files/usr/bin/bash
set -euo pipefail
iface="$(bash cyfer_blackhat_ghost_tor_elite.sh get-mobile-iface)"
if [[ -z "$iface" ]]; then
  echo "[!] No mobile network interface found."; exit 1
fi
newmac=$(openssl rand -hex 6 | sed 's/\(..\)/\1:/g; s/:$//')
su -c "ip link set $iface down"
su -c "ip link set $iface address $newmac"
su -c "ip link set $iface up"
echo "[+] Spoofed: $iface as $newmac"
