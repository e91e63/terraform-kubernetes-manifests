# TODO: properly tag load balancer
resource "helm_release" "ambassador" {
  chart      = "ambassador"
  name       = "ambassador"
  repository = "https://getambassador.io"
  version    = "v6.9.1"

  set {
    name  = "authService.create"
    value = false
  }
}

resource "kubernetes_manifest" "consulresolver" {
  manifest = {
    "apiVersion" = "getambassador.io/v2"
    "kind"       = "ConsulResolver"
    "metadata" = {
      "name"      = "consul"
      "namespace" = "default"
    }
    "spec" = {
      "address" = "consul:8500"
    }
  }
}

resource "kubernetes_manifest" "deployment_quote" {
  manifest = {
    "apiVersion" = "apps/v1"
    "kind"       = "Deployment"
    "metadata" = {
      "name"      = "quote"
      "namespace" = "default"
    }
    "spec" = {
      "replicas" = 1
      "selector" = {
        "matchLabels" = {
          "app" = "quote"
        }
      }
      "strategy" = {
        "type" = "RollingUpdate"
      }
      "template" = {
        "metadata" = {
          "labels" = {
            "app" = "quote"
          }
        }
        "spec" = {
          "containers" = [
            {
              "image" = "docker.io/datawire/quote:0.5.0"
              "name"  = "backend"
              "ports" = [
                {
                  "containerPort" = 8080
                  "name"          = "http"
                },
              ]
            },
          ]
        }
      }
    }
  }
}

resource "kubernetes_manifest" "service_quote" {
  manifest = {
    "apiVersion" = "v1"
    "kind"       = "Service"
    "metadata" = {
      "annotations" = {
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
      "name"      = "quote"
      "namespace" = "default"
    }
    "spec" = {
      "ports" = [
        {
          "name"       = "http"
          "port"       = 80
          "targetPort" = 8080
        },
      ]
      "selector" = {
        "app" = "quote"
      }
    }
  }
}

resource "kubernetes_manifest" "mapping_quote_backend" {
  manifest = {
    "apiVersion" = "getambassador.io/v2"
    "kind"       = "Mapping"
    "metadata" = {
      "name"      = "quote-backend"
      "namespace" = "default"
    }
    "spec" = {
      # "host"    = "quotes.cddc39.tech"
      "prefix"  = "/quote"
      "service" = "quote"
    }
  }
}

# Some alternative auth services include UAA and Dex
# resource "kubernetes_manifest" "filter_google" {
#   manifest = {
#     "apiVersion" = "getambassador.io/v2"
#     "kind"       = "Filter"
#     "metadata" = {
#       "name"      = "google"
#       "namespace" = "default"
#     }
#     "spec" = {
#       "OAuth2" = {
#         "authorizationURL" = "https://accounts.google.com"
#         "clientID"         = var.google_oauth.client_id
#         "protectedOrigins" = [
#           {
#             "origin" = "https://e91e63.tech"
#           },
#         ]
#         "secret" = var.google_oauth.client_secret
#       }
#     }
#   }
# }

# resource "kubernetes_manifest" "filterpolicy_google_policy" {
#   manifest = {
#     "apiVersion" = "getambassador.io/v2"
#     "kind"       = "FilterPolicy"
#     "metadata" = {
#       "name"      = "google-policy"
#       "namespace" = "default"
#     }
#     "spec" = {
#       "rules" = [
#         {
#           "filters" = [
#             {
#               "name" = "google"
#             },
#           ]
#           "host" = "*"
#           "path" = "/quote"
#         },
#       ]
#     }
#   }
# }
