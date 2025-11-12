#!/data/data/com.termux/files/usr/bin/bash
echo "[*] Installing dependencies for BlackHat Stealth Suite..."

# For Termux/Android (root required)
pkg update -y && pkg upgrade -y
for p in curl tor netcat-openbsd python proxychains dnsspoof; do
  if ! command -v $p >/dev/null 2>&1; then
    pkg install -y $p || apt install -y $p
  fi
done

echo "[+] Installation complete. Ready to go!"
