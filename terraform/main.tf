# we cerate an env here , as IAM !!!
module "staging" {
  source = "./module/environment"

  bastion_ingress = local.bastion_ingress
  name            = "staging"
}