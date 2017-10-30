#!/bin/bash
CC=gcc
C_FILE=fat/dir.c
O_FILE=dir.o

CFLAGS="-Wp,-MD,.dir.o.d -nostdinc -isystem /usr/lib/gcc/x86_64-linux-gnu/7/include "
CFLAGS+="-Wall -Wundef -Wstrict-prototypes -Wno-trigraphs -fno-strict-aliasing -fno-common "
CFLAGS+="-fshort-wchar -Werror-implicit-function-declaration -Wno-format-security -std=gnu89 "
CFLAGS+="-mno-sse -mno-mmx -mno-sse2 -mno-3dnow -mno-avx -m64 -falign-jumps=1 -falign-loops=1 "
CFLAGS+="-mno-80387 -mno-fp-ret-in-387 -mpreferred-stack-boundary=3 -mskip-rax-setup "
CFLAGS+="-mtune=generic -mno-red-zone -funit-at-a-time -D__KERNEL__ -DCONFIG_AS_CFI=1 "
CFLAGS+="-DCONFIG_AS_CFI_SIGNAL_FRAME=1 -DCONFIG_AS_CFI_SECTIONS=1 -DCONFIG_AS_FXSAVEQ=1 "
CFLAGS+="-DCONFIG_AS_SSSE3=1 -DCONFIG_AS_CRC32=1 -DCONFIG_AS_AVX=1 -DCONFIG_AS_AVX2=1 "
CFLAGS+="-DCONFIG_AS_AVX512=1 -DCONFIG_AS_SHA1_NI=1 -DCONFIG_AS_SHA256_NI=1 -pipe "
CFLAGS+="-Wno-sign-compare -fno-asynchronous-unwind-tables -fno-delete-null-pointer-checks "
CFLAGS+="-Wno-frame-address -Wno-format-truncation -Wno-format-overflow -Wno-int-in-bool-context "
CFLAGS+="-O2 --param=allow-store-data-races=0 -DCC_HAVE_ASM_GOTO -Wframe-larger-than=2048 "
CFLAGS+="-fno-stack-protector -Wno-unused-but-set-variable -Wno-unused-const-variable "
CFLAGS+="-fno-omit-frame-pointer -fno-optimize-sibling-calls -fno-var-tracking-assignments -g "
CFLAGS+="-Wdeclaration-after-statement -Wno-pointer-sign -fno-strict-overflow -fconserve-stack "
CFLAGS+="-Werror=implicit-int -Werror=strict-prototypes -Werror=date-time "
CFLAGS+="-Werror=incompatible-pointer-types -Werror=designated-init -c "

INCLUDES="-I/home/derrick/code/kernels/gcc-linux/arch/x86/include "
INCLUDES+="-I/home/derrick/code/kernels/default-build/arch/x86/include/generated "
INCLUDES+="-I/home/derrick/code/kernels/gcc-linux/include "
INCLUDES+="-I/home/derrick/code/kernels/default-build/include "
INCLUDES+="-I/home/derrick/code/kernels/gcc-linux/arch/x86/include/uapi "
INCLUDES+="-I/home/derrick/code/kernels/default-build/arch/x86/include/generated/uapi "
INCLUDES+="-I/home/derrick/code/kernels/gcc-linux/include/uapi "
INCLUDES+="-I/home/derrick/code/kernels/default-build/include/generated/uapi "
INCLUDES+="-include /home/derrick/code/kernels/gcc-linux/include/linux/kconfig.h "
INCLUDES+="-I/home/derrick/code/kernels/gcc-linux/fs/fat "
INCLUDES+="-I/home/derrick/code/kernels/default-build/fs/fat "

$CC $CFLAGS $INCLUDES -o $O_FILE $C_FILE
