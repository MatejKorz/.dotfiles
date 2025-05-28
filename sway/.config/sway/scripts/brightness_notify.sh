#!/usr/bin/env bash

NOTIF_ID_FILE="/tmp/dunst_brightness_id"

if [ -f "$NOTIF_ID_FILE" ]; then
    NOTIF_ID=$(cat "$NOTIF_ID_FILE")
else
    NOTIF_ID=0
fi

if [[ $1 == "up" ]]; then
    DATA=$(brightnessctl s +10%)
elif [[ $1 == "down" ]]; then
    DATA=$(brightnessctl s 10%-)
else
    echo "No input provided"
    exit 1
fi

if [[ $DATA =~ \(([0-9]+)%\) ]]; then
    PERCENTAGE="${BASH_REMATCH[1]}"
    NEW_ID=$(notify-send -p -u low -h int:value:"$PERCENTAGE" -h string:x-dunst-stack-tag:brightness "Brightness" "$PERCENTAGE%")
fi

echo "$NEW_ID" > "$NOTIF_ID_FILE"
