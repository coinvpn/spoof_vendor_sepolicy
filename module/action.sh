#!/bin/sh
# action.sh
# No warranty.
# No rights reserved.
# This is free software; you can redistribute it and/or modify it under the terms of The Unlicense.

# just some bullshit for action button

# check vendor_sepolicy
if grep -q "lineage" /system/vendor/etc/selinux/vendor_sepolicy.cil > /dev/null 2>&1; then
	echo "[!] lineage found on vendor_sepolicy.cil"
else
	echo "[+] vendor_sepolicy.cil is clean"
fi

# check compatibility_matrix
if grep -q "lineage" /system/etc/vintf/compatibility_matrix.device.xml > /dev/null 2>&1; then
	echo "[!] lineage found on compatibility_matrix.device.xml"
else
	echo "[+] compatibility_matrix.device.xml is clean"
fi

# check service
if /system/bin/service | grep -q "lineage" > /dev/null 2>&1; then
	echo "[!] lineage found on /system/bin/service"
else
	echo "[+] clean /system/bin/service"
fi

# ksu and apatch auto closes
# make it wait 20s so we can read
if [ -z "$MMRL" ] && [ -z "$KSU_NEXT" ]  && { [ "$KSU" = "true" ] || [ "$APATCH" = "true" ]; }; then
	sleep 20
fi

# EOF
