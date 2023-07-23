#!/bin/sh

#XEN_SRC=$HOME/aos_proj/meta-aos-rcar-demo2023/yocto/build/gen3/domd/tmp/work/aarch64-poky-linux/xen/4.16.0+gitAUTOINC+81ac624282-r0/git/xen

#CROSS=$HOME/linaro/gcc-linaro-7.5.0-2019.12-x86_64_aarch64-linux-gnu/bin/aarch64-linux-gnu-
CROSS=$HOME/zephyr-sdk-0.15.2/aarch64-zephyr-elf/bin/aarch64-zephyr-elf-
GDB=${CROSS}gdb

PROGRAM=build/zephyr/zephyr.elf
#PROGRAM=xen-syms

REMOTE=localhost:4224
REMOTE_CMD=--eval-command="target remote $REMOTE"
#DIRS="--directory=../xen/git/xen/common --directory=../xen/git/xen/arch/arm"
#UI=--tui

:
$GDB $DIRS --eval-command="target remote $REMOTE" $PROGRAM $UI
