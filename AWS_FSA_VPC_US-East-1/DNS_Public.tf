resource "aws_route53_record" "fsa1_Public_DNS" {
  provider = aws.fsa_1_vpc
  zone_id = var.Public_SubHosted_Zone_id
  name    = "fsa"
  type    = "A"
  ttl     = "10"
  records = [aws_eip.fsa_1_wan.public_ip]
}