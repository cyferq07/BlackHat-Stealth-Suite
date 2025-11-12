#!/data/data/com.termux/files/usr/bin/bash
set -euo pipefail
SECURE_DNS_SERVERS=( "1.1.1.1" "8.8.8.8" "9.9.9.9" "208.67.222.222" "185.228.168.168" "76.76.19.19" )
DNSFAKE="123.123.123.123" # Example
dns_rand="${SECURE_DNS_SERVERS[$RANDOM % ${#SECURE_DNS_SERVERS[@]}]}"
su -c "setprop net.dns1 $dns_rand"
su -c "setprop net.dns2 8.8.4.4"
echo "[*] DNS chained (system): $dns_rand"
echo -e "123.123.123.123\tfacebook.com" | su -c 'cat >> /system/etc/hosts'
echo "[+] /system/etc/hosts updated (facebook.com => $DNSFAKE)"
