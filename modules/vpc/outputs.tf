output "network_name" {
  value = module.vpc.network_name
}

output "subnet" {
  value = element(module.vpc.subnets_names, 0)
}
