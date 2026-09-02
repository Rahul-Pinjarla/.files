#!/usr/bin/env bash
hm=$(TZ=Asia/Kolkata date +%H:%M)
wd=$(TZ=Asia/Kolkata date +%a)
day=$(TZ=Asia/Kolkata date +%d)
mo=$(TZ=Asia/Kolkata date +%b)

# catppuccin mocha: @thm_surface_0 pill on @thm_lavender text, fading in from
# the bar's own background (colour234) via increasing shade-block density
# instead of a hard divider.
bar_bg="colour234"
pill_bg="#313244"
text_fg="#b4befe"

# wifi state, folded into the right end of the pill so it shares its
# background instead of floating on the bar's own bg. Same up/down check
# and cache as wifi.sh - duplicated since each status script here is
# self-contained.
dot="●"
state=""
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

case "$state" in
  up) dot_color="#39FF14" ;;
  down) dot_color="#FF3131" ;;
  *) dot_color="colour244" ;;
esac

printf '#[fg=%s,bg=%s]░▒▓#[fg=%s,bg=%s] %s %s %s-%s #[fg=%s,bg=%s,bold]%s#[fg=%s,bg=%s,nobold] #[fg=default,bg=default]' \
  "$pill_bg" "$bar_bg" "$text_fg" "$pill_bg" "$hm" "$wd" "$day" "$mo" \
  "$dot_color" "$pill_bg" "$dot" "$text_fg" "$pill_bg"
