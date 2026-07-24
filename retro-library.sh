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

################################################################################
# Build game database
################################################################################

echo "Build game database..."

declare -A GAMES

while IFS= read -r conf; do
    echo "Loading $conf"

    source "$conf"

    GAMES["$GAME_NAME"]="$(dirname "$conf")"
done < <(find games -mindepth 2 -maxdepth 2 -name game.conf | sort)

echo "Database built!"

################################################################################
# Menus
################################################################################

main_menu() {
    while true; do
        choice=$(gum choose \
            "Games" \
            "Wine Prefixes" \
            "Exit")

        case "$choice" in
            "Games")
                games_menu
                ;;

            "Wine Prefixes")
                prefixes_menu
                ;;

            "Exit")
                exit 0
                ;;
        esac
    done
}

games_menu() {
    while true; do
        options=()

        while IFS= read -r name; do
            options+=("$name")
        done < <(printf "%s\n" "${!GAMES[@]}" | sort)

        options+=("Back")

        choice=$(printf "%s\n" "${options[@]}" | gum choose)

        [[ "$choice" == "Back" ]] && return

        game_menu "${GAMES[$choice]}"
    done
}

game_menu() {
    local game_dir="$1"

    source "$game_dir/game.conf"

    while true; do
        choice=$(gum choose \
            "Launch" \
            "Install" \
            "Back")

        case "$choice" in
            "Launch")
                ./tools/launch.sh "$game_dir"
                ;;

            "Install")
                ./tools/install.sh "$game_dir"
                ;;

            "Back")
                return
                ;;
        esac
    done
}

prefixes_menu() {
    while true; do
        choice=$(gum choose \
            "Windows XP" \
            "Windows GoG" \
            "Back")

        case "$choice" in
            "Windows XP")
                ./setup/setup-xp-prefix.sh
                ;;

            "Windows GoG")
                ./setup/setup-gog-prefix.sh
                ;;

            "Back")
                return
                ;;
        esac
    done
}

################################################################################
# Start
################################################################################

main_menu
