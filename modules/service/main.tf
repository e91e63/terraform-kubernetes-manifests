locals {
  conf = defaults(var.conf, {
    port_container = 80
    port_service   = 80
    route = {
      subdomain = var.conf.name
    }
  })
}

module "traefik_ingress_route" {
  count  = local.conf.route != null ? 1 : 0
  source = "../traefik/ingress-route"

  conf = merge(
    local.conf.route,
    {
      service = {
        name      = local.conf.name
        namespace = local.conf.namespace
        port      = local.conf.port_service
      }
    },
  )
  domain_info = var.domain_info
}

resource "kubernetes_deployment" "main" {
  metadata {
    labels = {
      "app.kubernetes.io/name" = local.conf.name
    }
    name      = local.conf.name
    namespace = local.conf.namespace
  }

  spec {
    replicas = 1
    selector {
      match_labels = {
        "app.kubernetes.io/name" = local.conf.name
      }
    }
    strategy {
      type = "RollingUpdate"
    }
    template {
      metadata {
        labels = {
          "app.kubernetes.io/name" = local.conf.name
        }
      }
      spec {
        container {
          image = local.conf.image
          name  = local.conf.name
          port {
            container_port = local.conf.port_container
            name           = "http"
          }
        }
      }
    }
  }
}

resource "kubernetes_service" "main" {
  metadata {
    labels = {
      "app.kubernetes.io/name" = local.conf.name
    }
    name      = local.conf.name
    namespace = "default"
  }

  spec {
    port {
      name        = "http"
      port        = local.conf.port_service
      target_port = local.conf.port_container
    }
    selector = {
      "app.kubernetes.io/name" = local.conf.name
    }
  }
}
