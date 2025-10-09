module "network" {
  source = "../network"

  availability_zones = ["eu-west-3a", "eu-west-3b", "eu-west-3c"]
  bastion_ingress    = var.bastion_ingress
  cidr               = "10.0.0.0/16"
  name               = var.name
}


module "database" {

  source = "../database"

  security_groups = [module.network.database_security_group]
  subnets         = module.network.database_subnets
  name            = var.name
  vpc_name        = module.network.vpc_name
}




