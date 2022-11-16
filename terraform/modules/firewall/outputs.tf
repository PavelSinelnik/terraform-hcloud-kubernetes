output "id" {
  description = "Unique ID of the Firewall"
  value       = hcloud_firewall.firewall.id
}

output "name" {
  description = "Name of the Firewall"
  value       = hcloud_firewall.firewall.name
}