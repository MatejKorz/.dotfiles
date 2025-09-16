#!/usr/bin/env bash

GEOLOCATION_API_URL="https://geocoding-api.open-meteo.com/v1/search"
FORECATS_API_URL="https://api.open-meteo.com/v1/forecast"
CURRENT_FORECAST_VALS=("temperature_2m" "apparent_temperature" "weather_code" "rain" "wind_speed_10m" "precipitation" "surface_pressure" "cloud_cover")

get_geolocation_url() {
    local name="${1:-''}"
    local count="${2:-10}"

    echo "$GEOLOCATION_API_URL?name=${name}&count=${count}&language=en&format=json"
}

get_forecast_url() {
    local lat="${1:-'49.19'}"
    local long="${2:-'16.61'}"

    local url="$FORECATS_API_URL?latitude=${lat}&longitude=${long}&current="

    for val in "${CURRENT_FORECAST_VALS[@]}"; do
        url="$url$val,"
    done

    # remove last coma from url
    url=${url#","}

    echo $url
}

get_location_data() {
    local place=${1:-'Brno'}
    echo $(curl -s $(get_geolocation_url $place))
}

get_value_with_units() {
    local data="$1"
    local name="$2"
    jq -r "\"\(.current.$name)\\(.current_units.$name)\"" <<< "$data"
}

make_tooltip() {
    local data="$1"
    local tooltip=""
    for val in "${CURRENT_FORECAST_VALS[@]}"; do
        local line="$val: $(get_value_with_units "$data" "$val")"$'\n'
        line=${line//"_"/" "}
        tooltip+=${line^}
    done
    # jq '.' <<< "$data"
    echo "$tooltip"
}

make_output() {
    local data="$1"

    local temp=$(get_value_with_units "$data" "temperature_2m")
    local temp_feel=$(jq -r '.current.apparent_temperature' <<< "$data")
    local code=$(jq '.current.weather_code' <<< "$data")
    local tooltip=$(make_tooltip "$data")

    jq --unbuffered --compact-output -n \
        --arg temp "$temp" \
        --arg alt "$code" \
        --arg class "weather" \
        --arg tooltip "$tooltip" \
        '{text: $temp, alt: $alt, class: $class, tooltip: $tooltip}'
}

RESPONSE=$(get_location_data)

LAT=$(jq '.["results"][0]["latitude"]' <<< "$RESPONSE")
LONG=$(jq '.["results"][0]["longitude"]' <<< "$RESPONSE")

URL=$(get_forecast_url $LAT $LONG)
RESPONSE=$(curl -s $URL)

make_output "$RESPONSE"
