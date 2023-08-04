# # *.sandbox_us_east_2.twdps.digital

# # define a provider in the account where this subdomain will be managed
provider "aws" {
  alias  = "subdomain_sandbox_us_east_2_cdicohorts_team11"
  region = "us-east-2"
  assume_role {
    role_arn     = "arn:aws:iam::${var.nonprod_account_id}:role/${var.assume_role}"
    session_name = "lab-platform-hosted-zones"
  }
}

# create a route53 hosted zone for the subdomain in the account defined by the provider above
module "subdomain_sandbox_us_east_2_cdicohorts_team11" {
  source  = "terraform-aws-modules/route53/aws//modules/zones"
  version = "2.0.0"
  create  = true

  providers = {
    aws = aws.subdomain_sandbox_us_east_2_cdicohorts_team11
  }

  zones = {
    "sandbox-us-east-2.${local.domain_cdicohorts_team11}" = {
      tags = {
        cluster = "sandbox"
      }
    }
  }

  tags = {
    pipeline = "lab-platform-hosted-zones"
  }
}

# Create a zone delegation in the top level domain for this subdomain
module "subdomain_zone_delegation_sandbox_us_east_2_cdicohorts_team11" {
  source  = "terraform-aws-modules/route53/aws//modules/records"
  version = "2.0.0"
  create  = true

  providers = {
    aws = aws.domain_cdicohorts_team11
  }

  private_zone = false
  zone_name = local.domain_cdicohorts_team11
  records = [
    {
      name            = "sandbox-us-east-2"
      type            = "NS"
      ttl             = 172800
      zone_id         = data.aws_route53_zone.zone_id_cdicohorts_team11.id
      allow_overwrite = true
      records         = lookup(module.subdomain_sandbox_us_east_2_cdicohorts_team11.route53_zone_name_servers,"sandbox-us-east-2.${local.domain_cdicohorts_team11}")
    }
  ]

  depends_on = [module.subdomain_sandbox_us_east_2_cdicohorts_team11]
}
