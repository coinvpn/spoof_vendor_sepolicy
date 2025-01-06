#!/bin/sh
. $MODPATH/utils.sh

# unmount older module
umount -l /vendor/etc
mkdir -p $MODPATH/overlay/vendor/etc/selinux
grep -v "lineage" /vendor/etc/selinux/vendor_sepolicy.cil > $MODPATH/overlay/vendor/etc/selinux/vendor_sepolicy.cil
susfs_clone_perm $MODPATH/overlay/vendor/etc/selinux/vendor_sepolicy.cil /vendor/etc/selinux/vendor_sepolicy.cil

umount -l /system/etc
mkdir -p $MODPATH/overlay/system/etc/vintf
grep -v "lineage" /system/etc/vintf/compatibility_matrix.device.xml > $MODPATH/overlay/system/etc/vintf/compatibility_matrix.device.xml
susfs_clone_perm $MODPATH/overlay/system/etc/vintf/compatibility_matrix.device.xml /system/etc/vintf/compatibility_matrix.device.xml

# skip mount
touch $MODPATH/skip_mount
