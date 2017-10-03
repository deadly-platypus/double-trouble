#!/bin/sh

IMG=images/disk.img
INIT_RD=images/initramfs-busybox-x86-test.cpio.gz
USB_IMG=images/disk.usb
KERNEL=~/code/kernels/default-build/arch/x86_64/boot/bzImage
QEMU_PATH=~/code/qemu/build
QEMU_EXE=x86_64-softmmu/qemu-system-x86_64
QEMU_OPTS="--enable-kvm -kernel $KERNEL -initrd $INIT_RD -device piix3-usb-uhci -hda images/root.qcow2 -m 2048"
TEL_OPTS="--monitor stdio"
TRACE_OPTS=""

$QEMU_PATH/$QEMU_EXE $QEMU_OPTS $TEL_OPTS $TRACE_OPTS
