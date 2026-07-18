#!/usr/bin/env bash

set -euo pipefail

if [[ $# -eq 0 ]]; then
    GAME_DIR="$PWD"
else
    GAME_DIR="$(realpath "$1")"
fi

CONFIG="$GAME_DIR/game.conf"

if [[ ! -f "$CONFIG" ]]; then
    echo "game.conf not found:"
    echo "  $CONFIG"
    exit 1
fi

source "$CONFIG"

echo "Launching $GAME_NAME..."

export WINEPREFIX="$PREFIX"

[[ -n "${WINEDLLOVERRIDES:-}" ]] && export WINEDLLOVERRIDES

(
    cd "$WINEPREFIX/drive_c/$INSTALLED_GAME_DIR"
    wine $EXECUTABLE
)
