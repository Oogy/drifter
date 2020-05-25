output "home" {
  value = { id = module.home.id, name = module.home.name, domain = module.home.domain, cidr = module.home.cidr[0] }
}

output "work" {
  value = { id = module.work.id, name = module.work.name, domain = module.work.domain, cidr = module.work.cidr[0] }
}

output "secure" {
  value = { id = module.secure.id, name = module.secure.name, domain = module.secure.domain, cidr = module.secure.cidr[0] }
}

