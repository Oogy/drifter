output "ubuntu_bionic" {
  value = module.ubuntu_bionic_base_image.id
}

output "kali_live" {
  value = module.kali_linux_live.id
}
