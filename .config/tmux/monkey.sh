#!/usr/bin/env bash
# ASCII monkey that hangs from the top-right corner of the tmux client.
#
#   monkey.sh peek [seconds]  swing down, hang about a moment, climb back up
#   monkey.sh hang            swing down and stay until a key is pressed
#
# Runs inside `tmux display-popup`; see the monkey bindings in tmux.conf.
# Any keypress sends it back up the vine early.

set -uo pipefail

mode=${1:-peek}
linger=${2:-1.6}

E=$'\033'
VINE="${E}[38;5;107m"
FUR="${E}[38;5;180m"
OFF="${E}[0m"

BRANCH="~~~~~~~~~~~~~~~~~~~"

# Draw the first <rows> rows of the scene: branch, vine, then the monkey.
# <swing> shifts the body sideways to fake a swing, <pose> swaps in a wave.
scene() {
	local rows=$1 swing=${2:-0} pose=${3:-idle}
	local arms='\|/' face='(o . o)' chin='\_-_/' legs='/   \' feet="''   ''"
	[ "$pose" = wave ] && { arms='\|  ~'; face='(o . -)'; }

	local out=()
	out+=("${VINE}${BRANCH}${OFF}")
	out+=("$(printf '%s%*s|%s' "$VINE" 11 '' "$OFF")")
	out+=("$(printf '%s%*s%s%s' "$FUR" $((10 + swing)) '' "$arms" "$OFF")")
	out+=("$(printf '%s%*s%s%s' "$FUR" $((8 + swing)) '' "$face" "$OFF")")
	out+=("$(printf '%s%*s%s%s' "$FUR" $((9 + swing)) '' "$chin" "$OFF")")
	out+=("$(printf '%s%*s%s%s' "$FUR" $((9 + swing)) '' "$legs" "$OFF")")
	out+=("$(printf '%s%*s%s%s' "$FUR" $((8 + swing)) '' "$feet" "$OFF")")

	printf '%s[H%s[2J' "$E" "$E"
	local i
	for ((i = 0; i < rows && i < ${#out[@]}; i++)); do
		printf '%s[%d;1H%s' "$E" $((i + 1)) "${out[i]}"
	done
}

# Sleep, but let any keypress cut the visit short.
nap() {
	if [ -t 0 ]; then
		read -rsn1 -t "$1" && return 1
	else
		sleep "$1"
	fi
	return 0
}

printf '%s[?25l' "$E"
trap 'printf "%s[?25h" "$E"' EXIT

for rows in 2 3 4 5 6 7; do
	scene "$rows"
	nap 0.09 || exit 0
done

case $mode in
hang)
	swing=(0 1 1 0 -1 -1)
	i=0
	while :; do
		pose=idle
		[ $((i % 11)) -eq 5 ] && pose=wave
		scene 7 "${swing[i % 6]}" "$pose"
		nap 0.22 || break
		i=$((i + 1))
	done
	;;
*)
	for s in 0 1 1 0 -1 -1 0; do
		scene 7 "$s"
		nap 0.18 || exit 0
	done
	scene 7 0 wave
	nap 0.5 || exit 0
	scene 7 0
	nap "$linger" || exit 0
	;;
esac

for rows in 6 5 4 3 2 1; do
	scene "$rows"
	nap 0.07 || exit 0
done
