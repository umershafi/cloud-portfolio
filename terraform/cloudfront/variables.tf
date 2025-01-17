variable "bucket_name" {
  description = "The name of the S3 bucket"
  type        = string
}

variable "bucket_id" {
  description = "S3 bucket portfolio id"
  type        = string
}

variable "bucket_domain_name" {
  description = "S3 bucket domain name"
  type        = string
}

variable "acm_arn" {
  description = "arn for acm certificate"
  type        = string
}
