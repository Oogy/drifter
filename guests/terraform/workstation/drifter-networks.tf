module "drifter_network" {
  source = "../modules/network"

  network_name   = "drifter"
  network_domain = "drifter.local"
}
