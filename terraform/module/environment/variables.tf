variable "bastion_ingress" {
  default     = []
  description = "CIDR blocks for bastion ingress"
  type        = list(string)
}

variable "name" {
  description = "Name of the cloud environment"
  type        = string
}



/* bastion_ingress    = var.bastion_ingress -> It usually contains a
 list of IP CIDR blocks that are allowed to connect to the bastion host (via SSH for example).
 */


