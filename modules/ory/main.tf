module "postgresql" {
  # TODO: Source directly from gitlab
  source = "../../../terraform-digitalocean-postgresql/modules/client-db"

  postgresql_conf = var.postgresql_conf
}

resource "helm_release" "ory_kratos" {
  chart   = "ory/kratos"
  name    = "ory-kratos"
  version = "0.19.3"

  values = [
     jsonencode({
      kratos = {
        config = {
          dsn = module.postgresql.client_db.dsn
          session = [
            random_password.session_cookie.result,
            random_password.session_default.result
          ]
        }
      }
    })
  ]
}

resource "helm_release" "ory_oathkeeper" {
  chart   = "ory/oathkeeper"
  name    = "ory-oathkeeper"
  version = "0.19.3"
}

resource "kubernetes_manifest" "ory_kratos" {
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

resource "random_password" "session_cookie" {
  length  = 24
  special = true
}

resource "random_password" "session_default" {
  length  = 24
  special = true
}
