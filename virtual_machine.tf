resource "proxmox_vm_qemu" "vm" {
  target_node = "ferrix"
  desc        = "Cloudinit test VM"
  count       = 2
  onboot      = true

  clone = "ubuntu-22.04"

  agent = 1

  os_type = "cloud-init"
  cores   = 2
  sockets = 1
  numa    = true
  vcpus   = 0
  cpu     = "host"
  memory  = 2048
  name    = "test-vm-0${count.index + 1}"

  cloudinit_cdrom_storage = "local-lvm"
  scsihw                  = "virtio-scsi-single"
  bootdisk                = "scsi0"

  disks {
    scsi {
      scsi0 {
        disk {
          storage = "nvme"
          size    = 8
        }
      }
    }
  }

  ipconfig0  = "ip=10.0.3.3${count.index + 1}/24,gw=10.0.0.1"
  ciuser     = "ansible"
  nameserver = "10.0.2.5"
  sshkeys    = <<EOF
ssh-rsa 
    EOF

}
