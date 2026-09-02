#!/usr/bin/env bash
# a tiny ascii cat that bounces back and forth in a fixed-width track,
# sitting in the blank gap between the window list and status-right.
# it goes wide-eyed ("o") when it comes near spider.sh's position.

track=18
pet="=^.^="
blink="=^o^="
alert="=^o^="
petlen=${#pet}
range=$((track - petlen))

now=$(date +%s)
period=$((2 * range))
phase=$((now % period))
if [ "$phase" -le "$range" ]; then
  pos=$phase
  dir=1
else
  pos=$((period - phase))
  dir=0
fi

# mirror spider.sh's position math (same track/glyph length, +5s offset)
spider_now=$((now + 5))
spider_range=$((18 - 5))
spider_period=$((2 * spider_range))
spider_phase=$((spider_now % spider_period))
if [ "$spider_phase" -le "$spider_range" ]; then
  spider_pos=$spider_phase
else
  spider_pos=$((spider_period - spider_phase))
fi

dist=$((pos - spider_pos))
if [ "$dist" -lt 0 ]; then
  dist=$((-dist))
fi

frame="$pet"
if [ "$dist" -le 2 ]; then
  frame="$alert"
elif [ $(((now / 2) % 5)) -eq 0 ]; then
  frame="$blink"
fi
if [ "$dir" -eq 0 ]; then
  # walking back left, mirror the face
  frame=$(printf '%s' "$frame" | rev)
fi

left=$(printf '%*s' "$pos" '')
right=$(printf '%*s' "$((range - pos))" '')

printf '#[fg=colour215]%s%s%s#[fg=default]' "$left" "$frame" "$right"
