provider "libvirt" {
  uri = "qemu:///system"
}

resource "libvirt_network" "network" {
  name      = var.network_name
  mode      = var.network_type
  domain    = var.network_domain
  addresses = var.network_cidr

  dns {
    enabled    = var.dns_enabled
    local_only = var.dns_local_only
  }
}
