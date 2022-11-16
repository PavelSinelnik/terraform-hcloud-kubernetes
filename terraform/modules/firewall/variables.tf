variable "name" {
  type        = string
  default     = null
  description = "Name of the Firewall"
}

variable "labels" {
  type        = map(string)
  default     = {}
  description = "User-defined labels (key-value pairs) should be created with"
}

variable "rule" {
  type = list(object({
    direction       = string
    protocol        = string
    port            = optional(string)
    source_ips      = optional(list(string))
    destination_ips = optional(list(string))
    description     = optional(string)
  }))
  default     = []
  description = "Configuration of a Rule from this Firewall"
}

variable "apply_to" {
  type = list(object({
    label_selector = optional(string)
    server         = optional(number)
  }))
  default     = []
  description = "Resources the firewall should be assigned to"
}