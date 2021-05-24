terraform {
  required_version = ">= 0.15"
  required_providers {
    helm = {
      source  = "hashicorp/helm"
      version = "2.1.2"
    }
  }
}

# KUBE_CONFIG_PATH
provider "helm" {
  kubernetes {
    client_certificate     = var.kube_config.client_certificate
    client_key             = var.kube_config.client_key
    cluster_ca_certificate = var.kube_config.cluster_ca_certificate
    host                   = var.kube_config.host
    token                  = var.kube_config.token
  }

}
