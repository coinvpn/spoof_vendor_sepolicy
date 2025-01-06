#!/bin/sh
MODDIR="${0%/*}"
. $MODDIR/utils.sh

# wait for boot complete to avoid android system screaming at us
until [ "$(getprop sys.boot_completed)" == "1" ]; do
    sleep 1
done

modid="my_vendor"

[ -w /mnt ] && basefolder=/mnt
[ -w /mnt/vendor ] && basefolder=/mnt/vendor

# we mimic vendor mounts like, my_bigball
mkdir $basefolder/$modid

cd $MODDIR/overlay

for i in $(ls -d */*); do
	mkdir -p $basefolder/$modid/$i
	mount --bind $MODDIR/overlay/$i $basefolder/$modid/$i
	mount -t overlay -o "lowerdir=$basefolder/$modid/$i:/$i" overlay /$i
done
