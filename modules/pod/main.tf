terraform {
  required_version = "~> 1"
  required_providers {
    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = "~> 2"
    }
  }
}

resource "kubernetes_pod" "main" {
  lifecycle {
    ignore_changes = [
      spec[0].container[0].volume_mount
    ]
  }

  metadata {
    annotations = {}
    labels      = {}
    name        = var.pod_conf.name
    namespace   = "default"
  }

  spec {
    container {
      args    = []
      command = var.pod_conf.command
      image   = var.pod_conf.image
      name    = var.pod_conf.name
    }
    node_selector = {}
  }
}
