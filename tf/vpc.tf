# VPC

module "vpc" {
    source = "terraform-aws-modules/vpc/aws"

    name = "vpc-${var.prefix}-${random_string.suffix.result}"
    cidr = "10.0.0.0/16"
    azs = ["${var.region}a", "${var.region}b", "${var.region}c"]
    private_subnets = ["10.0.64.0/24", "10.0.65.0/24", "10.0.66.0/24"]
    public_subnets  = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24"]

    enable_nat_gateway = false
    single_nat_gateway = true
    enable_vpn_gateway = false
    enable_dns_hostnames = true
    enable_dns_support = true
    enable_flow_log = false
    map_public_ip_on_launch = true
}

