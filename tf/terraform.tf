terraform {
  required_providers {

    template = {
      source  = "registry.terraform.io/hashicorp/template"
      version = "2.2.0"
    }

    random = {
      source  = "hashicorp/random"
      version = "~> 3.4.3"
    }

  }
}
