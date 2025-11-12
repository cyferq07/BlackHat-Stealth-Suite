#!/data/data/com.termux/files/usr/bin/bash
# BlackHat Orbot (Guardian Project) VPN/Tor automation for Termux
set -euo pipefail
ORBOT_API_URL="http://127.0.0.1:6277"
ORBOT_APP="org.torproject.android"

get_orbot_status() { curl -s "$ORBOT_API_URL/status"; }
start_orbot() { am start -n "${ORBOT_APP}/.OrbotMainActivity"; sleep 3; am broadcast -a org.torproject.android.START_TOR; sleep 8; }
stop_orbot() { am broadcast -a org.torproject.android.STOP_TOR; sleep 4; }
get_socks_port() { curl -s "$ORBOT_API_URL/status" | awk -F':' '/SocksPort/ {gsub(",|\"| ","",$2); print $2}' | head -1; }
get_control_port() { curl -s "$ORBOT_API_URL/status" | awk -F':' '/ControlPort/ {gsub(",|\"| ","",$2); print $2}' | head -1; }
setup_proxychains() {
  local port="$(get_socks_port)"
  [ -z "$port" ] && echo "[!] Orbot SOCKS5 port not found! Is Orbot running?" && exit 1
  cat > "$HOME/.blackhat_proxychains.conf" <<EOF
strict_chain
proxy_dns
tcp_read_time_out 15000
tcp_connect_time_out 8000
[ProxyList]
socks5 127.0.0.1 $port
EOF
  echo "Proxychains config ready: $HOME/.blackhat_proxychains.conf (SOCKS5 $port)"
}
case "${1:-status}" in
  status) get_orbot_status ;;
  start) start_orbot ;;
  stop) stop_orbot ;;
  socks-port) get_socks_port ;;
  control-port) get_control_port ;;
  proxychains) setup_proxychains ;;
  *) echo "Usage: $0 [status|start|stop|socks-port|control-port|proxychains]" ;;
esac
