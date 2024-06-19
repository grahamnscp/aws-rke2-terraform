variable "ami" {
  description = "AMI of image for the EC2 instances, currently only SUSE is supported"
  type = string
  default = "ami-0c544bda9765444c2"
}

variable "aws_profile" {
  description = "AWS CLI Profile"
  type = string
}

variable "region" {
  description = "AWS Region"
  type        = string
  default     = "us-east-1"
}

variable "prefix" {
  description = "Prefix of the EC2 instance name"
  type        = string
  default     = "grke2"
}

variable "route53_zone_id" {
  type        = string
}

variable "route53_domain" {
  type        = string
}

variable "route53_subdomain" {
  type        = string
}

variable "aws_tags" {
  description = "Default tags to use for AWS"
  type        = map(string)
}

# security group source ips:
variable "ip_cidr_me" {
  type        = string
}

variable "ip_cidr_work" {
  type        = string
}

variable "instances_masters" {
  type = set(string)
  default = [ "master-1", "master-2", "master-3" ]
}
variable "instances_master1" {
  type = set(string)
  default = [ "master-1" ]
}
variable "instances_other_masters" {
  type = set(string)
  default = [ "master-2", "master-3" ]
}
variable "instances_workers" {
  type = set(string)
  default = [ "worker-1", "worker-2" ]
}

variable "instance_type" {
  description = "Size of the EC2 instance"
  type        = string
  default     = "t3.medium"
}

variable "volume_type" {
  description = "Value of the Name tag for the EC2 instance"
  type        = string
  default     = "gp2"
}

variable "volume_size" {
  description = "Value of the Name tag for the EC2 instance"
  type        = number
  default     = 60
}

variable "key_name" {
  description = "Name of Keypair to use for SSH"
  type        = string
}

variable "rke2_version" {
  description = "RKE2 Version"
  type        = string
  default     = "v1.26.4-rc1+rke2r1"
}

variable "rke2_token" {
  description = "RKE2 cluster join token string"
  type        = string
  default     = "jointoken"
}

variable "user_data_logfile" {
  type        = string
  default     = "/root/user_data.log"
}

