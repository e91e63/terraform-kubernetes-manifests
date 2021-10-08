resource "kubernetes_deployment" "main" {
  metadata {
    name      = var.service_conf.name
    namespace = "default"
  }

  spec {
    replicas = 1
    selector {
      match_labels = {
        app = var.service_conf.name
      }
    }
    strategy {
      type = "RollingUpdate"
    }
    template {
      metadata {
        labels = {
          app = var.service_conf.name
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

resource "kubernetes_manifest" "traefik_ingress_route" {
  manifest = {
    "apiVersion" = "traefik.containo.us/v1alpha1"
    "kind"       = "IngressRoute"
    "metadata" = {
      "name"      = var.service_conf.name
      "namespace" = "default"
    }
    "spec" = {
      entryPoints = [
        "websecure",
      ]
      routes = [
        {
          match = "Host(`${var.service_conf.name}.${var.domain_info.name}`)"
          kind  = "Rule"
          middlewares = [
            {
              name = "admin-users"
            }
          ]
          services = [
            {
              name = var.service_conf.name
              port = 80
            }
          ]
        }
      ]
      tls = {
        secretName = var.domain_info.tls_secret_name
      }
    }
  }
}

resource "kubernetes_service" "main" {
  metadata {
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
      app = var.service_conf.name
    }
  }
}
