provider "aws" {
  region = "us-east-1"
}

resource "aws_s3_bucket" "example" {
  bucket = "umershafi-03337"
}

output "bucket_id" {
  value = aws_s3_bucket.example.id
}
