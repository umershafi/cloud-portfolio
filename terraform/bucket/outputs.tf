output "website_endpoint" {
  value = aws_s3_bucket_website_configuration.static_website.website_endpoint
}

output "bucket_id" {
  value = aws_s3_bucket.portfolio.id
}

output "bucket_domain" {
  value = aws_s3_bucket.portfolio.bucket_regional_domain_name
}
