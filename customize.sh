#!/bin/sh
. $MODPATH/utils.sh

# unmount older module
umount -l /vendor/etc
mkdir -p $MODPATH/vendor/etc/selinux
grep -v "lineage" /vendor/etc/selinux/vendor_sepolicy.cil > $MODPATH/vendor/etc/selinux/vendor_sepolicy.cil
susfs_clone_perm $MODPATH/vendor/etc/selinux/vendor_sepolicy.cil /vendor/etc/selinux/vendor_sepolicy.cil

umount -l /system/etc
mkdir -p $MODPATH/system/etc/vintf
grep -v "lineage" /system/etc/vintf/compatibility_matrix.device.xml > $MODPATH/system/etc/vintf/compatibility_matrix.device.xml
susfs_clone_perm $MODPATH/system/etc/vintf/compatibility_matrix.device.xml /system/etc/vintf/compatibility_matrix.device.xml
