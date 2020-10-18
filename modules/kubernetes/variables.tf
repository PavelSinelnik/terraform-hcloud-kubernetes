# kubernetes/variables.tf

# GENERAL
variable "hcloud_token" {
  default = ""
}

# NETWORK
variable "network_id" {
  type = string
}

variable "private_ips" {
  type = list
}

# MASTER NODES
variable "master_nodes" {
  type = list
}

# WORKER NODES
variable "worker_nodes" {
  type = list
}

# KUBERNETES
variable "kubernetes_version" {
  type = string
}

variable "cluster_name" {
  type = string
}
