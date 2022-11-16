variable "name" {
  description = "Name of the Floating IP"
  type        = string
  default     = null
}

variable "type" {
  description = "Type of the Floating IP"
  type        = string
  default     = "ipv4"
}

variable "home_location" {
  description = "Home location"
  type        = string
}

variable "server_id" {
  description = "Server to assign the Floating IP is assigned to"
  type        = number
  default     = null
}

variable "description" {
  description = "Description of the Floating IP"
  type        = string
  default     = null
}

variable "labels" {
  type        = map(string)
  default     = {}
  description = "User-defined labels (key-value pairs) should be created with"
}

variable "delete_protection" {
  type        = bool
  default     = false
  description = "Enable or disable delete protection"
}