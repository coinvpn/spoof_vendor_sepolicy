#!/bin/sh
PATH=/data/adb/ap/bin:/data/adb/ksu/bin:/data/adb/magisk:$PATH
MODDIR="${0%/*}"
. $MODDIR/utils.sh

# wait for boot complete to avoid android system screaming at us
until [ "$(getprop sys.boot_completed)" == "1" ]; do
    sleep 1
done

modid="my_region"

[ -w /sbin ] && TMPFS_DIR="/sbin/spoof_vendor_sepolicy"
[ -w /debug_ramdisk ] && TMPFS_DIR="/debug_ramdisk/spoof_vendor_sepolicy"

[ -w /mnt ] && basefolder=/mnt
[ -w /mnt/vendor ] && basefolder=/mnt/vendor

# we mimic vendor mounts like, my_bigball
mkdir $basefolder/$modid

cd $TMPFS_DIR

for i in $(ls -d */*/); do
	mkdir -p $basefolder/$modid/$i
	mount --bind $TMPFS_DIR/$i $basefolder/$modid/$i
	mount -t overlay -o "lowerdir=$basefolder/$modid/$i:/$i" overlay /$i
done

# EOF
