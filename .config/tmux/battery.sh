#!/usr/bin/env bash
cap=$(cat /sys/class/power_supply/BAT*/capacity 2>/dev/null | head -1)
status=$(cat /sys/class/power_supply/BAT*/status 2>/dev/null | head -1)

if [ -z "$cap" ]; then
  printf '?%%'
  exit 0
fi

if [ "$cap" -ge 90 ]; then
  icon=""
  color="colour2"
elif [ "$cap" -ge 65 ]; then
  icon=""
  color="colour2"
elif [ "$cap" -ge 35 ]; then
  icon=""
  color="colour3"
elif [ "$cap" -ge 15 ]; then
  icon=""
  color="colour208"
else
  icon=""
  color="colour1"
fi

charge_suffix=""
if [ "$status" = "Charging" ]; then
  charge_suffix=" #[fg=colour3]#[fg=default]"
fi

printf '#[fg=%s]%s %s%%#[fg=default]%s' "$color" "$icon" "$cap" "$charge_suffix"
