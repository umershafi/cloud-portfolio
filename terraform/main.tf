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
  source = "./bucket"
}

