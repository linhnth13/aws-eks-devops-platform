output "primary_vpc_id" {
  value = module.vpc_primary.vpc_id
}

output "secondary_vpc_id" {
  value = module.vpc_secondary.vpc_id
}

output "primary_public_subnet_ids" {
  value = module.vpc_primary.public_subnet_ids
}

output "secondary_public_subnet_ids" {
  value = module.vpc_secondary.public_subnet_ids
}

output "primary_private_subnet_ids" {
  value = module.vpc_primary.private_subnet_ids
}

output "secondary_private_subnet_ids" {
  value = module.vpc_secondary.private_subnet_ids
}

output "primary_nat_gateway_id" {
  value = module.vpc_primary.nat_gateway_id
}

output "secondary_nat_gateway_id" {
  value = module.vpc_secondary.nat_gateway_id
}
