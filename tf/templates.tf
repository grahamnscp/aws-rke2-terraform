# date templates 

# first master / server1
data "template_file" "server1" {
  template = templatefile("./user_data/run_on_server1.sh", {})
}
data "template_cloudinit_config" "server1_config" {
  gzip          = false
  base64_encode = false

  #first part of local config file
  part {
    content_type = "text/x-shellscript"
    content      = <<-EOF
    #!/bin/bash
    echo '${var.rke2_version}' > /opt/rke2_version
    echo '${var.prefix}-master-1.${var.route53_subdomain}.${var.route53_domain}' > /opt/master1_hostname
    echo '${var.rke2_token}' > /opt/rke2_token
    EOF
  }

  #second part
  part {
    content_type = "text/x-shellscript"
    content      = data.template_file.server1.rendered
  }
}

# join masters / servers
data "template_file" "servers" {
  template = templatefile("./user_data/run_on_servers.sh", {})
}
data "template_cloudinit_config" "servers_config" {
  gzip          = false
  base64_encode = false

  #first part of local config file
  part {
    content_type = "text/x-shellscript"
    content      = <<-EOF
    #!/bin/bash
    echo '${aws_instance.master1["master-1"].private_ip}' > /opt/server_ip
    echo '${var.rke2_version}' > /opt/rke2_version
    echo '${var.rke2_token}' > /opt/rke2_token
    EOF
  }

  #second part
  part {
    content_type = "text/x-shellscript"
    content      = data.template_file.servers.rendered
  }
}

# agent / client
data "template_file" "client" {
  template = templatefile("./user_data/run_on_client.sh", {})
}
data "template_cloudinit_config" "worker_config" {
  gzip          = false
  base64_encode = false

  #first part of local config file
  part {
    content_type = "text/x-shellscript"
    content      = <<-EOF
    #!/bin/bash
    echo '${aws_instance.master1["master-1"].private_ip}' > /opt/server_ip
    echo '${var.rke2_version}' > /opt/rke2_version
    echo '${var.rke2_token}' > /opt/rke2_token
    EOF
  }

  #second part
  part {
    content_type = "text/x-shellscript"
    content      = data.template_file.client.rendered
  }
}

