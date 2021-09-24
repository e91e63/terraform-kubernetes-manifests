resource "kubernetes_deployment" "quote" {
  metadata {
    name      = "quote"
    namespace = "default"
  }

  spec {
    replicas = 1
    selector {
      match_labels = {
        app = "quote"
      }
    }
    strategy {
      type = "RollingUpdate"
    }
    template {
      metadata {
        labels = {
          app = "quote"
        }
      }
      spec {
        container {
          image = var.quote_conf.image
          name  = "quote"
          port {
            container_port = 8080
            name           = "http"
          }
        }
      }
    }
  }
}

resource "kubernetes_service" "quote" {
  metadata {
    annotations = {
      "a8r.io/bugs"          = "https://github.com/datawire/quote/issues"
      "a8r.io/chat"          = "#ambassador"
      "a8r.io/dependencies"  = "None"
      "a8r.io/description"   = "Quote of the moment service"
      "a8r.io/documentation" = "https://github.com/datawire/quote/blob/master/README.md"
      "a8r.io/incidents"     = "https://github.com/datawire/quote/issues"
      "a8r.io/owner"         = "No owner"
      "a8r.io/repository"    = "https://github.com/datawire/quote"
      "a8r.io/runbook"       = "https://github.com/datawire/quote/blob/master/README.md"
      "a8r.io/support"       = "http://a8r.io/Slack"
    }
    name      = "quote"
    namespace = "default"
  }

  spec {
    port {
      name        = "http"
      port        = 80
      target_port = 8080
    }
    selector = {
      app = "quote"
    }
  }
}

resource "kubernetes_manifest" "ambassador_mapping" {
  manifest = {
    "apiVersion" = "getambassador.io/v2"
    "kind"       = "Mapping"
    "metadata" = {
      "name"      = "quote"
      "namespace" = "default"
    }
    "spec" = {
      # "host"    = "quote.cddc39.tech"
      "prefix"  = "/quote"
      "service" = "quote"
    }
  }
}
