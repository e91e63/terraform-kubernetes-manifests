terraform {
  experiments = [module_variable_optional_attrs]
  required_providers {
    http = {
      source  = "hashicorp/http"
      version = "~> 2"
    }
    kubectl = {
      source  = "gavinbunney/kubectl"
      version = "~> 1"
    }
  }
}
