# https://github.com/traefik/traefik-helm-chart/blob/master/traefik/values.yaml
# https://traefik.io/blog/integrating-consul-connect-service-mesh-with-traefik-2-5/
# https://www.padok.fr/en/blog/traefik-kubernetes-certmanager
resource "helm_release" "traefik" {
  chart      = "traefik"
  name       = "traefik"
  repository = "https://helm.traefik.io/traefik"
  timeout    = 600
  version    = var.traefik_conf.version

  values = [
    jsonencode({
      additionalArguments = [
        "--entryPoints.web.http.redirections.entryPoint.scheme=https",
        "--entryPoints.web.http.redirections.entryPoint.to=websecure",
        # "--providers.consulcatalog.connectAware=true",
        # "--providers.consulcatalog.connectByDefault=true",
        # "--providers.consulcatalog.exposedByDefault=false",
      ]
      deployment = {
        kind = "DaemonSet"
      }
      ingressRoute = {
        dashboard = {
          enabled = false
        }
      }
      ports = {
        web = {
          nodePort = 32080
          port     = 8080
        }
        websecure = {
          nodePort = 32443
          port     = 8443
        }
      }
      service = {
        type = "NodePort"
      }
    })
  ]
}

resource "kubernetes_manifest" "ingress_route_traefik" {
  manifest = {
    "apiVersion" = "traefik.containo.us/v1alpha1"
    "kind"       = "IngressRoute"
    "metadata" = {
      "name"      = "traefik"
      "namespace" = "default"
    }
    "spec" = {
      entryPoints = [
        "websecure",
      ]
      routes = [
        {
          match = "Host(`traefik.e91e63.tech`)"
          kind  = "Rule"
          middlewares = [
            {
              name = "admin-users"
            }
          ]
          services = [
            {
              name = "api@internal"
              kind = "TraefikService"
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
