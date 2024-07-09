resource "helm_release" "gitea" {
  name             = "gitea"
  namespace        = "gitea"
  create_namespace = true
  repository       = "https://dl.gitea.com/charts/"

  chart   = "gitea"
  version = "10.3.0"
  wait    = true
  timeout = 600

  values = [
    file("${path.module}/gitea_values.yaml")
  ]

}
