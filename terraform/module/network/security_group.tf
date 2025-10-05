module "security_group_bastion" {
  source  = "terraform-aws-modules/security-group/aws"
  version = "5.3.0"

  description        = "Security group for bastion server"
  egress_cidr_blocks = ["0.0.0.0/0"]
  name               = "${var.name}-bastion"
  vpc_id             = module.vpc.vpc_id

  ingress_with_cidr_blocks = [
    for cidr in var.bastion_ingress : {
      cidr_blocks = cidr,
      rule        = "ssh-tcp",
    }
  ]

  ingress_with_self = [
    {
      rule = "all-all"
    },
  ]

  egress_with_cidr_blocks = [
    {
      rule = "all-all"
    }
  ]
}

module "security_group_db" {
  source  = "terraform-aws-modules/security-group/aws"
  version = "5.3.0"

  description        = "Security group for db subnet"
  egress_cidr_blocks = ["0.0.0.0/0"]
  name               = "${var.name}-db"
  vpc_id             = module.vpc.vpc_id

  ingress_with_self = [
    {
      rule = "all-all"
    }
  ]

  egress_with_cidr_blocks = [
    {
      rule = "all-all"
    }
  ]
}

module "security_group_elasticache" {
  source  = "terraform-aws-modules/security-group/aws"
  version = "5.3.0"

  description        = "Security group for elasticache subnet"
  egress_cidr_blocks = ["0.0.0.0/0"]
  name               = "${var.name}-elasticache"
  vpc_id             = module.vpc.vpc_id

  ingress_with_self = [
    {
      rule = "all-all"
    }
  ]

  egress_with_cidr_blocks = [
    {
      rule = "all-all"
    }
  ]
}

module "security_group_private" {
  source  = "terraform-aws-modules/security-group/aws"
  version = "5.3.0"

  description        = "Security group for private subnet"
  egress_cidr_blocks = ["0.0.0.0/0"]
  name               = "${var.name}-private"
  vpc_id             = module.vpc.vpc_id

  ingress_with_self = [
    {
      rule = "all-all"
    }
  ]

  egress_with_cidr_blocks = [
    {
      rule = "all-all"
    }
  ]
}

resource "aws_vpc_security_group_ingress_rule" "db_allow_private" {
  description                  = "Allow private subnet to access db"
  from_port                    = 5432
  ip_protocol                  = "tcp"
  referenced_security_group_id = module.security_group_private.security_group_id
  security_group_id            = module.security_group_db.security_group_id
  to_port                      = 5432
}

resource "aws_vpc_security_group_ingress_rule" "elasticache_allow_private" {
  description                  = "Allow private subnet to access elasticache"
  from_port                    = 6379
  ip_protocol                  = "tcp"
  referenced_security_group_id = module.security_group_private.security_group_id
  security_group_id            = module.security_group_elasticache.security_group_id
  to_port                      = 6379
}






/*What is the key advantage of using security group IDs instead of specific CIDR blocks or IP addresses?
What is the key advantage of using security group IDs instead of specific CIDR blocks or IP addresses?
Using security group IDs allows for more abstract and flexible network rules that
are not tied to specific IP addresses, making network configurations more adaptable and easier to manage
🟢 Real-world example

Imagine you have:

🟦 App servers (security group sg-app)

🟧 DB servers (security group sg-db)

You want only app servers to talk to DB servers on port 5432.

❌ If you use CIDR blocks:

You’d have to:

Know the private IP range of the app servers.

Add that CIDR manually in DB’s security group.

If the app servers scale up/down or move, you must update the rules.

Messy.

✅ If you use security group IDs:

On the DB security group, you simply say:

“Allow inbound 5432 from sg-app.”

Done ✅

New app servers join → automatically allowed.

Old app servers terminated → automatically removed.

IP addresses change? Doesn’t matter.

This is abstract and flexible because it depends on membership in a group, not on fixed IPs.*/
