resource "kubernetes_namespace" "gitea" {
  metadata {
    name = "gitea"
  }
}

resource "kubernetes_manifest" "gitea_cert" {
  depends_on = [ kubernetes_namespace.gitea ]
  manifest = file("${path.module}/../gitea/gitea-cert.yaml")
}

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

  depends_on = [ kubernetes_manifest.gitea_cert ]
}
