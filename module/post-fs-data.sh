#!/bin/sh
PATH=/data/adb/ap/bin:/data/adb/ksu/bin:/data/adb/magisk:$PATH
MODDIR=${0%/*}
. $MODDIR/utils.sh

[ -w /sbin ] && TMPFS_DIR="/sbin/spoof_vendor_sepolicy"
[ -w /debug_ramdisk ] && TMPFS_DIR="/debug_ramdisk/spoof_vendor_sepolicy"

mkdir -p "$TMPFS_DIR/vendor/etc/selinux"
grep -v "lineage" /vendor/etc/selinux/vendor_sepolicy.cil > "$TMPFS_DIR/vendor/etc/selinux/vendor_sepolicy.cil"
susfs_clone_perm "$TMPFS_DIR/vendor/etc/selinux/vendor_sepolicy.cil" /vendor/etc/selinux/vendor_sepolicy.cil

mkdir -p "$TMPFS_DIR/system/etc/vintf"
grep -v "lineage" /system/etc/vintf/compatibility_matrix.device.xml > "$TMPFS_DIR/system/etc/vintf/compatibility_matrix.device.xml"
susfs_clone_perm "$TMPFS_DIR/system/etc/vintf/compatibility_matrix.device.xml" /system/etc/vintf/compatibility_matrix.device.xml

# fake /system/bin/service output
# will work as long as they dont check binary size
mkdir -p "$TMPFS_DIR/system/bin"
cp /system/bin/service "$TMPFS_DIR/system/bin/service.orig"
susfs_clone_perm "$TMPFS_DIR/system/bin/service.orig" /system/bin/service
echo "IyEvYmluL3NoCi9zeXN0ZW0vYmluL3NlcnZpY2Uub3JpZyAiJEAiIHwgc2VkICdzL2xpbmVhZ2UvL2c7IHMvTGluZWFnZS8vZycK" | base64 -d > "$TMPFS_DIR/system/bin/service"
susfs_clone_perm "$TMPFS_DIR/system/bin/service" /system/bin/service

# EOF
