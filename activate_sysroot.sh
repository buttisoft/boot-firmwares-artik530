#!/bin/bash

# Make sure only root can run our script
if [ "$(id -u)" != "0" ]; then
   echo "This script must be run as root" 1>&2
   exit 1
fi

if [ "$1" == "0" ];then
  umount -A sysroot/dev
  umount -A sysroot/proc
  umount -A sysroot/provette
  rm sysroot/etc/resolv.conf
elif [ "$1" == "1" ];then
  mount -o bind /dev sysroot/dev/
  mount -o bind /proc sysroot/proc/
  chmod 777 sysroot/tmp
  cp /etc/resolv.conf sysroot/etc/resolv.conf

  mkdir sysroot/provette
  mount -o bind /home/dummy/Desktop/A530/provette sysroot/provette

  chroot sysroot
else
  echo "Usage:"
  echo " sudo ./activate_sysroot.sh 1 --> Go under sysroot with chroot to be able to modify distribution"
  echo " sudo ./activate_sysroot.sh 0 --> Umount all dev and erase resolv.conf"
fi
