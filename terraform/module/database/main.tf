resource "random_string" "password" {
  length  = 32
  special = false
}
/*To generate a secure password and store it in SSM (Systems Manager)
 Parameter Store for developers to access securely*/

resource "aws_ssm_parameter" "password" {
  name  = "/${var.name}/database/password"
  type  = "SecureString"
  value = random_string.password.result
}

module "this" {
  source  = "terraform-aws-modules/rds/aws"
  version = "6.12.0"

  allocated_storage                   = 20
  max_allocated_storage               = 20
  create_db_option_group              = false
  create_db_parameter_group           = false
  create_db_subnet_group              = false
  create_monitoring_role              = false
  db_subnet_group_name                = var.vpc_name
  engine                              = "postgres"
  engine_version                      = "16.3"
  iam_database_authentication_enabled = false
  identifier                          = var.name
  instance_class                      = "db.t3.micro"
  manage_master_user_password         = false
  option_group_name                   = "default:postgres-16"
  parameter_group_name                = "default.postgres16"
  password                            = random_string.password.result
  publicly_accessible                 = false
  skip_final_snapshot                 = true
  username                            = replace(var.name, "-", "_")
  vpc_security_group_ids              = var.security_groups
}