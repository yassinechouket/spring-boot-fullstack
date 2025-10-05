output "database_security_group" {
  value = module.security_group_db.security_group_id
}

output "database_subnets" {
  value = module.vpc.database_subnets
}

output "private_security_group" {
  value = module.security_group_private.security_group_id
}

output "private_subnets" {
  value = module.vpc.private_subnets
}

output "vpc_id" {
  value = module.vpc.vpc_id
}

output "vpc_name" {
  value = module.vpc.name
}

/*Outputs allow exporting values from a module that can be used in other resources or modules,
 such as VPC IDs, subnet information, or other resource details. They enable reusing values without
  recalculating them and are local to the current repository*/