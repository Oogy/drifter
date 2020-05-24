variable "name" {
  type = string
  default = null
}

variable "memory" {
  type = number
  default = 1024
}

variable "vcpus" {
  type = number
  default = 1
}

variable "disks" {
  type = list(string)
  default = []
}

variable "network" {
  type = string
  default = null
}

variable "cloud_init" {
  type = string
  default = null
}

