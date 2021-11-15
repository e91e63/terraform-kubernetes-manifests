locals {
  conf = defaults(var.conf, {
    kind = "Service"
    path = ""
    service = {
      port      = 80
      name      = var.conf.subdomain
      namespace = "default"
    }
  })
  label      = local.conf.kind == "Service" ? local.conf.service.name : "traefik"
  host       = "${local.conf.subdomain}.${var.domain_info.name}"
  match_host = "Host(`${local.host}`)"
  match_path = local.conf.path != "" ? "Path(`${local.conf.path}`)" : ""
  match      = join(" && ", compact([local.match_host, local.match_path]))
  name       = replace(local.uri, "/", "-")
  uri        = join("", compact([local.host, local.conf.path]))
  url        = "https://${local.uri}"
}

resource "kubernetes_manifest" "main" {
  manifest = {
    apiVersion = "traefik.containo.us/v1alpha1"
    kind       = "IngressRoute"
    metadata = {
      labels = {
        "app.kubernetes.io/names" = local.label
      }
      name      = local.name
      namespace = "default"
    }
    spec = {
      entryPoints = [
        "websecure",
      ]
      routes = [
        {
          match = local.match
          kind  = "Rule"
          middlewares = [for middleware in local.conf.middlewares : {
            name      = middleware.name
            namespace = middleware.namespace
          } if middleware.name != null]
          services = [
            {
              name      = local.conf.service.name
              namespace = local.conf.service.namespace
              kind      = local.conf.kind
              port      = local.conf.service.port
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
