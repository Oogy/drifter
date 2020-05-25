output "id" {
  value = libvirt_network.network.id
}

output "name" {
  value = libvirt_network.network.name
}

output "domain" {
  value = libvirt_network.network.domain
}

output "cidr" {
  value = libvirt_network.network.addresses
}
