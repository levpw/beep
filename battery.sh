#!/bin/bash

# Function to get battery percentage
get_battery_percentage() {
    upower -i $(upower -e | grep battery) | grep percentage | awk '{print $2}' | tr -d '%'
}

# Function to display a graphical battery bar
display_battery_bar() {
    local percentage=$(get_battery_percentage)
    local filled_slots=$((percentage / 2))  # Assuming bar width of 50
    local empty_slots=$((50 - filled_slots))

    # Create the filled part of the bar
    local bar=$(printf '#%.0s' $(seq 1 $filled_slots))
    
    # Append the empty part of the bar
    bar+=$(printf ' %.0s' $(seq 1 $empty_slots))

    echo "Battery: [$bar] $percentage%"
}

# Infinite loop to display battery level
while true; do
    clear
    display_battery_bar

    # Check for user input with a short timeout
    read -s -n 1 -t 2 input
    if [[ $input == "q" ]]; then
        break
    fi
done
