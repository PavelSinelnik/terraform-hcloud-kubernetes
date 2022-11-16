output "floating_ip_name" {
  description = "Floating IP name"
  value       = hcloud_floating_ip.master_ip.name
}

output "floating_ip_id" {
  description = "Floating IP id"
  value       = hcloud_floating_ip.master_ip.id
}

output "floating_ip_address" {
  description = "Floating IP address"
  value       = hcloud_floating_ip.master_ip.ip_address
}