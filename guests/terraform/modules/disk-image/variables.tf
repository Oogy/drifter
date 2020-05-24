variable "disk_name" {
  type    = string
  default = "generic-disk"
}

variable "base_image_id" {
  type    = string
  default = null
}

variable "size_gb" {
  type    = number
  default = 20
}
