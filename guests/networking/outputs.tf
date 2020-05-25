output "home" {
  value = [ module.home.id, module.home.name, module.home.domain, module.home.cidr[0] ]
}

output "work" {
  value = { id = module.work.id, name = module.work.name, domain = module.work.domain, cidr = module.work.cidr[0] }
}

output "secure" {
  value = [ module.secure.id, module.secure.name, module.secure.domain, module.secure.cidr[0] ]
}

