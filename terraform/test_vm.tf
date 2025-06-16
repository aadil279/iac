resource "proxmox_virtual_environment_vm" "faafo-vm-alma" {
  node_name       = "pve01"
  vm_id           = 2790
  stop_on_destroy = true

  name        = "faafo"
  description = "Do NOT keep important data here as this is a FAAFO VM"
  tags        = ["alma", "faafo"]

  agent {
    enabled = true
  }

  cpu {
    cores = 1
    type  = "x86-64-v2-AES"
  }

  memory {
    dedicated = 512
  }

  disk {
    datastore_id = "hdd-thin-vmstore"
    file_id      = proxmox_virtual_environment_download_file.alma-cloud-image.id
    interface    = "virtio0"
    size         = 20
  }

  network_device {
    bridge = "vmbr0"
  }

  operating_system {
    type = "l26"
  }

  serial_device {}

  initialization {
    dns {
      servers = ["192.168.1.100"]
    }
    user_data_file_id = proxmox_virtual_environment_file.rocky-user-data.id
  }

}