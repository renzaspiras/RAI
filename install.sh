mkdir kvm
pacman -S qemu-base --noconfirm
qemu-img create -f qcow2 alpine.img 5G
wget  wget https://dl-cdn.alpinelinux.org/alpine/v3.19/releases/aarch64/alpine-virt-3.19.1-aarch64.iso

mv *.img ./kvm/
mv *.iso ./kvm/os.iso

qemu-system-aarch64 -machine virt,accel=kvm -cpu cortex-a53 -m 1024 \
  -drive if=pflash,format=raw,file=$PREFIX/share/qemu/edk2-aarch64-code.fd,readonly \
  -drive file=./kvm/alpine.img,format=raw \
  -device virtio-net-pci,netdev=n1 \
  -netdev user,id=n1,hostfwd=tcp::2222-:22 \
  -cdrom ./kvm/os.iso \
  -nographic
