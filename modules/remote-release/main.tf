terraform {
  experiments = [module_variable_optional_attrs]
  required_providers {
    http = {
      source  = "hashicorp/http"
      version = "~> 2"
    }
    kubectl = {
      source  = "gavinbunney/kubectl"
      version = "~> 1"
    }
  }
  required_version = "~> 1"
}

data "http" "main" {
  count = length(local.conf.release.urls)

  url = local.conf.release.urls[count.index]
}

data "kubectl_file_documents" "main" {
  count = length(data.http.main)

  content = data.http.main[count.index].body
}

locals {
  conf = defaults(var.conf, {
    route = {
      service = {
        name      = var.conf.release.name
        namespace = var.conf.release.namespace
      }
      subdomain = var.conf.release.name
    }
  })
  # TODO: filter out namespaces and run those first
  documents          = slice(local.flat_documents, 1, length(local.flat_documents))
  flat_documents     = flatten(data.kubectl_file_documents.main[*].documents)
  namespace_document = slice(local.flat_documents, 0, 1)[0]
}

module "traefik_ingress_route" {
  count  = local.conf.route != null ? 1 : 0
  source = "../traefik/ingress-route"

  conf        = local.conf.route
  domain_info = var.domain_info
}

resource "kubectl_manifest" "main" {
  count = length(local.documents)
  depends_on = [
    kubectl_manifest.namespace
  ]

  wait      = true
  yaml_body = local.documents[count.index]
}

resource "kubectl_manifest" "namespace" {
  wait      = true
  yaml_body = local.namespace_document
}
