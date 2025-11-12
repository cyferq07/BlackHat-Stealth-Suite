#!/data/data/com.termux/files/usr/bin/bash
set -euo pipefail
echo "[*] Killing previous stealth processes/cleanup..."
bash cyfer_blackhat_ghost_tor_elite.sh cleanup
echo "[*] Starting Orbot Tor (system VPN)..."
bash orbot_control.sh start
sleep 7
bash orbot_control.sh proxychains
echo "[*] Dynamic rotating session (interval=90s unlimited)..."
bash dynamic_rotation.sh 90 0 &
trap "bash cyfer_blackhat_ghost_tor_elite.sh cleanup; bash orbot_control.sh stop" EXIT SIGINT SIGTERM
echo "[+] Full BlackOps module is active!"
while true; do sleep 300; done
