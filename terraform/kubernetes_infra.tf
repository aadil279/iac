resource "proxmox_virtual_environment_vm" "kube-master" {
  node_name       = "pve01"
  vm_id           = 9001
  stop_on_destroy = true
  on_boot = false
  started = true

  name        = "k8s-master-test"
  description = "Kubernetes Master Node. Do NOT keep important data here as this is a FAAFO VM"
  tags        = ["alma", "k8s", "k8s-master"]

  agent {
    enabled = true
  }

  cpu {
    cores = 4
    type  = "x86-64-v2-AES"
  }

  memory {
    dedicated = 4096
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

locals {
  kube_workers = {
    "k8s-worker-01" = {
      vm_name = "k8s-worker-test"
      vm_id = 9002
    }
    /*"k8s-worker-02" = {
      vm_name = "k8s-worker-02"
      vm_id = 9003
    }
    "k8s-worker-03" = {
      vm_name = "k8s-worker-03"
      vm_id = 9004
    }*/
}
  }

resource "proxmox_virtual_environment_vm" "kube-worker" {
  for_each = local.kube_workers

  node_name       = "pve01"
  vm_id           = each.value.vm_id
  stop_on_destroy = true
  on_boot = false
  started = true

  name        = each.value.vm_name
  description = "Kubernetes Worker Node. Do NOT keep important data here as this is a FAAFO VM"
  tags        = ["alma", "k8s", "k8s-worker"]

  agent {
    enabled = true
  }

  cpu {
    cores = 2
    type  = "x86-64-v2-AES"
  }

  memory {
    dedicated = 4096
  }

  disk {
    datastore_id = "hdd-thin-vmstore"
    file_id      = proxmox_virtual_environment_download_file.alma-cloud-image.id
    interface    = "virtio0"
    size         = 15
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


