data "hcloud_image" "kuber_image" {
  with_selector = "infra=kuber"
  most_recent   = true
}

module "floating_ip_kuber" {
  source        = "./modules/floating_ip"
  name          = "master-${var.environment}"
  home_location = var.location
}

module "cluster" {
  source                    = "./modules/cluster"
  floating_ip_id            = module.floating_ip_kuber.floating_ip_id
  floating_ip_address       = module.floating_ip_kuber.floating_ip_address
  hcloud_token              = var.hcloud_token
  cluster_name              = var.cluster_name
  location                  = var.location
  image                     = data.hcloud_image.kuber_image.id
  network_zone              = var.network_zone
  network_ip_range          = var.network_ip_range
  subnet_ip_range           = var.subnet_ip_range
  control_plane_type        = var.control_plane_type
  control_plane_count       = var.control_plane_count
  control_plane_name_format = var.control_plane_name_format
  worker_type               = var.worker_type
  worker_count              = var.worker_count
  worker_name_format        = var.worker_name_format
}

module "firewall_kuber" {
  source = "./modules/firewall"
  name   = "kuber-${var.environment}"
  rule   = local.rules_kuber
}

module "kubernetes" {
  floating_ip_address       = module.floating_ip_kuber.floating_ip_address
  source              = "./modules/kubernetes"
  hcloud_token        = var.hcloud_token
  network_id          = module.cluster.network_id
  cluster_name        = var.cluster_name
  control_plane_nodes = module.cluster.control_plane_nodes
  worker_nodes        = module.cluster.worker_nodes
  kubernetes_version  = var.kubernetes_version
}
