# aws-rke2-cluster
Terraform to bootstrap an RKE2 cluster in AWS

## Configuration

### Create a `terraform.tfvars`

Copy tf/terraform.tfvars.example and edit as required
```
cp tf/terraform.tfvars.example tf/terraform.tfvars
```

note the allowed IP CIDRs for ingress, set the first one to your public ip 
```
echo `curl -s icanhazip.com`/32
```

### Set a prefix for instance names and other resources
prefix = "rke2-test"

## Mac arm64/M1 enable terraform templates

Terraform templates was removed for arm64 macs..

```
brew install kreuzwerker/taps/m1-terraform-provider-helper
m1-terraform-provider-helper activate
m1-terraform-provider-helper install hashicorp/template -v v2.2.0
```


## Installation

```
cd tf
terraform init

terraform plan -out tfplan.out

terraform apply tfplan.out

```
Wait for the user_data scripts to run and then the host(s) will reboot


## Notes
* Currently only SUSE AMI is supported due to the bootstrap scripts

