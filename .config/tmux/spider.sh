#!/usr/bin/env bash
# a tiny ascii spider, sized to match pet.sh's cat (same track width and
# glyph length), bouncing on its own independent phase/offset

track=18
spider='}{o}{'
crawl='{}o{}'
spiderlen=${#spider}
range=$((track - spiderlen))

now=$(( $(date +%s) + 5 ))
period=$((2 * range))
phase=$((now % period))
if [ "$phase" -le "$range" ]; then
  pos=$phase
  dir=1
else
  pos=$((period - phase))
  dir=0
fi

frame="$spider"
if [ "$dir" -eq 0 ]; then
  frame="$crawl"
fi

left=$(printf '%*s' "$pos" '')
right=$(printf '%*s' "$((range - pos))" '')

printf '#[fg=colour95]%s%s%s#[fg=default]' "$left" "$frame" "$right"
