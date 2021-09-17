terraform {
  required_version = "~> 1"
  required_providers {
    helm = {
      source  = "hashicorp/helm"
      version = "2.3.0"
    }
    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = "2.5.0"
    }
  }
}

provider "helm" {
  kubernetes {
    cluster_ca_certificate = base64decode(var.kube_config.cluster_ca_certificate)
    host                   = var.kube_config.host
    token                  = var.kube_config.token
  }
}

provider "kubernetes" {
  cluster_ca_certificate = base64decode(var.kube_config.cluster_ca_certificate)
  host                   = var.kube_config.host
  token                  = var.kube_config.token

  experiments {
    manifest_resource = true
  }
}
