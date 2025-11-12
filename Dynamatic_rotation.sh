#!/data/data/com.termux/files/usr/bin/bash
set -euo pipefail
ROTATE_INTERVAL="${1:-60}"
ROTATE_ROUNDS="${2:-0}"
CURRENT_ROUND=0
while [[ $ROTATE_ROUNDS -eq 0 || $CURRENT_ROUND -lt $ROTATE_ROUNDS ]]; do
  echo "[*] MAC Spoofing..."; bash mac_spoof.sh
  echo "[*] IP/data cycling..."; bash cyfer_blackhat_ghost_tor_elite.sh refresh
  echo "[*] DNS chaining/spoofing..."; bash dns_chain.sh
  echo "[*] Browser stealth..."; bash browser_stealth.sh "https://ipinfo.io/"
  CURRENT_ROUND=$((CURRENT_ROUND + 1))
  echo "[*] Round $CURRENT_ROUND complete. Waiting $ROTATE_INTERVAL seconds..."
  sleep $ROTATE_INTERVAL
done
