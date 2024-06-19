# Route53 for instances

resource "aws_route53_record" "master1" {

  for_each = var.instances_master1

  zone_id = "${var.route53_zone_id}"

  name = "${var.prefix}-${each.key}.${var.route53_subdomain}.${var.route53_domain}"
  type = "A"
  ttl = "300"
  records = [aws_instance.master1[each.value].public_ip]
}

resource "aws_route53_record" "other-masters" {

  for_each = var.instances_other_masters

  zone_id = "${var.route53_zone_id}"

  name = "${var.prefix}-${each.key}.${var.route53_subdomain}.${var.route53_domain}"
  type = "A"
  ttl = "300"
  records = [aws_instance.other-masters[each.value].public_ip]
}

resource "aws_route53_record" "workers" {

  for_each = var.instances_workers

  zone_id = "${var.route53_zone_id}"

  name = "${var.prefix}-${each.key}.${var.route53_subdomain}.${var.route53_domain}"
  type = "A"
  ttl = "300"
  records = [aws_instance.workers[each.value].public_ip]
}
