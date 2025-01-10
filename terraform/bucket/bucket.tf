resource "aws_s3_bucket" "portfolio" {
  bucket = "umershafi-website"
}

resource "aws_s3_bucket_website_configuration" "static_website" {
  bucket = aws_s3_bucket.portfolio.id

  index_document {
    suffix = "index.html"
  }
}

resource "aws_s3_bucket_public_access_block" "allow_public_access" {

  bucket = aws_s3_bucket.portfolio.id

  block_public_acls       = false
  block_public_policy     = false
  ignore_public_acls      = false
  restrict_public_buckets = false

}

resource "aws_s3_bucket_policy" "allow_access_to_root_user" {
  bucket = aws_s3_bucket.portfolio.id
  policy = data.aws_iam_policy_document.bucket_policy.json
}

data "aws_iam_policy_document" "bucket_policy" {
  statement {
    principals {
      type        = "AWS"
      identifiers = ["*"]
    }

    actions = ["s3:GetObject"]
    resources = [
      "${aws_s3_bucket.portfolio.arn}/*"
    ]
    effect = "Allow"
  }
}

# locals {
#   website_files = fileset("../frontend/", "**")
#   mime_types    = jsondecode(file("bucket/mime.json"))
# }

resource "aws_s3_object" "object-upload-html" {
  bucket       = aws_s3_bucket.portfolio.id
  key          = "index.html"
  source       = "../frontend/index.html"
  content_type = "text/html"
  source_hash  = filemd5("../frontend/index.html")
}

resource "aws_s3_object" "object-upload-css" {
  bucket       = aws_s3_bucket.portfolio.id
  key          = "styles.css"
  source       = "../frontend/styles.css"
  content_type = "text/css"
  source_hash  = filemd5("../frontend/styles.css")
}

# resource "aws_s3_object" "upload_files" {
#   bucket   = aws_s3_bucket.portfolio.id
#   for_each = local.website_files
#   #for_each     = fileset("../frontend/", "**/*")
#   key          = each.key
#   source       = "../frontend/${each.key}"
#   source_hash  = filemd5("../frontend/${each.key}")
#   content_type = lookup(local.mime_types, regex("\\.[^.]+$", each.key))
# }

output "website_endpoint" {
  value = aws_s3_bucket.portfolio.website_domain
}
