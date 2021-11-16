locals {
  conf = defaults(var.conf, {
    route = {
      service = {
        name      = var.conf.helm.name
        namespace = var.conf.helm.namespace
      }
      subdomain = var.conf.helm.name
    }
  })
}

module "traefik_ingress_route" {
  count  = local.conf.route != null ? 1 : 0
  source = "../traefik/ingress-route/"

  conf        = local.conf.route
  domain_info = var.domain_info
}

resource "helm_release" "main" {
  chart      = local.conf.helm.chart
  name       = local.conf.helm.name
  namespace  = local.conf.helm.namespace
  repository = local.conf.helm.repository
  version    = local.conf.helm.chart_version
  wait       = true

  values = [
    jsonencode(local.conf.helm.values)
  ]
}

terraform {
  experiments      = [module_variable_optional_attrs]
  required_version = "~> 1"
  required_providers {
    helm = {
      source  = "hashicorp/helm"
      version = "~> 2"
    }
  }
}
