#!/usr/bin/env bash
set -euo pipefail

PREFIX="$HOME/.wine-gog"
PKGFILE="$(dirname "$0")/packages-gog"

log() {
    echo "[GOG-SETUP] $1"
}

log "Installing required Arch packages..."
sudo pacman -Sy --needed --noconfirm \
    $(grep -v '^\s*#' "$PKGFILE" | xargs)

log "Removing existing prefix..."
rm -rf "$PREFIX"

export WINEPREFIX="$PREFIX"

log "Creating Wine prefix..."
wineboot -u

log "Setting Windows version to Windows 10..."
winecfg -v win10 >/dev/null 2>&1 || true

log "Installing common Winetricks components..."

winetricks -q \
    corefonts \
    dxvk \
    d3dx9 \
    d3dcompiler_43 \
    d3dcompiler_47 \
    xact \
    xinput \
    vcrun2005 \
    vcrun2008 \
    vcrun2010 \
    vcrun2012 \
    vcrun2013 \
    vcrun2015-2022

log "Done."

echo
echo "Use with:"
echo "export WINEPREFIX=\"$PREFIX\""
echo "wine setup.exe"
