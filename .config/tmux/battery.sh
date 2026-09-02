#!/usr/bin/env bash
cap=$(cat /sys/class/power_supply/BAT*/capacity 2>/dev/null | head -1)
status=$(cat /sys/class/power_supply/BAT*/status 2>/dev/null | head -1)

charging=0
if [ "$status" = "Charging" ]; then
  charging=1
fi

# WSL has no /sys/class/power_supply battery node; ask Windows instead.
# Cache the reading (shared across all tmux sessions/windows) and cap the
# call with a timeout - powershell.exe over WSL interop occasionally hangs,
# which would otherwise block this script and freeze the status bar forever.
cache="${TMPDIR:-/tmp}/tmux-battery.cache"
if [ -z "$cap" ] && command -v powershell.exe >/dev/null 2>&1; then
  now=$(date +%s)
  cached_at=0
  cached_cap=""
  cached_charging=0
  if [ -f "$cache" ]; then
    read -r cached_at cached_cap cached_charging < "$cache"
  fi
  if [ -n "$cached_cap" ] && [ $(( now - cached_at )) -lt 15 ]; then
    cap=$cached_cap
    charging=$cached_charging
  else
    fresh=$(timeout 3 powershell.exe -NoProfile -Command '
      $b = Get-WmiObject -Class Win32_Battery
      $s = Get-WmiObject -Class BatteryStatus -Namespace root/wmi
      if ($b) { "$($b.EstimatedChargeRemaining) $([int]$s.Charging) $($b.BatteryStatus)" }
    ' 2>/dev/null | tr -d '\r')
    if [ -n "$fresh" ]; then
      read -r cap charging battstatus <<< "$fresh"
      # $s.Charging goes false once the battery tops off near 100%, even
      # though it's still on AC - Win32_Battery.BatteryStatus 2 (AC Power)
      # and 3 (Fully Charged) catch that "plugged in, done charging" state
      # so the bolt doesn't disappear right when the battery finishes.
      if [ "$battstatus" = "2" ] || [ "$battstatus" = "3" ]; then
        charging=1
      fi
      printf '%s %s %s\n' "$now" "$cap" "$charging" > "$cache"
    elif [ -n "$cached_cap" ]; then
      cap=$cached_cap
      charging=$cached_charging
    fi
  fi
fi

track_color="#585b70" # thm_surface_2 - faded, empty track

if [ -z "$cap" ]; then
  printf '#[fg=%s]──────────#[fg=default]' "$track_color"
  exit 0
fi

# catppuccin mocha tier colors, same ramp as the rest of the bar
if [ "$cap" -ge 65 ]; then
  fill_color="#a6e3a1" # thm_green
elif [ "$cap" -ge 35 ]; then
  fill_color="#f9e2af" # thm_yellow
elif [ "$cap" -ge 15 ]; then
  fill_color="#fab387" # thm_peach
else
  fill_color="#f38ba8" # thm_red
fi

# 10-cell bar using box-drawing horizontal lines instead of partial-height
# blocks: the eighths blocks (▁▂▃▄) are bottom-anchored by Unicode design,
# which floated out of vertical alignment with the wifi dot; box-drawing
# lines are vertically centered in the cell in virtually every monospace
# font, so this lines up with the dot instead.
cells=10
filled=$(( (cap * cells + 50) / 100 ))
bar=""
i=0
while [ $i -lt $cells ]; do
  if [ $i -lt $filled ]; then
    bar="${bar}#[fg=${fill_color},bold]━"
  else
    bar="${bar}#[fg=${track_color},nobold]─"
  fi
  i=$((i + 1))
done

bolt=""
if [ "$charging" -eq 1 ]; then
  bolt=" #[fg=${fill_color}]"
fi

printf '%s%s#[fg=default,nobold]' "$bar" "$bolt"
