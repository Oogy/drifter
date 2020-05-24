provider "libvirt" {
  uri = "qemu:///system"
}

resource "libvirt_volume" "disk_image" {
  name           = var.disk_name
  base_volume_id = var.base_image_id
  size           = var.size_gb * 1000000000
}
