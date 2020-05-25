variable "network_name" {
  type    = string
  default = "shared-network"
}

variable "network_type" {
  type    = string
  default = "nat"
}

variable "network_domain" {
  type    = string
  default = "shared.local"
}

variable "network_cidr" {
  type    = list(string)
  default = []
}

variable "dns_enabled" {
  type    = bool
  default = true
}

variable "dns_local_only" {
  type    = bool
  default = true
}
