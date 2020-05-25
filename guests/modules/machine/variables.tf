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

variable "iso" {
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

variable "video_mode" {
  type = string
  default = "cirrus"
}

variable "running" {
  type = bool
  default = true
}

variable "graphics_type" {
  type = string
  default = "spice"
}
