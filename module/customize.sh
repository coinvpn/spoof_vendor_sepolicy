#!/bin/sh
. $MODPATH/utils.sh

echo "[+] mountify"
echo "[+] SysReq test"
# test for overlayfs
if grep -q "overlay" /proc/filesystems > /dev/null 2>&1; then \
	echo "[+] CONFIG_OVERLAY_FS"
	echo "[+] overlay found in /proc/filesystems"
else
	abort "[!] CONFIG_OVERLAY_FS is required for this module!"
fi

# test for tmpfs xattr
[ -w /mnt ] && MNT_FOLDER=/mnt
[ -w /mnt/vendor ] && MNT_FOLDER=/mnt/vendor
testfile="$MNT_FOLDER/tmpfs_xattr_testfile"
rm $testfile > /dev/null 2>&1 
busybox mknod "$testfile" c 0 0 > /dev/null 2>&1 
if busybox setfattr -n trusted.overlay.whiteout -v y "$testfile" > /dev/null 2>&1 ; then 
	echo "[+] CONFIG_TMPFS_XATTR"
	echo "[+] tmpfs extended attribute test passed"
else
	abort "[!] CONFIG_TMPFS_XATTR is required for this module!"
fi
rm $testfile > /dev/null 2>&1 

# skip mount
touch $MODPATH/skip_mount
# mountify 131+
touch $MODPATH/skip_mountify


echo "[+] creating sepolicy.cil"
# create spoofed files
mkdir -p "$MODPATH/system/vendor/etc/selinux"
grep -v "lineage" /vendor/etc/selinux/vendor_sepolicy.cil > "$MODPATH/system/vendor/etc/selinux/vendor_sepolicy.cil"
susfs_clone_perm "$MODPATH/system/vendor/etc/selinux/vendor_sepolicy.cil" /vendor/etc/selinux/vendor_sepolicy.cil

echo "[+] creating compatibility_matrix.device.xml"
mkdir -p "$MODPATH/system/etc/vintf"
grep -v "lineage" /system/etc/vintf/compatibility_matrix.device.xml > "$MODPATH/system/etc/vintf/compatibility_matrix.device.xml"
susfs_clone_perm "$MODPATH/system/etc/vintf/compatibility_matrix.device.xml" /system/etc/vintf/compatibility_matrix.device.xml

# EOF
