output "route" {
  value = "https://${trimsuffix(trimprefix(kubernetes_manifest.main.object.spec.routes[0].match, "Host(`"), "`)")}/"
}
