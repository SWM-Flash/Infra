data "aws_route53_zone" "front" {
  name         = var.domain
  private_zone = false
}

resource "aws_route53_record" "front" {
  zone_id = data.aws_route53_zone.front.zone_id
  name    = terraform.workspace == "prod" ? "upload.${var.domain}" : "upload.${terraform.workspace}.${var.domain}"
  type    = "A"

  alias {
    name                   = aws_alb.staging.dns_name
    zone_id                = aws_alb.staging.zone_id
    evaluate_target_health = true
  }
}

resource "aws_route53_record" "cert_validation" {
  for_each = { for option in aws_acm_certificate.cert.domain_validation_options : option.resource_record_name => option... if option.resource_record_name != "" }

  name    = each.value[0].resource_record_name
  type    = each.value[0].resource_record_type
  zone_id = data.aws_route53_zone.front.zone_id
  records = [each.value[0].resource_record_value]
  ttl     = 60
}