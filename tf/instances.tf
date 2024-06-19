# Instances:

# master1
resource "aws_instance" "master1" {

  for_each = var.instances_master1

  instance_type = var.instance_type
  ami           = var.ami
  key_name      = "${var.key_name}"

  root_block_device {
    volume_size = var.volume_size
    volume_type = var.volume_type
  }

  iam_instance_profile = "${aws_iam_instance_profile.master_instance_profile.id}"

  subnet_id = module.vpc.public_subnets[0]
  vpc_security_group_ids = ["${aws_security_group.instance_sg.id}"]

  tags = {
    Name = "${var.prefix}-${each.key}"
  }

  user_data = data.template_cloudinit_config.server1_config.rendered
}

# other masters
resource "aws_instance" "other-masters" {

  for_each = var.instances_other_masters

  instance_type = var.instance_type
  ami           = var.ami
  key_name      = "${var.key_name}"

  root_block_device {
    volume_size = var.volume_size
    volume_type = var.volume_type
  }

  iam_instance_profile = "${aws_iam_instance_profile.master_instance_profile.id}"

  subnet_id = module.vpc.public_subnets[0]
  vpc_security_group_ids = ["${aws_security_group.instance_sg.id}"]

  tags = {
    #Name = "${var.prefix}-${each.key}-${random_string.suffix.result}"
    Name = "${var.prefix}-${each.key}"
  }

  user_data = data.template_cloudinit_config.servers_config.rendered
}


# workers
resource "aws_instance" "workers" {

  for_each = var.instances_workers

  instance_type = var.instance_type
  ami           = var.ami
  key_name      = "${var.key_name}"

  iam_instance_profile = "${aws_iam_instance_profile.worker_instance_profile.id}"

  subnet_id = module.vpc.public_subnets[0]
  vpc_security_group_ids = ["${aws_security_group.instance_sg.id}"]

  root_block_device {
    volume_size = var.volume_size
    volume_type = var.volume_type
  }

  tags = {
    #Name = "${var.prefix}-${each.key}-${random_string.suffix.result}"
    Name = "${var.prefix}-${each.key}"
  }

  user_data = data.template_cloudinit_config.worker_config.rendered
}

# nat
#module "nat" {
#  source = "int128/nat-instance/aws"
#
#  name                        = "nat-${var.prefix}-${random_string.suffix.result}"
#  vpc_id                      = module.vpc.vpc_id
#  public_subnet               = module.vpc.public_subnets[0]
#  private_subnets_cidr_blocks = module.vpc.private_subnets_cidr_blocks
#  private_route_table_ids     = module.vpc.private_route_table_ids
#  use_spot_instance           = true
#}

#resource "aws_eip" "nat" {
#  network_interface = module.nat.eni_id
#}

