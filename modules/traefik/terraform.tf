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
    cluster_ca_certificate = base64decode(var.k8s_info.cluster_ca_certificate)
    host                   = var.k8s_info.host
    token                  = var.k8s_info.token
  }
}

provider "kubernetes" {
  cluster_ca_certificate = base64decode(var.k8s_info.cluster_ca_certificate)
  host                   = var.k8s_info.host
  token                  = var.k8s_info.token

  experiments {
    manifest_resource = true
  }
}
