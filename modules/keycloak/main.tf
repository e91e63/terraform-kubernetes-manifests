resource "kubernetes_manifest" "secret_keycloak_keycloak" {
  manifest = {
    "apiVersion" = "v1"
    "data" = {
      "password" = "aW5pdGlhbGl6ZXI="
    }
    "kind" = "Secret"
    "metadata" = {
      "name"      = "keycloak"
      "namespace" = "default"
    }
  }
}

resource "kubernetes_manifest" "service_keycloak_keycloak" {
  manifest = {
    "apiVersion" = "v1"
    "kind"       = "Service"
    "metadata" = {
      "labels" = {
        "app" = "keycloak"
      }
      "name"      = "keycloak"
      "namespace" = "default"
    }
    "spec" = {
      "ports" = [
        {
          "name"       = "http"
          "port"       = 8080
          "targetPort" = 8080
        },
      ]
      "selector" = {
        "app" = "keycloak"
      }
    }
  }
}

resource "kubernetes_manifest" "deployment_keycloak_keycloak" {
  manifest = {
    "apiVersion" = "apps/v1"
    "kind"       = "Deployment"
    "metadata" = {
      "labels" = {
        "app" = "keycloak"
      }
      "name"      = "keycloak"
      "namespace" = "default"
    }
    "spec" = {
      "replicas" = 1
      "selector" = {
        "matchLabels" = {
          "app" = "keycloak"
        }
      }
      "template" = {
        "metadata" = {
          "labels" = {
            "app" = "keycloak"
          }
        }
        "spec" = {
          "containers" = [
            {
              "env" = [
                {
                  "name"  = "KEYCLOAK_USER"
                  "value" = "admin"
                },
                {
                  "name" = "KEYCLOAK_PASSWORD"
                  "valueFrom" = {
                    "secretKeyRef" = {
                      "key"  = "password"
                      "name" = "keycloak"
                    }
                  }
                },
                {
                  "name"  = "PROXY_ADDRESS_FORWARDING"
                  "value" = "true"
                },
              ]
              "image" = "quay.io/keycloak/keycloak:11.0.3"
              "name"  = "keycloak"
              "ports" = [
                {
                  "containerPort" = 8080
                  "name"          = "http"
                },
              ]
              "readinessProbe" = {
                "httpGet" = {
                  "path" = "/auth/realms/master"
                  "port" = 8080
                }
              }
            },
          ]
        }
      }
    }
  }
}

resource "kubernetes_manifest" "mapping_keycloak_keycloak" {
  manifest = {
    "apiVersion" = "getambassador.io/v2"
    "kind"       = "Mapping"
    "metadata" = {
      "name"      = "keycloak"
      "namespace" = "default"
    }
    "spec" = {
      "prefix"  = "/auth/"
      "rewrite" = "/auth/"
      "service" = "keycloak:8080"
    }
  }
}

resource "kubernetes_manifest" "filter_ambassador_keycloak_oauth2_filter" {
  manifest = {
    "apiVersion" = "getambassador.io/v2"
    "kind"       = "Filter"
    "metadata" = {
      "name"      = "keycloak-oauth2-filter"
      "namespace" = "default"
    }
    "spec" = {
      "OAuth2" = {
        "audience"         = "ambassador"
        "authorizationURL" = "https://e91e63.tech/auth/realms/ambassador"
        "clientID"         = "ambassador"
        "protectedOrigins" = [
          {
            "origin" = "https://e91e63.tech/"
          },
        ]
        "secret" = "0db8ccf4-9074-439a-94b1-79a7404ad2ae"
      }
    }
  }
}

resource "kubernetes_manifest" "filterpolicy_api_filter_policy" {
  manifest = {
    "apiVersion" = "getambassador.io/v2"
    "kind"       = "FilterPolicy"
    "metadata" = {
      "name"      = "api-filter-policy"
      "namespace" = "default"
    }
    "spec" = {
      "rules" = [
        {
          "filters" = [
            {
              "arguments" = {
                "scopes" = [
                  "offline_access",
                ]
              }
              "name"      = "keycloak-oauth2-filter"
              "namespace" = "default"
            },
          ]
          "host" = "*"
          "path" = "/backend/"
        },
      ]
    }
  }
}
