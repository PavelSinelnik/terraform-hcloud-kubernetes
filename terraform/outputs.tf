# get cluster module output
output "network_id" {
  value       = module.cluster.network_id
  description = "Unique ID of the network."
}

output "control_plane_nodes" {
  value       = module.cluster.control_plane_nodes
  description = "The control-plane node objects."
}

output "control_plane_nodes_ips" {
  value       = module.cluster.control_plane_nodes.*.ipv4_address
  description = "The IPv4 addresses within the control-plane network."
}

output "control_plane_nodes_ids" {
  value       = module.cluster.control_plane_nodes.*.id
  description = "The ids of the control-plane nodes."
}

output "worker_nodes" {
  value       = module.cluster.worker_nodes
  description = "The worker node objects."
}

output "worker_nodes_ips" {
  value       = module.cluster.worker_nodes.*.ipv4_address
  description = "The IPv4 addresses within the worker network."
}

output "worker_nodes_ids" {
  value       = module.cluster.worker_nodes.*.id
  description = "The ids of the worker nodes."
}

