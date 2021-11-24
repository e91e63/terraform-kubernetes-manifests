terraform {
  required_providers {
    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = "~> 2"
    }
  }
  required_version = "~> 1"
}

# https://doc.traefik.io/traefik/middlewares/http/basicauth/
resource "kubernetes_manifest" "traefik_middleware" {
  manifest = {
    apiVersion = "traefik.containo.us/v1alpha1"
    kind       = "Middleware"
    metadata = {
      "name"      = var.conf.name
      "namespace" = "default"
    }
    spec = {
      basicAuth = {
        removeHeader = true
        secret       = kubernetes_secret.users.metadata[0].name
      }
    }
  }
}

resource "kubernetes_secret" "users" {
  metadata {
    name = "traefik-basic-auth-${var.conf.name}"
  }

  data = {
    users = join("\n", var.conf.users)
  }
}
