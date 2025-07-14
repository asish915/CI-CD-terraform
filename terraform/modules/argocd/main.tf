resource "helm_release" "argo_cd" {
  name       = "argocd"
  namespace  = "argocd"
  create_namespace = true

  repository = "https://argoproj.github.io/argo-helm"
  chart      = "argo-cd"
  version    = "5.46.8"

  set {
    name  = "server.service.type"
    value = "LoadBalancer"
  }
}