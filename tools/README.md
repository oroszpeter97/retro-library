# Install a game

## Requirements

- Windows XP Wine environment created.
- Original CD or ISO.
- Installer script from the repository.

---

## Installation

Run

```bash
tools/install.sh games/<game>
```

The installer will

- locate the ISO
- mount it
- launch the installer
- unmount the ISO automatically

Follow the installer as you would on a normal Windows XP machine.

---

# Launch a game

Run

```bash
tools/launch.sh games/<game>
```
