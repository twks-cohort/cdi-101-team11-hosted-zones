# # *.prod.twdps.digital

# # define a provider in the account where this subdomain will be managed
# provider "aws" {
#   alias  = "subdomain_prod_cdicohorts_team11"
#   region = "us-east-1"
#   assume_role {
#     role_arn     = "arn:aws:iam::${var.nonprod_account_id}:role/${var.assume_role}"
#     session_name = "lab-platform-hosted-zones"
#   }
# }

# # create a route53 hosted zone for the subdomain in the account defined by the provider above
# module "subdomain_prod_cdicohorts_team11" {
#   source  = "terraform-aws-modules/route53/aws//modules/zones"
#   version = "2.0.0"
#   create  = true

#   providers = {
#     aws = aws.subdomain_prod_cdicohorts_team11
#   }

#   zones = {
#     "prod.${local.domain_cdicohorts_team11}" = {
#       tags = {
#         cluster = "prod"
#       }
#     }
#   }

#   tags = {
#     pipeline = "lab-platform-hosted-zones"
#   }
# }

# # Create a zone delegation in the top level domain for this subdomain
# module "subdomain_zone_delegation_prod_cdicohorts_team11" {
#   source  = "terraform-aws-modules/route53/aws//modules/records"
#   version = "2.0.0"
#   create  = true

#   providers = {
#     aws = aws.domain_cdicohorts_team11
#   }

#   private_zone = false
#   zone_name = local.domain_cdicohorts_team11
#   records = [
#     {
#       name            = "prod"
#       type            = "NS"
#       ttl             = 172800
#       zone_id         = data.aws_route53_zone.zone_id_cdicohorts_team11.id
#       allow_overwrite = true
#       records         = lookup(module.subdomain_prod_cdicohorts_team11.route53_zone_name_servers,"prod.${local.domain_cdicohorts_team11}")
#     }
#   ]

#   depends_on = [module.subdomain_prod_cdicohorts_team11]
# }
