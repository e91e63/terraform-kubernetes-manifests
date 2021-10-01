module "subdomain" {
  source = "../../../terraform-digitalocean-networking/modules/subdomain"

  k8s_conf       = var.k8s_conf
  subdomain_conf = var.quote_conf
}

resource "kubernetes_deployment" "quote" {
  metadata {
    name      = var.quote_conf.name
    namespace = "default"
  }

  spec {
    replicas = 1
    selector {
      match_labels = {
        app = var.quote_conf.name
      }
    }
    strategy {
      type = "RollingUpdate"
    }
    template {
      metadata {
        labels = {
          app = var.quote_conf.name
        }
      }
      spec {
        container {
          image = var.quote_conf.image
          name  = var.quote_conf.name
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
    name      = var.quote_conf.name
    namespace = "default"
  }

  spec {
    port {
      name        = "http"
      port        = 80
      target_port = 8080
    }
    selector = {
      app = var.quote_conf.name
    }
  }
}

resource "kubernetes_manifest" "ambassador_mapping" {
  manifest = {
    apiVersion = "getambassador.io/v2"
    kind       = "Mapping"
    metadata = {
      name      = var.quote_conf.name
      namespace = "default"
    }
    spec = {
      prefix  = "/quote"
      service = var.quote_conf.name
    }
  }
}
