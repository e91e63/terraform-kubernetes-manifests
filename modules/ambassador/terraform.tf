terraform {
  required_version = "~> 1"
  required_providers {
    helm = {
      source  = "hashicorp/helm"
      version = "2.3.0"
    }
  }
}

provider "helm" {
  kubernetes {
    cluster_ca_certificate = base64decode(var.k8s_conf.cluster_ca_certificate)
    host                   = var.k8s_conf.host
    token                  = var.k8s_conf.token
  }
}
