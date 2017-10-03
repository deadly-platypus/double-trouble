#!/bin/sh

IMG=images/disk.img
INIT_RD=images/initramfs-busybox-x86-test.cpio.gz
USB_IMG=images/disk.usb
KERNEL=~/code/kernels/ubuntu-build/arch/x86_64/boot/bzImage
QEMU_PATH=~/code/qemu/build
QEMU_EXE=x86_64-softmmu/qemu-system-x86_64
#QEMU_OPTS="-enable-kvm -kernel $KERNEL -hda $IMG -append \"root=/dev/hda single\""
#QEMU_OPTS="--enable-kvm -kernel $KERNEL -drive file=$IMG,format=raw -initrd $INIT_RD -m 1024 -append \"init=/init\""
#QEMU_OPTS="--enable-kvm -kernel $KERNEL -initrd $INIT_RD -device piix3-usb-uhci -m 1024"
#QEMU_OPTS="-kernel $KERNEL -initrd $INIT_RD -device piix3-usb-uhci -m 1024"
QEMU_OPTS="-kernel $KERNEL -device piix3-usb-uhci -m 2048 -hda images/root.qcow2 -append 'root=/dev/sda'"
#TEL_OPTS="-qmp unix:/tmp/qmp-sock,server --monitor stdio"
TEL_OPTS="--monitor stdio"
#TRACE_OPTS="-trace events=events"
TRACE_OPTS=""

$QEMU_PATH/$QEMU_EXE $QEMU_OPTS $TEL_OPTS $TRACE_OPTS
