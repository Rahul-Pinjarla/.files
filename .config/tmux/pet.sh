#!/usr/bin/env bash
# pet icon inside the "sess" pill on the sessions status line, nudging one
# character left/right each second -- swap the emoji below for a different
# one. Output is always 2 columns wide (1 pad + pet) so the pill and the
# session list next to it never jitter.

pet="🙀"

now=$(date +%s)
pos=$((now % 2))

left=$(printf '%*s' "$pos" '')
right=$(printf '%*s' "$((1 - pos))" '')

printf '%s%s%s' "$left" "$pet" "$right"
