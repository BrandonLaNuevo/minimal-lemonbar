#!/bin/bash

DELAY=0.2

while true; do
    output="";

    # Center Align
    output="${output}%{c}"

    # Right Align
    output="${output}%{r} "

    # Left Align
    output="${output}%{l} "

    # Wifi
    essid=$(iwgetid | cut -d \" -f 2)
    if [[ "$essid" != "" ]]; then
    output="${output}net %{F#505050}$(iwconfig wlp2s0 | grep Quality | cut -d = -f 2 | cut -d / -f 1)%"
    fi


    # Center Align
    output="${output}%{c}"

    # Volume
    master="$(amixer | head -1 | cut -d "'" -f 2)"
    output="${output}%{A4:amixer -q sset ${master} 1%+:}%{A5:amixer -q sset ${master} 1%-:}"
    output="${output}%{F#888888}vol %{F#505050}$(amixer get ${master} | tail -1 | cut -d \[ -f 2 | cut -d \] -f 1)"
    output="${output}"

    # Padding between Volume and Battery life
    output="${output} "

    # Battery
    output="${output}%{F#888888}batt%{F#505050} $(acpi | cut -d , -f 2 | cut -d " " -f 2)"


    # Right Align
    output="${output}%{r} "
    # Time
    time=$(date | cut -d " " -f 5)
    output="${output}%{F#888888}%{F#505050}${time//:/%\{F\#888888\}:%\{F\#505050\}}"

    echo " ${output} ";sleep $DELAY;
done | lemonbar -f "DejaVu Sans Mono:size=8" -d -g 220x20+845+1052 -B \#ffffff -F \#888888 | /bin/zsh

