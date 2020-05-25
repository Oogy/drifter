module "vultr_workstation" {
  source = "../modules/cloudconfig"

  name           = "vultr-workstation"
  cloud_config   = file("./conf/ubuntu_bionic_vultr_workstation")
  network_config = file("./conf/network/ubuntu_bionic")
}
