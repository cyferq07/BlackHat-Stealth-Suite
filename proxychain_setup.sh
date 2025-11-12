#!/data/data/com.termux/files/usr/bin/bash
# Proxychains dynamic config for Tor/Blackhat operations (Termux/Android)
set -euo pipefail
PROXYCHAINS_CONF="$HOME/.blackhat_proxychains.conf"
SOCKS_PORT="$(bash cyfer_blackhat_ghost_tor_elite.sh get-random-socks-port)"
cat > "$PROXYCHAINS_CONF" <<EOF
strict_chain
proxy_dns
tcp_read_time_out 15000
tcp_connect_time_out 8000
[ProxyList]
socks5 127.0.0.1 $SOCKS_PORT
EOF
echo "Proxychains config created: $PROXYCHAINS_CONF"
