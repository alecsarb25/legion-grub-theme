LEGION FINAL GRUB THEME V6

This revision targets the Legion panel's native 2560x1600 geometry.

Fixes:
- selection border scales correctly to the baked Fedora/Windows cards
- actual hardware block:
    LEGION PRO 7 16IAX10H
    CORE ULTRA 9 275HX
    GEFORCE RTX 5080 MOBILE
- GRUB_GFXMODE prefers 2560x1600 with 1920x1200 and auto as fallbacks
- autoboot remains disabled

Install:
  sudo ./install-legion-theme.sh

Rollback:
  sudo ./restore-previous-theme.sh
