#!/bin/sh

# overlayfs check
if ! grep -q overlay /proc/filesystems > /dev/null 2>&1; then \
	abort "[!] OverlayFS is required for this module!"
fi

# skip mount
touch $MODPATH/skip_mount

# EOF
