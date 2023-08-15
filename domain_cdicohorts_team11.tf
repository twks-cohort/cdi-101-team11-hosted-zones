locals {
  domain_cdicohorts_team11 = "cdicohorts-eleven.com"
}

provider "aws" {
  alias  = "domain_cdicohorts_team11"
  region = "us-east-2"
  assume_role {
    role_arn = "arn:aws:iam::${var.nonprod_account_id}:role/${var.assume_role}"
  }
}

# zone id for the top-level-zone
data "aws_route53_zone" "zone_id_cdicohorts_eleven" {
  provider = aws.domain_cdicohorts_team11
  name     = local.domain_cdicohorts_team11
}
