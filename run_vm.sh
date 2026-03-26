#! /usr/bin/env bash
sudo qemu-kvm -name nixos   -m 4G   -smp 2   -drive cache=writeback,file=root.qcow2,id=drive1,if=none,index=1,werror=report   -device virtio-blk-pci,bootindex=1,drive=drive1   -nographic   -netdev bridge,id=net0,br=virbr0 -display none  -device virtio-net-pci,netdev=net0 #</dev/null >/dev/null 2>&1 &
