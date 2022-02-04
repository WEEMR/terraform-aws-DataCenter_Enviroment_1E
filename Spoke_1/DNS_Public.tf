resource "aws_route53_record" "Spoke1_FGT_Public_DNS" {
  provider = aws.virginia
  zone_id = var.Public_SubHosted_Zone_id
  name    = "FGT-spoke1"
  type    = "A"
  ttl     = "10"
  records = [aws_eip.Spoke_1_WAN1.public_ip, aws_eip.Spoke_1_WAN2.public_ip]
}

resource "aws_route53_record" "ssl_vpn" {
  provider = aws.virginia
  zone_id = var.Public_SubHosted_Zone_id
  name    = "vpn"
  type    = "A"
  ttl     = "10"
  records = [aws_eip.Spoke_1_WAN1.public_ip, aws_eip.Spoke_1_WAN2.public_ip]
}

resource "time_sleep" "wait_15_seconds_Public" {
  depends_on      = [aws_route53_record.Spoke1_FGT_Public_DNS]
  create_duration = "15s"
}

resource "aws_route53_record" "Spoke1_Linux_Public" {
  provider = aws.virginia
  depends_on = [time_sleep.wait_15_seconds_Public]
  zone_id = var.Public_SubHosted_Zone_id
  name       = "linux-spoke1"
  type       = "A"

  alias {
    name                   = aws_route53_record.Spoke1_FGT_Public_DNS.fqdn
    zone_id                = var.Public_SubHosted_Zone_id
    evaluate_target_health = true
  }
}


resource "aws_route53_record" "Spoke1_WebServer_Public" {
  provider = aws.virginia
  depends_on = [time_sleep.wait_15_seconds_Public]
  zone_id = var.Public_SubHosted_Zone_id
  name       = "WebServer-spoke1"
  type       = "A"

  alias {
    name                   = aws_route53_record.Spoke1_FGT_Public_DNS.fqdn
    zone_id                = var.Public_SubHosted_Zone_id
    evaluate_target_health = true
  }
}

resource "aws_route53_record" "Spoke1_Windows_Public" {
  provider = aws.virginia
  depends_on = [time_sleep.wait_15_seconds_Public]
  zone_id = var.Public_SubHosted_Zone_id
  name       = "Windows-spoke1"
  type       = "A"

  alias {
    name                   = aws_route53_record.Spoke1_FGT_Public_DNS.fqdn
    zone_id                = var.Public_SubHosted_Zone_id
    evaluate_target_health = true
  }
}

resource "aws_route53_record" "spoke1_FMG_Public" {
  provider = aws.virginia
  depends_on = [time_sleep.wait_15_seconds_Public]
  zone_id = var.Public_SubHosted_Zone_id
  name       = "fmg"
  type       = "A"

  alias {
    name                   = aws_route53_record.Spoke1_FGT_Public_DNS.fqdn
    zone_id                = var.Public_SubHosted_Zone_id
    evaluate_target_health = true
  }
}

resource "aws_route53_record" "spoke1_FAZ_Public" {
  provider = aws.virginia
  depends_on = [time_sleep.wait_15_seconds_Public]
  zone_id = var.Public_SubHosted_Zone_id
  name       = "FAZ"
  type       = "A"

  alias {
    name                   = aws_route53_record.Spoke1_FGT_Public_DNS.fqdn
    zone_id                = var.Public_SubHosted_Zone_id
    evaluate_target_health = true
  }
}

resource "aws_route53_record" "spoke1_FAC_Public" {
  provider = aws.virginia
  depends_on = [time_sleep.wait_15_seconds_Public]
  zone_id = var.Public_SubHosted_Zone_id
  name       = "FAC"
  type       = "A"

  alias {
    name                   = aws_route53_record.Spoke1_FGT_Public_DNS.fqdn
    zone_id                = var.Public_SubHosted_Zone_id
    evaluate_target_health = true
  }
}