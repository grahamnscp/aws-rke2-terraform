
output "aws-region" {
  value = "${var.region}"
}

# Domain
output "domainname" {
  value = "${var.route53_subdomain}.${var.route53_domain}"
}

# DNS names
output "master1-instance-name" {
  value = {for server in aws_route53_record.master1: server.name => server.records}
}
output "other-master-instance-names" {
  value = {for server in aws_route53_record.other-masters: server.name => server.records}
}
output "workers-instance-names" {
  value = {for server in aws_route53_record.workers: server.name => server.records}
}

# Instance IPs
output "master1-instance-public-name" {
  value = {for server in aws_instance.master1: server.tags.Name => server.public_dns}
}
output "master1-instance-public-ip" {
  value = {for server in aws_instance.master1: server.tags.Name => server.public_ip}
}
output "master1-instance-private-ip" {
  value = {for server in aws_instance.master1: server.tags.Name => server.private_ip}
}
#
output "other-masters-instance-public-ip" {
  value = {for server in aws_instance.other-masters: server.tags.Name => server.public_ip}
}
output "workers-instance-public-ip" {
  value = {for server in aws_instance.workers: server.tags.Name => server.public_ip}
}

