terraform {
  experiments      = [module_variable_optional_attrs]
  required_version = "~> 1"
  required_providers {
    helm = {
      source  = "hashicorp/helm"
      version = "~> 2"
    }
    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = "~> 2"
    }
  }
}
