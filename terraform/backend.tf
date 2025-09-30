terraform {
  backend "s3" {
    bucket = "spring-fullstack-yass2003"
    key    = "terraform.tfstate"
    region = "eu-west-3"
  }
}