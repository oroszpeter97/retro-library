#!/usr/bin/env bash

set -euo pipefail

if [[ $# -eq 0 ]]; then
    GAME_DIR="$PWD"
else
    GAME_DIR="$(realpath "$1")"
fi

CONFIG="$GAME_DIR/game.conf"

if [[ ! -f "$CONFIG" ]]; then
    echo "game.conf not found."
    exit 1
fi

source "$CONFIG"

echo "== $GAME_NAME =="

export WINEPREFIX="$PREFIX"

export WINEDLLOVERRIDES

echo "Running installer..."

wine "$MOUNT_POINT/$INSTALLER" $INSTALL_ARGS

echo

echo "Installation completed."

POST_INSTALL="$GAME_DIR/post-install.sh"

if [[ -x "$POST_INSTALL" ]]; then
    echo
    echo "Running post-install script..."
    export GAME_NAME
    export INSTALLER
    export INSTALLED_GAME_DIR
    export EXECUTABLE
    export WINEDLLOVERRIDES
    export INSTALL_ARGS
    "$POST_INSTALL"
fi

echo "Done."
