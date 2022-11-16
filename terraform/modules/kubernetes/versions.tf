terraform {
  required_providers {
    hcloud = {
      source  = "hetznercloud/hcloud"
      version = "~> 1.35.2"
    }
  }
  required_version = ">= 1.3.2"
}