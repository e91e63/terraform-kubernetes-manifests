# Kubernetes Remote Release

This folder contains a [Terraform module](https://www.terraform.io/docs/language/modules/index.html) that deploys release files from HTTP sources to Kubernetes.
A release file is one or more YAML manifests joined into one file. Release files are typically found on a project's GitHub Releases page. It is preferable to use a Kubernetes Operator or Helm chart if available.
