provider "libvirt" {
  uri = "qemu:///system"
}

resource "random_string" "random_id" {
  length = 8
  special = false
}

resource "libvirt_cloudinit_disk" "cloudconfig" {
  name = "${var.name}-${random_string.random_id.result}"
  user_data = var.cloud_config
  network_config = var.network_config
}
