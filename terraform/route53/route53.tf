resource "aws_acm_certificate" "cert" {
  domain_name       = "www.umershafi.com"
  validation_method = "DNS"
}

data "aws_route53_zone" "umershafi" {
  name         = "umershafi.com"
  private_zone = false
}

resource "aws_route53_record" "my_cert_dns" {
  for_each = {
    for dvo in aws_acm_certificate.cert.domain_validation_options : dvo.domain_name => {
      name   = dvo.resource_record_name
      record = dvo.resource_record_value
      type   = dvo.resource_record_type
    }
  }

  allow_overwrite = true
  name            = each.value.name
  records         = [each.value.record]
  ttl             = 60
  type            = each.value.type
  zone_id         = data.aws_route53_zone.umershafi.zone_id
}

resource "aws_acm_certificate_validation" "my_cert_validate" {
  certificate_arn         = aws_acm_certificate.cert.arn
  validation_record_fqdns = [for record in aws_route53_record.my_cert_dns : record.fqdn]
}

resource "aws_route53_record" "www-alias" {
  zone_id = data.aws_route53_zone.umershafi.zone_id
  name    = "www.umershafi.com"
  type    = "A"

  alias {
    name                   = var.cf_domain_name
    zone_id                = var.cf_hosted_zone_id
    evaluate_target_health = false
  }
}
