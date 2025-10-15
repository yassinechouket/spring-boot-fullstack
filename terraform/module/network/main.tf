module "subnets" {
  source  = "hashicorp/subnets/cidr"
  version = "1.0.0"

  base_cidr_block = var.cidr

  networks = flatten([
    for k, v in local.subnets : [
      for az in var.availability_zones : {
        name     = "${k}-${az}"
        new_bits = v
      }
    ]
  ])
}

module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "5.21.0"

  azs                    = var.availability_zones
  cidr                   = var.cidr
  database_subnets       = [for az in var.availability_zones : module.subnets.network_cidr_blocks["database-${az}"]]
  elasticache_subnets    = [for az in var.availability_zones : module.subnets.network_cidr_blocks["elasticache-${az}"]]
  enable_nat_gateway     = true
  intra_subnets          = [for az in var.availability_zones : module.subnets.network_cidr_blocks["intra-${az}"]]
  name                   = var.name
  one_nat_gateway_per_az = false
  private_subnets        = [for az in var.availability_zones : module.subnets.network_cidr_blocks["private-${az}"]]
  public_subnets         = [for az in var.availability_zones : module.subnets.network_cidr_blocks["public-${az}"]]
  single_nat_gateway     = true

  default_security_group_ingress = [
    {
      self = true
    }
  ]
}

/*
!!!!!!
public_subnets = [
  "10.0.1.0/24",  # from public-eu-west-3a
  "10.0.2.0/24"   # from public-eu-west-3b
]*/


/*
result ->
networks = [
  { name = "database-eu-west-3a", new_bits = 6 },
  { name = "database-eu-west-3b", new_bits = 6 },
  { name = "elasticache-eu-west-3a", new_bits = 6 },
  { name = "elasticache-eu-west-3b", new_bits = 6 },
  { name = "intra-eu-west-3a", new_bits = 5 },
  { name = "intra-eu-west-3b", new_bits = 5 },
  { name = "private-eu-west-3a", new_bits = 3 },
  { name = "private-eu-west-3b", new_bits = 3 },
  { name = "public-eu-west-3a", new_bits = 5 },
  { name = "public-eu-west-3b", new_bits = 5 },
]
and module.subnets.network_cidr_blocks = {
  "database-eu-west-3a"    = "10.0.0.0/22"
  "database-eu-west-3b"    = "10.0.4.0/22"
  "public-eu-west-3a"      = "10.0.20.0/24"
  "public-eu-west-3b"      = "10.0.21.0/24"
  ...
}*/



