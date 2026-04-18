#!/bin/bash

# OpenClaude Mobile Assistant - Hardware Control Toolkit
# This version uses ONLY Termux API for maximum compatibility across all Android devices.

VERSION="1.1.0"

# Colors
CYN='\033[1;36m'
MAG='\033[1;35m'
YLW='\033[1;33m'
RED='\033[1;31m'
GRN='\033[1;32m'
R='\033[0m'
DIM='\033[2m'

# Check if Termux API is installed
check_api_installed() {
    if ! command -v termux-battery-status &>/dev/null; then
        echo -e "${RED}❌ Error: Termux:API package not found!${R}"
        echo -e "Please run: ${YLW}pkg install termux-api${R}"
        echo -e "And ensure the 'Termux:API' app is installed from F-Droid/Play Store."
        exit 1
    fi
}

case "$1" in
    "status")
        check_api_installed
        echo -e "${CYN}--- System Status ---${R}"
        echo "Battery:"
        termux-battery-status | grep -E 'percentage|status'
        echo "WiFi:"
        termux-wifi-connectioninfo | grep -E 'ssid|supplicant_state'
        echo "Location:"
        termux-location -p network -r last | grep -E 'latitude|longitude'
        ;;

    "notify")
        check_api_installed
        termux-notification -t "AI Assistant" -c "$2" --priority high
        echo "Notification sent."
        ;;

    "camera_snap")
        check_api_installed
        out_file="${2:-photo.jpg}"
        echo "Taking photo to $out_file..."
        termux-camera-photo -c 0 "$out_file"
        echo "Photo saved: $out_file"
        ;;

    "vibrate")
        check_api_installed
        termux-vibrate -d ${2:-500}
        echo "Vibrated for ${2:-500}ms."
        ;;

    "speak")
        check_api_installed
        termux-tts-speak "$2"
        echo "Speech executed."
        ;;

    "wifi_toggle")
        check_api_installed
        # Note: Some Android versions restrict this via API
        termux-wifi-enable "$2"
        echo "WiFi toggle request sent."
        ;;

    "sms")
        check_api_installed
        termux-sms-send -n "$2" "$3"
        echo "SMS sent."
        ;;

    *)
        echo "Usage: bash mobile_tools.sh [command] [args...]"
        echo -e "${CYN}Available Commands:${R}"
        echo "  status       - Check battery, wifi, and location"
        echo "  notify       - Send a system notification"
        echo "  camera_snap   - Take a photo"
        echo "  vibrate      - Vibrate the device"
        echo "  speak        - Use Text-to-Speech"
        echo "  wifi_toggle  - Enable/Disable WiFi"
        echo "  sms          - Send an SMS"
        echo -e "\n${DIM}Note: This version is optimized for all devices and does not require Shizuku.${R}"
        ;;
esac
