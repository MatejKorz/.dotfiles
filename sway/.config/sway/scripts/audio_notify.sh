#!/usr/bin/env bash

NOTIF_ID_FILE="/tmp/dunst_audio_id"

if [ -f "$NOTIF_ID_FILE" ]; then
    NOTIF_ID=$(cat "$NOTIF_ID_FILE")
else
    NOTIF_ID=0
fi

if [[ $1 == "up" ]]; then
    $(wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ 5%+)
elif [[ $1 == "down" ]]; then
    $(wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-)
elif [[ $1 == "toggle" ]]; then
    $(wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle)
elif [[ $1 == "toggle-source" ]]; then
    $(wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle)
else
    echo "No input provided"
    exit 1
fi

DATA=$(wpctl get-volume @DEFAULT_AUDIO_SINK@)

if [[ $DATA =~ (MUTED)+ ]]; then
    STATUS='muted'
else
    STATUS=''
fi

if [[ $DATA =~ ([0-9].[0-9][0-9])+ ]]; then
    VOLUME=${BASH_REMATCH[1]}
    INTEGER_PART="${VOLUME%%.*}"
    DECIMAL_PART="${VOLUME##*.}"
    PERCENTAGE=$(( INTEGER_PART * 100 + DECIMAL_PART))
    NEW_ID=$(notify-send -p -u low -h int:value:"$PERCENTAGE" -h string:x-dunst-stack-tag:audio "Volume" "$PERCENTAGE% $STATUS")
fi

echo "$NEW_ID" > "$NOTIF_ID_FILE"
