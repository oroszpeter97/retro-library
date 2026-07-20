#!/usr/bin/env bash

set -euo pipefail

# Mount point can be supplied as the first argument.
MOUNT_POINT="${1:-/mnt/cdrom}"

# Create the mount point if necessary.
sudo mkdir -p "$MOUNT_POINT"

# Mount the drive if nothing is currently mounted there.
if ! mountpoint -q "$MOUNT_POINT"; then
    echo "Mounting /dev/sr0..."

    if ! sudo mount /dev/sr0 "$MOUNT_POINT"; then
        echo "Failed to mount DVD drive."
        exit 1
    fi
fi

export MOUNT_POINT

main_menu() {
    while true; do
        clear
        choice=$(gum choose \
        "Launch Game" \
        "Install Game" \
        "Setup OS" \
        "Configure" \
        "Exit")

        case "$choice" in
            "Launch Game") launch_menu ;;
            "Install Game") install_menu ;;
            "Setup OS") setup_os_menu ;;
            "Configure") config_menu ;;
            "Exit") exit 0 ;;
        esac
    done
}

launch_menu() {
    while true; do
        clear
        choice=$(gum choose \
        "Spore" \
        "Need for Speed - Most Wanted" \
        "Back")

        case "$choice" in
            "Spore") ./tools/launch.sh games/spore ;;
            "Need for Speed - Most Wanted") ./tools/launch.sh games/nfs-most-wanted ;;
            "Back") return ;;
        esac
    done
}

install_menu() {
    while true; do
        clear
        choice=$(gum choose \
        "Spore" \
        "Need for Speed Carbon" \
        "Back")

        case "$choice" in
            "Spore") ./tools/install.sh games/spore ;;
            "Need for Speed Carbon") ./tools/install.sh games/nfs-carbon ;;
            "Back") return ;;
        esac
    done
}

setup_os_menu() {
    while true; do
        clear
        choice=$(gum choose \
        "Windows XP" \
        "Back")

        case "$choice" in
            "Windows XP") ./setup/setup-xp-prefix.sh ;;
            "Back") return ;;
        esac
    done
}

config_menu() {
    while true; do
        clear
        choice=$(gum choose \
        "Back")

        case "$choice" in
            "Back") return ;;
        esac
    done
}

main_menu
