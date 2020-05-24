provider "libvirt" {
    uri = "qemu:///system"
}

resource "libvirt_volume" "base_image" {
  name = var.image_name
  source = var.image_source
}
