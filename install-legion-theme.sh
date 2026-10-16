#!/usr/bin/env bash
set -euo pipefail
SRC="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
DST="/boot/grub2/themes/legion"
STAMP="$(date +%Y%m%d-%H%M%S)"
BACKUP="/boot/grub2/themes/legion-backup-$STAMP"

if [[ $EUID -ne 0 ]]; then
  echo "Run with sudo: sudo $0"
  exit 1
fi

echo "== Installing Legion GRUB theme =="

if [[ -d "$DST" ]]; then
  cp -a "$DST" "$BACKUP"
  echo "Backup: $BACKUP"
fi

# Remove only the temporary Legion-specific font loader from earlier troubleshooting.
if [[ -f /etc/grub.d/05_legion_fonts ]] && \
   grep -q 'legion-mono-18.pf2' /etc/grub.d/05_legion_fonts; then
  cp -a /etc/grub.d/05_legion_fonts "/etc/grub.d/05_legion_fonts.backup-$STAMP"
  rm -f /etc/grub.d/05_legion_fonts
fi

rm -rf "$DST"
mkdir -p "$DST/select"
install -m 0644 "$SRC/background.png" "$DST/background.png"
install -m 0644 "$SRC/theme.txt" "$DST/theme.txt"
install -m 0644 "$SRC"/select/*.png "$DST/select/"

if grep -q '^GRUB_GFXMODE=' /etc/default/grub; then
  sed -i 's/^GRUB_GFXMODE=.*/GRUB_GFXMODE=2560x1600,1920x1200,auto/' /etc/default/grub
else
  echo 'GRUB_GFXMODE=2560x1600,1920x1200,auto' >> /etc/default/grub
fi

if grep -q '^GRUB_THEME=' /etc/default/grub; then
  sed -i 's|^GRUB_THEME=.*|GRUB_THEME="/boot/grub2/themes/legion/theme.txt"|' /etc/default/grub
else
  echo 'GRUB_THEME="/boot/grub2/themes/legion/theme.txt"' >> /etc/default/grub
fi

# Match the design: show the menu indefinitely instead of auto-booting.
if grep -q '^GRUB_TIMEOUT_STYLE=' /etc/default/grub; then
  sed -i 's/^GRUB_TIMEOUT_STYLE=.*/GRUB_TIMEOUT_STYLE=menu/' /etc/default/grub
else
  echo 'GRUB_TIMEOUT_STYLE=menu' >> /etc/default/grub
fi

if grep -q '^GRUB_TIMEOUT=' /etc/default/grub; then
  sed -i 's/^GRUB_TIMEOUT=.*/GRUB_TIMEOUT=-1/' /etc/default/grub
else
  echo 'GRUB_TIMEOUT=-1' >> /etc/default/grub
fi

grub2-mkconfig -o /boot/grub2/grub.cfg

echo
echo "Done. Fedora/Windows boot entries were not changed."
echo "Previous theme backup: $BACKUP"
