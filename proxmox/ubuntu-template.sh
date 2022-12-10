# remove existing image in case last execution did not complete successfully
rm jammy-server-cloudimg-amd64.img
wget https://cloud-images.ubuntu.com/jammy/current/jammy-server-cloudimg-amd64.img
sudo virt-customize -a jammy-server-cloudimg-amd64.img --install qemu-guest-agent
sudo qm create 8000 --name "ubuntu-2204-cloudinit-template" --memory 2048 --cores 2 --net0 virtio,bridge=vmbr0
sudo qm importdisk 8000 jammy-server-cloudimg-amd64.img local-lvm
sudo qm set 8000 --scsihw virtio-scsi-pci --scsi0 local-lvm:vm-8000-disk-0
sudo qm set 8000 --boot c --bootdisk scsi0
sudo qm set 8000 --ide2 local-lvm:cloudinit
sudo qm set 8000 --serial0 socket --vga serial0
sudo qm set 8000 --agent enabled=1
sudo qm template 8000
rm jammy-server-cloudimg-amd64.img
echo "Expandir disco"
echo "copiar claves ssh"