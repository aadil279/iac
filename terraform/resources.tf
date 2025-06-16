resource "proxmox_virtual_environment_download_file" "alma-cloud-image" {
  node_name          = "pve01"
  datastore_id       = "local"
  content_type       = "iso"
  url                = "https://repo.almalinux.org/almalinux/9/cloud/x86_64/images/AlmaLinux-9-GenericCloud-9.6-20250522.x86_64.qcow2"
  checksum           = "b08cd5db79bf32860412f5837e8c7b8df9447e032376e3c622840b31aaf26bc6"
  checksum_algorithm = "sha256"
  file_name          = "alma9.img"
  upload_timeout     = 4444
}

resource "proxmox_virtual_environment_file" "rocky-user-data" {
  node_name    = "pve01"
  datastore_id = "Plex_media"
  content_type = "snippets"

  source_file {
    path = "localfiles/rocky-user-data.yml"
  }
}