locals {
  subnets = {
    "database"    = 6, # more bits means smaller subnet
    "elasticache" = 6,
    "intra"       = 5,
    "private"     = 3,
    "public"      = 5,
  }
}