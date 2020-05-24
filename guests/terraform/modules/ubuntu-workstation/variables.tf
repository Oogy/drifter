variable "ubuntu_1604_base" {
  type    = string
  default = "https://cloud-images.ubuntu.com/releases/xenial/release/ubuntu-16.04-server-cloudimg-amd64-disk1.img"
}

variable "memory" {
  type    = string
  default = "512"
}

variable "cpus" {
  type    = number
  default = 1
}


