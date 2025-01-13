#!/bin/sh
PATH=/data/adb/ap/bin:/data/adb/ksu/bin:/data/adb/magisk:$PATH
MODDIR=${0%/*}
. $MODDIR/utils.sh

[ -w /sbin ] && TMPFS_DIR="/sbin/spoof_vendor_sepolicy"
[ -w /debug_ramdisk ] && TMPFS_DIR="/debug_ramdisk/spoof_vendor_sepolicy"


mkdir -p $TMPFS_DIR/vendor/etc/selinux
grep -v "lineage" /vendor/etc/selinux/vendor_sepolicy.cil > $TMPFS_DIR/vendor/etc/selinux/vendor_sepolicy.cil
susfs_clone_perm $TMPFS_DIR/vendor/etc/selinux/vendor_sepolicy.cil /vendor/etc/selinux/vendor_sepolicy.cil

mkdir -p $TMPFS_DIR/system/etc/vintf
grep -v "lineage" /system/etc/vintf/compatibility_matrix.device.xml > $TMPFS_DIR/system/etc/vintf/compatibility_matrix.device.xml
susfs_clone_perm $TMPFS_DIR/system/etc/vintf/compatibility_matrix.device.xml /system/etc/vintf/compatibility_matrix.device.xml

# EOF
