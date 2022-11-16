# cluster/main.tf

locals {
  server_count = var.control_plane_count + var.worker_count
  servers      = concat(hcloud_server.control_plane_node, hcloud_server.worker_node)
}

resource "hcloud_server" "control_plane_node" {
  count       = var.control_plane_count
  name        = format(var.control_plane_name_format, count.index + 1)
  location    = var.location
  image       = var.image
  server_type = var.control_plane_type

  labels = {
    control-plane = true
  }

}

resource "hcloud_server" "worker_node" {
  count       = var.worker_count
  name        = format(var.worker_name_format, count.index + 1)
  location    = var.location
  image       = var.image
  server_type = var.worker_type

  labels = {
    control-plane = false
  }

}

resource "hcloud_network" "kubernetes_network" {
  name     = var.cluster_name
  ip_range = var.network_ip_range
}

resource "hcloud_network_subnet" "kubernetes_subnet" {
  network_id   = hcloud_network.kubernetes_network.id
  type         = "server"
  network_zone = var.network_zone
  ip_range     = var.subnet_ip_range
}

resource "hcloud_server_network" "private_network" {
  count     = local.server_count
  server_id = element(local.servers.*.id, count.index)
  subnet_id = hcloud_network_subnet.kubernetes_subnet.id
}

resource "hcloud_floating_ip_assignment" "main" {
  count       = var.control_plane_count
  floating_ip_id = var.floating_ip_id
  server_id      = hcloud_server.control_plane_node[count.index].id

  lifecycle {
    create_before_destroy = true
  }
}

resource "null_resource" "cluster" {
  count       = var.control_plane_count
  triggers = {
    cluster_instance_ids = hcloud_server.control_plane_node[count.index].id
  }

  provisioner "remote-exec" {

    connection {
      type        = "ssh"
      user        = "admin"
      host        = hcloud_server.control_plane_node[count.index].ipv4_address
      # private_key = var.SSH_PRIVATE_KEY
    }

    inline = ["sudo ip addr add ${var.floating_ip_address} dev eth0"]
  }
}