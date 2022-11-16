resource "hcloud_floating_ip" "master_ip" {
  name              = var.name
  type              = var.type
  home_location     = var.home_location
  server_id         = var.server_id
  description       = var.description
  labels            = var.labels
  delete_protection = var.delete_protection
}
