resource "helm_release" "cert_mounter" {
  name         = "cert-mounter-blueprint"
  repository   = "https://pagopa.github.io/aks-helm-cert-mounter-blueprint"
  chart        = "cert-mounter-blueprint"
  version      = "2.0.2"
  namespace    = var.domain
  timeout      = 120
  force_update = true

  values = [
      templatefile("${path.root}/helm/cert-mounter.yaml.tpl", {
        NAMESPACE        = var.domain,
        DOMAIN           = var.domain,
        CERTIFICATE_NAME = replace(local.shared_hostname, ".", "-"),
        ENV_SHORT        = var.env_short,
        SERVICE_ACCOUNT_NAME = module.workload_identity.workload_identity_service_account_name,
        WORKLOAD_IDENTITY_CLIENT_ID = module.workload_identity.workload_identity_client_id,
      })
  ]
}

resource "helm_release" "reloader" {
  name       = "reloader"
  repository = "https://stakater.github.io/stakater-charts"
  chart      = "reloader"
  version    = "v1.0.69"
  namespace  = kubernetes_namespace.namespace.metadata[0].name

  set {
    name  = "reloader.watchGlobally"
    value = "false"
  }

  depends_on = [
    kubernetes_namespace.namespace
  ]
}
