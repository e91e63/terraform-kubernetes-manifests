module "traefik_ingress_route" {
  source = "../traefik-ingress-route/"

  domain_info  = var.domain_info
  service_conf = var.service_conf
}

resource "kubernetes_deployment" "main" {
  metadata {
    labels = {
      "app.kubernetes.io/name" = var.service_conf.name
    }
    name      = var.service_conf.name
    namespace = "default"
  }

  spec {
    replicas = 1
    selector {
      match_labels = {
        "app.kubernetes.io/name" = var.service_conf.name
      }
    }
    strategy {
      type = "RollingUpdate"
    }
    template {
      metadata {
        labels = {
          "app.kubernetes.io/name" = var.service_conf.name
        }
      }
      spec {
        container {
          image = var.service_conf.image
          name  = var.service_conf.name
          port {
            container_port = var.service_conf.container_port
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
      "app.kubernetes.io/name" = var.service_conf.name
    }
    name      = var.service_conf.name
    namespace = "default"
  }

  spec {
    port {
      name        = "http"
      port        = 80
      target_port = var.service_conf.container_port
    }
    selector = {
      "app.kubernetes.io/name" = var.service_conf.name
    }
  }
}