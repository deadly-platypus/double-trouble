#!/bin/bash

if [[ $(id -u) -ne 0 ]] ; then 
    echo "Please run as root"
    exit
fi

if [ "$#" -ne 1 ]; then
    echo "Please supply file system"
    exit
fi

FS=$1
LOC=images/disk.$FS.usb

echo "Creating base file at $LOC"
qemu-img create -f qcow2 $LOC 64K > /dev/null
if [ ! $? -eq 0 ]; then
    echo "Error"
    exit
fi

echo "Creating partition"
echo "y
n
p
1


w
" | fdisk $LOC
if [ ! $? -eq 0 ]; then
    rm -f $LOC
    echo "Error"
    exit
fi

echo "Creating filesystem $1"
echo "y
" | mkfs.$FS $LOC > /dev/null
if [ ! $? -eq 0 ]; then
    rm -f $LOC
    echo "Error"
    exit
fi

echo "Opening NBD"
qemu-nbd -f raw -c /dev/nbd0 $LOC > /dev/null
if [ ! $? -eq 0 ]; then
    rm -f $LOC
    echo "Error"
    exit
fi
echo "Mounting disk"
mount /dev/nbd0 /mnt/tmp > /dev/null
if [ ! $? -eq 0 ]; then
    qemu-nbd -d /dev/nbd0
    rm -f $LOC
    echo "Error"
    exit
fi
echo "Writing data"
dd if=/dev/urandom count=1 bs=1024 | uuencode stdout > tmp.txt
if [ ! $? -eq 0 ]; then
    umount /mnt/tmp
    qemu-nbd -d /dev/nbd0
    rm -f $LOC
    echo "Error"
    exit
fi
mv tmp.txt /mnt/tmp
if [ ! $? -eq 0 ]; then
    umount /mnt/tmp
    qemu-nbd -d /dev/nbd0
    rm -f $LOC
    echo "Error"
    exit
fi
umount /mnt/tmp > /dev/null
if [ ! $? -eq 0 ]; then
    qemu-nbd -d /dev/nbd0
    rm -f $LOC
    echo "Error"
    exit
fi
echo "Closing NBD"
qemu-nbd -d /dev/nbd0 > /dev/null
if [ ! $? -eq 0 ]; then
    rm -f $LOC
    echo "Error"
    exit
fi
chmod a+wrx $LOC

echo "Done"
