# Introduction

This is my homelab's infrastructure as code.

# Tools Used
These are the tools and technologies that I am using throughout my homelab. **This repository is very new, so most of these are not represented here and some might not ever be**.
- **Proxmox** as hypervisor where all my services run inside Virtual Machines
- **Ansible** for configuration management. Uses the proxmox dynamic inventory plugin
- **Terraform** for resource provisioning, mainly VMs at this point
- **Kubernetes (Work in Progress)** for container orchestration - this is mainly for education purposes as it is overkill for normal homelab use. I am preparing for the CKA certification and want to learn as much about Kubernetes as possible
- **Bitwarden** for secrets management
- **Nginx** as the reverse proxy for my hosted services
- **Cloudflare** as the NS for my publicly exposed services 

# Services that I am hosting
Besides for learning, this homelab also hosts a few services for daily use. Most of these are not yet reflected here as they were incremental additions, by SSHing into the VMs where they reside. They are all living inside containers and the publicly available ones pass through cloudflare proxied DNS and my reverse proxy.

| **Service**       | **Exposure** | **Description**                                                     |
|:-------------------|:--------------:|:---------------------------------------------------------------------:|
| **AdGuard Home**  | Internal     | Home network DNS server with DNS-level ad blocking                  |
| **Authentik**     | Public       | Identity Provider for SSO via OAuth2 across supported applications  |
| **Jellyfin**      | Public       | Media server                                                        |
| **Jellyseerr**    | Public       | Media request server for Jellyfin                                   |
| **Nextcloud**     | Internal     | Self-hosted cloud suite                                             |
| **Portainer**     | Internal     | Basic container management                                          |
| **WireGuard**     | Public       | VPN for accessing local network remotely                            |

