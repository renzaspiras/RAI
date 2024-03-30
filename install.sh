mkdir kvm
pacman -S qemu-base --noconfirm
qemu-img create -f qcow2 alpine.img 5G
wget  wget http://dl-cdn.alpinelinux.org/alpine/v3.12/releases/x86_64/alpine-virt-3.12.3-x86_64.iso

mv *.img ./kvm/
mv *.iso ./kvm/os.iso


qemu-system-x86_64 -machine q35 -m 1024 -smp cpus=2 -cpu qemu64 \
  -drive if=pflash,format=raw,read-only,file=$PREFIX/share/qemu/edk2-x86_64-code.fd \
  -netdev user,id=n1,hostfwd=tcp::2222-:22 -device virtio-net,netdev=n1 \
  -cdrom ./kvm/os.iso \
  -nographic ./kvm/alpine.img