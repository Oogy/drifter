module "drifter_network" {
  source = "../modules/network"

  network_name   = "drifter"
  network_domain = "drifter.local"
}

module "secure_network" {
  source = "../modules/network"

  network_name   = "secure"
  network_domain = "secure.local"
  network_cidr = ["10.66.66.0/24"]
}
