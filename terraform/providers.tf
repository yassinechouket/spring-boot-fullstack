terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"   # download AWS provider
      version = "~> 5.0"          # use AWS provider version 5.x
    }
  }
}
