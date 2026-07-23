#!/usr/bin/env bash
set -euo pipefail
PREFIX="$HOME/.wine-xp"
PKGFILE="$(dirname "$0")/packages-winxp"
log(){ echo "[XP-SETUP] $1"; }
log "Synchronizing package databases..."
sudo pacman -Sy --needed --noconfirm $(grep -v '^#' "$PKGFILE"|xargs)
log "Creating 32-bit Wine prefix at $PREFIX"
export WINEPREFIX="$PREFIX"
rm -rf "$PREFIX"
wineboot -u
log "Configuring Windows XP mode"
winecfg -v winxp >/dev/null 2>&1 || true
log "Installing common runtime components"
winetricks -q corefonts d3dx9 xact vcrun2005 vcrun2008 vcrun2010
log "Finished."
echo "Use: export WINEPREFIX=\"$PREFIX\" && wine program.exe"
