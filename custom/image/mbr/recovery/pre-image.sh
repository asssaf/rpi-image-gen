#!/bin/sh

set -eu

rootfs=$1
genimg_in=$2

# install recovery (TODO)
mkdir -p ${rootfs}/boot/recovery
curl -sLo ${rootfs}/boot/recovery/piCore64-16.0.0.img.gz http://tinycorelinux.net/16.x/aarch64/release/RPi/piCore64-16.0.0.img.gz

RECOVERY_LABEL="RECOVERY"
BOOT_LABEL="BOOT"
ROOT_LABEL="ROOT"
HOME_LABEL="HOME"

# Write genimage template
cat genimage.cfg.in | sed \
   -e "s|<IMAGE_DIR>|$IGconf_sys_outputdir|g" \
   -e "s|<IMAGE_NAME>|$IGconf_image_name|g" \
   -e "s|<IMAGE_SUFFIX>|$IGconf_image_suffix|g" \
   -e "s|<RECOVERY_SIZE>|$IGconf_image_recovery_part_size|g" \
   -e "s|<FW_SIZE>|$IGconf_image_boot_part_size|g" \
   -e "s|<ROOT_SIZE>|$IGconf_image_root_part_size|g" \
   -e "s|<HOME_SIZE>|$IGconf_image_home_part_size|g" \
   -e "s|<SECTOR_SIZE>|$IGconf_device_sector_size|g" \
   -e "s|<MKE2FSCONF>|'$(readlink -ef mke2fs.conf)'|g" \
   -e "s|<RECOVERY_LABEL>|$RECOVERY_LABEL|g" \
   -e "s|<BOOT_LABEL>|$BOOT_LABEL|g" \
   -e "s|<ROOT_LABEL>|$ROOT_LABEL|g" \
   -e "s|<HOME_LABEL>|$HOME_LABEL|g" \
   > ${genimg_in}/genimage.cfg
