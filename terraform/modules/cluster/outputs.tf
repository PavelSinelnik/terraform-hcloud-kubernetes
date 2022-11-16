# cluster/outputs.tf

output "worker_ips" {
  description = ""
  value       = hcloud_server.worker_node.*.ipv4_address
}

output "private_network_interface" {
  value = "enp7s0"
}

output "all_nodes" {
  description = "List of all created servers."
  value       = local.servers
}

output "control_plane_nodes" {
  description = "List of control-plane nodes."
  value       = hcloud_server.control_plane_node
}

output "worker_nodes" {
  description = "List of worker nodes."
  value       = hcloud_server.worker_node
}

output "network_id" {
  value = hcloud_network.kubernetes_network.id
}

output "private_network" {
  value = hcloud_server_network.private_network
}
