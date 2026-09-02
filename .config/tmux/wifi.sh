#!/usr/bin/env bash
# Wi-Fi connected/disconnected indicator: a bold solid dot, neon green/red
# by state. A ring/border can't reliably be made bolder (thin stroke, font
# weight dependent), so this drops the border in favor of a solid glyph.

dot="●"
state=""

# native path: any /sys wireless interface with operstate "up"
for w in /sys/class/net/*/wireless; do
  [ -d "$w" ] || continue
  iface=$(dirname "$w")
  op=$(cat "$iface/operstate" 2>/dev/null)
  if [ "$op" = "up" ]; then
    state="up"
  else
    state="down"
  fi
  break
done

# WSL has no wireless netdev; ask Windows instead. Cached + timed out the
# same way battery.sh is, since powershell.exe over WSL interop can hang.
cache="${TMPDIR:-/tmp}/tmux-wifi.cache"
if [ -z "$state" ] && command -v powershell.exe >/dev/null 2>&1; then
  now=$(date +%s)
  cached_at=0
  cached_state=""
  if [ -f "$cache" ]; then
    read -r cached_at cached_state < "$cache"
  fi
  if [ -n "$cached_state" ] && [ $(( now - cached_at )) -lt 15 ]; then
    state=$cached_state
  else
    fresh=$(timeout 3 powershell.exe -NoProfile -Command \
      "(Get-NetAdapter -Name 'Wi-Fi' -ErrorAction SilentlyContinue).Status" \
      2>/dev/null | tr -d '\r')
    if [ "$fresh" = "Up" ]; then
      state="up"
      printf '%s %s\n' "$now" "$state" > "$cache"
    elif [ -n "$fresh" ]; then
      state="down"
      printf '%s %s\n' "$now" "$state" > "$cache"
    elif [ -n "$cached_state" ]; then
      state=$cached_state
    fi
  fi
fi

if [ -z "$state" ]; then
  printf '#[fg=colour244,bold]%s?#[fg=default,nobold]' "$dot"
  exit 0
fi

if [ "$state" = "up" ]; then
  printf '#[fg=#39FF14,bold]%s#[fg=default,nobold]' "$dot"
else
  printf '#[fg=#FF3131,bold]%s#[fg=default,nobold]' "$dot"
fi
