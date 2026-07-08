#!/bin/sh
# Lightweight net speed for tmux status: reads sysfs counters (no polling/sleep),
# diffs against the last reading stored in a state file to compute rate.
state="/tmp/.tmux_netspeed_state"

iface=$(ip route show default 2>/dev/null | awk '{print $5; exit}')

if [ -z "$iface" ] || [ ! -d "/sys/class/net/$iface" ]; then
  printf ''
  exit 0
fi

rx=$(cat "/sys/class/net/$iface/statistics/rx_bytes" 2>/dev/null)
tx=$(cat "/sys/class/net/$iface/statistics/tx_bytes" 2>/dev/null)
now=$(date +%s)

if [ -f "$state" ]; then
  read -r prev_time prev_rx prev_tx < "$state"
else
  prev_time=$now
  prev_rx=$rx
  prev_tx=$tx
fi

printf '%s %s %s\n' "$now" "$rx" "$tx" > "$state"

dt=$((now - prev_time))
[ "$dt" -le 0 ] && dt=1

rx_rate=$(( (rx - prev_rx) / dt / 1024 ))
tx_rate=$(( (tx - prev_tx) / dt / 1024 ))
[ "$rx_rate" -lt 0 ] && rx_rate=0
[ "$tx_rate" -lt 0 ] && tx_rate=0

printf ' %dKB/s  %dKB/s' "$rx_rate" "$tx_rate"
