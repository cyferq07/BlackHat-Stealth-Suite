#!/data/data/com.termux/files/usr/bin/bash
set -euo pipefail
BROWSER_URL="${1:-https://ipinfo.io/}"
UAGENTS=(
  "Mozilla/5.0 (Linux; Android 14; SM-S918U) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/120.0.0.0 Mobile Safari/537.36"
  "Mozilla/5.0 (iPhone; CPU iPhone OS 17_0 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/17.0 Mobile/15E148 Safari/604.1"
  "Mozilla/5.0 (X11; Linux x86_64) Gecko/20100101 Firefox/121.0"
  "Mozilla/5.0 (Macintosh; Intel Mac OS X 14_0) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/120.0.0.0 Safari/537.36"
  "Mozilla/5.0 (Windows NT 10.0; Win64; x64) Gecko/20100101 Firefox/120.0"
  "Mozilla/5.0 (X11; Ubuntu; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko)"
)
RUA="${UAGENTS[$RANDOM % ${#UAGENTS[@]}]}"
LOGF="$HOME/.bkh_browser_stealth.log"
echo "[*] Randomized User-Agent: $RUA" | tee -a "$LOGF"
if command -v termux-open-url >/dev/null; then
  am start -a android.intent.action.VIEW -d "$BROWSER_URL" --es "User-Agent" "$RUA"
  echo "[+] Browser opened (mobile intent) via random user-agent." | tee -a "$LOGF"
else
  am start -a android.intent.action.VIEW -d "$BROWSER_URL"
  echo "[+] Browser opened (classic intent)." | tee -a "$LOGF"
fi
