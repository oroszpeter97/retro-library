# Windows XP Wine Prefix Setup

## Files
- `setup-xp-prefix.sh` – installs dependencies and recreates a Windows XP Wine prefix at `$HOME/.wine-xp`.
- `packages` – package list passed to `pacman`. Edit this file to add/remove Arch packages.

## Usage

```bash
chmod +x setup-xp-prefix.sh
./setup-xp-prefix.sh
```

The script always recreates the prefix by deleting any existing `$HOME/.wine-xp`.

To install a game follow the game installation guide [here](../tools/README.md)

## Notes

- Uses a 64-bit Wine prefix (`WINEARCH=wow64`).
- Targets Windows XP.
- Installs common DirectX 9, Visual C++ runtimes, XAudio, and Core Fonts using Winetricks.
- You can update the `packages` file as Arch package names change.
