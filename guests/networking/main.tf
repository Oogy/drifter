module "home" {
  source = "../modules/network"

  network_name   = "home"
  network_domain = "home.local"
  network_cidr = ["10.77.7.0/24"]
}

module "work" {
  source = "../modules/network"

  network_name   = "work"
  network_domain = "work.local"
  network_cidr = ["10.44.4.0/24"]
}

module "secure" {
  source = "../modules/network"

  network_name   = "secure"
  network_domain = "secure.local"
  network_cidr = ["10.66.6.0/24"]
}
