#!/usr/bin/env bash
set -euo pipefail
if [[ $EUID -ne 0 ]]; then
  echo "Run with sudo: sudo $0"
  exit 1
fi
LATEST="$(ls -1dt /boot/grub2/themes/legion-backup-* 2>/dev/null | head -n1 || true)"
[[ -n "$LATEST" ]] || { echo "No backup found."; exit 1; }
rm -rf /boot/grub2/themes/legion
cp -a "$LATEST" /boot/grub2/themes/legion
grub2-mkconfig -o /boot/grub2/grub.cfg
echo "Restored: $LATEST"
