variable "availability_zones" {
  description = "List of availability zones"
  type        = list(string)
}

variable "bastion_ingress" {
  default     = []
  description = "List of CIDR blocks to whitelist for bastion host"
  type        = list(string)
}

variable "cidr" {
  description = "CIDR block"
  type        = string
}

variable "name" {
  description = "Name of the network"
  type        = string
}


/*
They provide redundancy and fault tolerance, allowing infrastructure to survive potential failures. Most organizations typically
 use 2 AZs for failover, with the ability to dynamically add more AZs in the future without extensive reconfiguration*/


/*
In terraform.tfvars:
bastion_ingress = ["192.168.1.0/24", "203.0.113.45/32"]
bastion_ingress -> This allows SSH access only from the specified IPs (e.g., your office or home network).*/