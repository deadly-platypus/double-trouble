#!/bin/sh

IMG=images/disk.img
INIT_RD=images/raminitfs.img
USB_IMG=images/disk.usb
KERNEL=~/code/kernels/gcc-linux/arch/x86_64/boot/bzImage
QEMU_PATH=~/code/qemu/build
QEMU_EXE=x86_64-softmmu/qemu-system-x86_64
QEMU_OPTS="-S -s --enable-kvm -kernel $KERNEL -initrd $INIT_RD -device piix3-usb-uhci -m 1024"
TEL_OPTS=
TRACE_OPTS=

$QEMU_PATH/$QEMU_EXE $QEMU_OPTS $TEL_OPTS $TRACE_OPTS
