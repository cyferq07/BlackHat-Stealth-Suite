#!/data/data/com.termux/files/usr/bin/bash
# =====================================================
# CYFER BLACKHAT-GHOST-TOR-ELITE - For OxygenOS 15 / Android
# Author: cyferq07 | BlackHat Military-Grade Cloaking & Tor Elite Controller
# Features: Pure offensive toolkit, maximum stealth, aggressive anti-forensics, port randomization, silent persistent Tor/proxy ops.
# =====================================================
set -euo pipefail
IFS=$'\n\t'

#### Colors (Red/BlackThemed for ops)
GR="\033[1;32m"; RD="\033[1;31m"; BL="\033[0;30m"; Y="\033[0;33m"; CY="\033[1;36m"; RESET="\033[0m"
color() { [ $# -eq 2 ] && echo -e "${!1}${2}${RESET}" || echo "$2"; }
datefmt() { date -u +"%Y%m%d-%H%M%S"; }
OBFUSCATE_LOG=1; RAM_LOG=1; STEALTH_LOG=1; ANTI_MODE=1

LOG_SCRAMBLE="$HOME/.bkh_cache_$(openssl rand -hex 3).log"
JOURNAL_LOG="$HOME/.bk_journal.log"
TEMP_DIR="/dev/shm/bkh_ghost_tmp"
trap_cleanup() {
  su -c "logcat -c" 2>/dev/null
  history -c && > ~/.bash_history
  for f in $LOG_SCRAMBLE "$JOURNAL_LOG" ~/.bkh_* ~/.ghost_elite* ~/.sys_cache_*; do shred -u "$f" 2>/dev/null || rm -f "$f"; done
  find "$TEMP_DIR" -type f -exec shred -u {} \; 2>/dev/null
  rm -rf "$TEMP_DIR" 2>/dev/null
}
trap trap_cleanup EXIT SIGINT SIGTERM
log(){ 
  local m="$*"; [[ "$OBFUSCATE_LOG" -eq 1 ]] && m=$(echo "$m" | base64)
  [[ "$RAM_LOG" -eq 1 ]] && echo "[$(datefmt)] $m" >> "/dev/shm/bkh_ghost_ram.log"
  [[ "$STEALTH_LOG" -eq 1 ]] && echo "[$(datefmt)] $m" >> "$JOURNAL_LOG"
}

#### Aggressive Root Check
require_root() { 
  ! command -v su >/dev/null || ! su -c "id" >/dev/null 2>&1 && exit 0
}

#### Mobile Network Interface Detection
detect_mobile_iface() {
  local x=""
  if command -v ip >/dev/null; then
    for y in $(su -c "ip -o link show" | awk -F: '{print $2}' | tr -d ' '); do
      [[ $y =~ rmnet|ccmni|wwan|usb[0-9] ]] && x=$y && break
    done
  elif command -v ifconfig >/dev/null; then
    for y in $(su -c "ifconfig -a" | sed -n 's/:.*$//p'); do
      [[ $y =~ rmnet|ccmni|wwan ]] && x=$y && break
    done
  fi
  echo "$x"
}
show_ip_info() {
  local iface="$1"
  [ "$iface" != "" ] && color BL "$iface"
  local UA="Mozilla/5.0 (Android Hack)"
  curl -s --max-time 6 -A "$UA" https://ifconfig.me || true
}
iface_down_up() {
  local iface="$1"
  [ "$iface" = "" ] && return 1
  su -c "ifconfig $iface down"; sleep 1
  su -c "ifconfig $iface up"; sleep 2
}
svc_data_toggle() {
  su -c "svc data disable"; sleep 1
  su -c "svc data enable"; sleep 2
}
airplane_toggle() {
  su -c "svc airplane enable"; sleep 1
  su -c "svc airplane disable"; sleep 2
}
auto_full_refresh() {
  local iface; iface=$(detect_mobile_iface)
  svc_data_toggle; sleep 1
  iface=$(detect_mobile_iface)
  iface_down_up "$iface"
}

#### Ghost Tor Elite (randomized, silent, restart-on-fail, max stealth)
TOR_DATA_DIR="/dev/shm/bkh_ghost_elite_tor_data"
TORRC="/dev/shm/bkh_ghost_elite_torrc"
TOR_LOG="/dev/shm/bkh_ghost_elite_tor.log"
TOR_PIDFILE="/dev/shm/bkh_ghost_elite_tor.pid"
LOCKFILE="/dev/shm/bkh_ghost_elite.lock"
acquire_lock() {
  if [ -f "$LOCKFILE" ]; then local pid; pid=$(cat "$LOCKFILE" 2>/dev/null)
    if [ "$pid" != "" ] && kill -0 "$pid" 2>/dev/null; then exit 0; else rm -f "$LOCKFILE" 2>/dev/null; fi
  fi
  echo $$ > "$LOCKFILE"; trap 'rm -f "$LOCKFILE"; exit' INT TERM EXIT
}
release_lock() { rm -f "$LOCKFILE"; trap - INT TERM EXIT; }
find_free_port() {
  local min=13000 max=62000 tries=400; local p
  for _ in $(seq 1 $tries); do
    p=$((RANDOM % (max - min + 1) + min))
    ! netstat -lnt 2>/dev/null | awk '{print $4}' | grep -q -E ":$p$" && echo "$p" && return 0
  done
  return 1
}
detect_tor() {
  command -v tor >/dev/null 2>&1 && command -v tor && return 0
  [ -x "/system/bin/tor" ] && echo "/system/bin/tor" && return 0
  [ -x "/usr/bin/tor" ] && echo "/usr/bin/tor" && return 0
  return 1
}
write_configs() {
  local socks_port="$1" control_port="$2"
  mkdir -p "$TOR_DATA_DIR"
  cat > "$TORRC" <<EOF
DataDirectory $TOR_DATA_DIR
SocksPort 127.0.0.1:${socks_port}
ControlPort 127.0.0.1:${control_port}
CookieAuthentication 0
Log notice file ${TOR_LOG}
EOF
}
start_tor() {
  require_root
  acquire_lock
  local torbin; torbin=$(detect_tor) || { release_lock; return 1; }
  SOCKS_PORT=$(find_free_port) || { release_lock; return 1; }
  CONTROL_PORT=$(find_free_port) || { release_lock; return 1; }
  write_configs "$SOCKS_PORT" "$CONTROL_PORT"
  [ -f "$TOR_PIDFILE" ] && kill "$(cat "$TOR_PIDFILE")" 2>/dev/null && rm -f "$TOR_PIDFILE"
  nohup bash -c "
    $torbin -f $TORRC >> $TOR_LOG 2>&1 &
    echo \$! > $TOR_PIDFILE
    wait \$! || true
  " >/dev/null 2>&1 &
  sleep 3
  release_lock
}
stop_tor() {
  [ -f "$TOR_PIDFILE" ] && kill "$(cat "$TOR_PIDFILE")" 2>/dev/null && rm -f "$TOR_PIDFILE"
  pkill -f tor || true
}

rotate_ip() {
  local control_port; control_port=$(awk '/ControlPort/ {print $2}' "$TORRC" | sed 's/127.0.0.1://g')
  command -v nc >/dev/null || return 1
  printf 'AUTHENTICATE ""\r\nSIGNAL NEWNYM\r\nQUIT\r\n' | nc 127.0.0.1 "$control_port" | grep -q '250'
}

install_deps() {
  for p in curl tor netcat-openbsd; do
    command -v "$p" >/dev/null || (pkg install "$p" -y || apt-get install "$p" -y)
  done
}

#### CLI
usage() {
  cat <<EOF
BH 🌑 BlackHat-Ghost-Tor-Elite | Usage:
  install         Install dependencies
  ip-status       Show IP (minimal)
  refresh         Full IP switch
  tor-start       Stealth Tor (randomized ports)
  tor-stop        Kill Tor
  tor-rotate      NEWNYM
  cleanup         Aggressive cleanup
  help            This help screen
EOF
}

case "${1:-help}" in
  install) install_deps ;;
  ip-status) show_ip_info "$(detect_mobile_iface)" ;;
  refresh) auto_full_refresh ;;
  tor-start) start_tor ;;
  tor-stop) stop_tor ;;
  tor-rotate) rotate_ip ;;
  cleanup) trap_cleanup ;;
  help|*) usage ;;
esac
