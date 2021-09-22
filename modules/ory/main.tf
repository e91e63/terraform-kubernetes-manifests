module "postgresql" {
  # TODO: Source directly from gitlab
  source = "../../../terraform-digitalocean-postgresql/modules/client-db"

  client_name     = "ory-kratos"
  postgresql_conf = var.postgresql_conf
}

resource "helm_release" "ory_kratos" {
  chart      = "kratos"
  name       = "ory-kratos"
  repository = "https://k8s.ory.sh/helm/charts"
  version    = "0.19.3"

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

resource "helm_release" "ory_kratos_ui" {
  chart      = "kratos-selfservice-ui-node"
  name       = "ory-kratos-ui"
  repository = "https://k8s.ory.sh/helm/charts"
  version    = "0.19.3"

  values = [
    jsonencode({
      kratosPublicUrl = "http://ory-kratos:4433/"
      kratosAdminUrl  = "http://ory-kratos:4434/"
    })
  ]
}

resource "helm_release" "ory_oathkeeper" {
  chart      = "oathkeeper"
  name       = "ory-oathkeeper"
  repository = "https://k8s.ory.sh/helm/charts"
  version    = "0.19.3"

  values = [
    jsonencode({
      oathkeeper = {
        config = {
          authenticators = {
            noop = {
              enabled = true
            }
            cookie_session = {
              config = {
                check_session_url = "http://kratos:4433/sessions/whoami"
                preserve_path     = true
                extra_from        = "@this"
                subject_from      = "identity_id"
                only              = ["ory_kratos_session"]
              }
              enabled = true
            }
          }
        }
      }
    })
  ]
}

resource "kubernetes_manifest" "ory_oathkeeper_ambassador" {
  manifest = {
    apiVersion = "getambassador.io/v2"
    kind       = "AuthService"
    metadata = {
      name      = "ory-oathkeeper-authentication"
      namespace = "default"
    }
    spec = {
      auth_service = "ory-oathkeeper"
      path_prefix  = "/judge"
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
