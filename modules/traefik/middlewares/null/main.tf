terraform {
  required_providers {
    null = {
      source  = "hashicorp/null"
      version = "3.1.0"
    }
  }
  required_version = "~> 1"
}

resource "null_resource" "main" {}
