resource "kubernetes_deployment" "_2048" {
  metadata {
    labels = {
      app = var._2048_conf.name
    }
    name      = var._2048_conf.name
    namespace = "default"
  }

  spec {
    replicas = 2
    selector {
      match_labels = {
        app = var._2048_conf.name
      }
    }
    template {
      metadata {
        labels = {
          app = var._2048_conf.name
        }
      }
      spec {
        container {
          image = var._2048_conf.image
          name  = var._2048_conf.name
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
      "name"      = var._2048_conf.name
      "namespace" = "default"
    }
    "spec" = {
      entryPoints = [
        "websecure",
      ]
      routes = [
        {
          match       = "Host(`${var._2048_conf.name}.e91e63.tech`)"
          kind        = "Rule"
          middlewares = []
          services = [
            {
              name = var._2048_conf.name
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

resource "kubernetes_service" "_2048" {
  metadata {
    name      = var._2048_conf.name
    namespace = "default"
  }

  spec {
    port {
      name = "http"
      port = 80
    }
    selector = {
      app = var._2048_conf.name
    }
  }
}
