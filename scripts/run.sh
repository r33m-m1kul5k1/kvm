#!/bin/bash
# https://stackoverflow.com/questions/59895/how-do-i-get-the-directory-where-a-bash-script-is-located-from-within-the-script

SCRIPT_DIR=$(cd -- $(dirname ${BASH_SOURCE[0]}) &> /dev/null && pwd)
PROJECT_DIR=$SCRIPT_DIR/..

echo $PROJECT_DIR
make -C $PROJECT_DIR

echo $(file $PROJECT_DIR/hypervisor.iso)

qemu-system-x86_64 -boot d -cdrom $PROJECT_DIR/hypervisor.iso \
-chardev stdio,mux=on,id=char0 \
-mon chardev=char0,mode=readline \
-serial chardev:char0 \
-hda $PROJECT_DIR/bootimage-CrabOS.bin \
