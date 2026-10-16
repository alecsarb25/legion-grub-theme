# Lenovo Legion GRUB2 Theme

Custom GRUB2 boot-menu theme created for a **Lenovo Legion Pro 7 16IAX10H** running a Fedora/Windows dual-boot setup. Designed around the laptop's native **2560 × 1600** display, with custom Fedora and Windows selection graphics.

> **Portfolio / personal system customization.** This project is a GRUB theme, **not a replacement boot manager**. The scripts are hardware- and Fedora-specific and should be reviewed before use.

## Project highlights

- Native 2560 × 1600 layout with 1920 × 1200 and automatic graphics-mode fallbacks
- Custom background and nine-slice selection-border assets
- Two operating-system cards (Fedora and Windows), with a custom selection treatment
- Bash installer that backs up an existing Legion theme before replacing its files
- Companion script that can restore the most recently backed-up **theme directory**

## Preview

Preview images from the original design will be added here once uploaded.

## Project files

- [`theme.txt`](./theme.txt) — GRUB2 theme layout and styling
- [`install-legion-theme.sh`](./install-legion-theme.sh) — Fedora-specific installation script
- [`restore-previous-theme.sh`](./restore-previous-theme.sh) — theme-directory restore script
- `background.png` and `select/selected_*.png` — visual assets (to be uploaded)

## Target hardware

- Lenovo Legion Pro 7 16IAX10H
- Intel Core Ultra 9 275HX
- NVIDIA GeForce RTX 5080 Laptop GPU
- Fedora Linux + Windows dual boot

The design is tuned to this display and GRUB setup. Other machines are **not tested**.

## Installation and recovery caveats

**Do not run the installation script until all referenced image assets have been uploaded and you have inspected its operations.** These scripts require root access and can affect system boot behavior.

The installer copies files to `/boot/grub2/themes/legion`, modifies `/etc/default/grub` (including graphics mode, theme path, and disabling automatic boot), and runs `grub2-mkconfig -o /boot/grub2/grub.cfg`. It also conditionally removes a particular older Legion font-loader script after backing it up.

Although it backs up an existing theme directory, the restore script **only restores that directory and regenerates GRUB configuration**. It does *not* restore the previous `/etc/default/grub` settings or the removed font-loader script. It is **not a full rollback**. Make a separate backup of your GRUB configuration and have a recovery method available before experimenting with bootloader changes.

## Engineering focus

This project illustrates Linux configuration management, Bash scripting, interface customization, resolution-aware layout design, and awareness of backup/restore limitations.

## Disclaimer

Independent personal customization, not affiliated with or endorsed by Lenovo, Fedora, Microsoft, or their respective trademark owners.
