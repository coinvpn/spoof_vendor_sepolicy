#!/bin/sh
MODDIR="${0%/*}"
source ${MODDIR}/utils.sh

# make sure ${MODDIR}/skip_mount exists!
# this way ksu wont mount it
# we handle the mounting ourselves
[ ! -f ${MODDIR}/skip_mount ] && touch ${MODDIR}/skip_mount

modid="my_vendor"

[ -w /mnt ] && basefolder=/mnt
[ -w /mnt/vendor ] && basefolder=/mnt/vendor

# we mimic vendor mounts like, my_bigball
mkdir $basefolder/$modid

cd $MODDIR

for i in $(ls -d */*); do
	mkdir -p $basefolder/$modid/$i
	mount --bind $MODDIR/$i $basefolder/$modid/$i
	mount -t overlay -o "lowerdir=$basefolder/$modid/$i:/$i" overlay /$i
done
