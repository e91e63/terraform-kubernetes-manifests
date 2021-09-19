terraform {
  required_version = "~> 1"
  required_providers {
    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = "2.5.0"
    }
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
