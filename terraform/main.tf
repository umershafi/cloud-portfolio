provider "aws" {
  region = "us-east-1"
}

# locals {
#   website_files = filset("../frontend/", "*")
# }

# data "external" "get_mime" {
#   for_each = local.website_files
#   program  = ["bash", "./get_mime.sh"]
#   query = {
#     filepath : "../frontend/${each.key}"
#   }
# }

module "s3_bucket" {
  source      = "./bucket"
  bucket_name = var.portfolio_bucket_name
}

module "route53" {
  source            = "./route53"
  cf_domain_name    = module.cloudfront.cf_domain_name
  cf_hosted_zone_id = module.cloudfront.cf_hosted_zone_id
}

module "cloudfront" {
  source             = "./cloudfront"
  bucket_name        = var.portfolio_bucket_name
  bucket_id          = module.s3_bucket.bucket_id
  bucket_domain_name = module.s3_bucket.bucket_domain
  acm_arn            = module.route53.acm_cert_arn
}

