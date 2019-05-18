sudo qemu-system-arm \
  -kernel ~/qemu_vms/qemu-rpi-kernel-master/kernel-qemu-4.4.34-jessie \
  -cpu arm1176 \
  -m 256 \
  -M versatilepb \
  -serial stdio \
  -append "root=/dev/sda2 rootfstype=ext4 rw" \
  -hda ~/qemu_vms/raspbian.img -redir tcp:5022::22;
