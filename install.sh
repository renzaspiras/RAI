mkdir kvm
pacman -S qemu-base --noconfirm
qemu-img create -f qcow2 alpine.img 5G
wget https://dl-cdn.alpinelinux.org/alpine/v3.19/releases/aarch64/alpine-virt-3.19.1-aarch64.iso

mv *.img ./kvm/
mv *.iso ./kvm/os.iso

qemu-system-aarch64 -M virt -cpu cortex-a57 -m 1024 -drive format=raw,file=./kvm/alpine.img -cdrom ./kvm/os.iso