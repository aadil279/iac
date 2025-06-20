terraform {
  required_providers {

    # Proxmox Virtual Machines
    proxmox = {
      source = "bpg/proxmox"
    }

    # Bitwarden Secrets
    bitwarden = {
      source  = "maxlaverse/bitwarden"
      version = "0.13.6"
    }
  }

  # Store state in R2 (Uses S3 API)
  backend "s3" {
    # Defined during terraform init (data is in config file)
    endpoints = {
      s3 = ""
    }
    access_key = ""
    secret_key = ""

    # Bucket info
    bucket = "aadilhomelab-tf-backend"
    key    = "terraform/state.tfstate"
    region = "auto" # not used by R2, but required

    # Auth config
    skip_credentials_validation = true
    skip_metadata_api_check     = true
    skip_region_validation      = true
    skip_requesting_account_id  = true
    skip_s3_checksum            = true
    use_path_style              = true
  }

}

provider "proxmox" {
  endpoint  = "https://192.168.1.96:8006"
  insecure  = true
  api_token = data.bitwarden_secret.proxmox-api-token.value

  ssh {
    agent    = false
    # TODO: Stop using root (it is a pain to manage new PAM accounts)
    username = "root"
    password = data.bitwarden_secret.proxmox-ssh-password.value

    node {
      name    = "pve01"
      address = "192.168.1.96"
    }
  }
}

provider "bitwarden" {
  access_token = var.bw_access_token
  experimental {
    embedded_client = true
  }
}


