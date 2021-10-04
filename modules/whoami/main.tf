resource "kubernetes_deployment" "whoami" {
  metadata {
    labels = {
      app = var.whoami_conf.name
    }
    name      = var.whoami_conf.name
    namespace = "default"
  }

  spec {
    replicas = 1
    selector {
      match_labels = {
        app = var.whoami_conf.name
      }
    }
    template {
      metadata {
        labels = {
          app = var.whoami_conf.name
        }
      }
      spec {
        container {
          image = var.whoami_conf.image
          name  = var.whoami_conf.name
          port {
            container_port = 80
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
      "name"      = "whoami"
      "namespace" = "default"
    }
    "spec" = {
      entryPoints = [
        "websecure",
      ]
      routes = [
        {
          match = "Host(`whoami.e91e63.tech`)"
          kind  = "Rule"
          middlewares = [
            {
              name = "private-users"
            }
          ]
          services = [
            {
              name = "whoami"
              port = 80
            }
          ]
        }
      ]
      tls = {
        secretName = "e91e63.tech-cert"
      }
    }
  }
}

resource "kubernetes_service" "whoami" {
  metadata {
    name      = var.whoami_conf.name
    namespace = "default"
  }

  spec {
    port {
      name     = "http"
      port     = 80
      protocol = "TCP"
    }
    selector = {
      app = var.whoami_conf.name
    }
  }
}
