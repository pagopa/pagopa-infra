resource "kubernetes_namespace" "namespace" {
  metadata {
    name = var.domain
  }
}

module "pod_identity" {
  source = "git::https://github.com/pagopa/azurerm.git//kubernetes_pod_identity?ref=v2.13.1"

  resource_group_name = local.aks_resource_group_name
  location            = var.location
  tenant_id           = data.azurerm_subscription.current.tenant_id
  cluster_name        = local.aks_name

  identity_name = "${kubernetes_namespace.namespace.metadata[0].name}-pod-identity" // TODO add env in name
  namespace     = kubernetes_namespace.namespace.metadata[0].name
  key_vault     = data.azurerm_key_vault.kv

  secret_permissions = ["Get"]
}

resource "helm_release" "reloader" {
  name       = "reloader"
  repository = "https://stakater.github.io/stakater-charts"
  chart      = "reloader"
  version    = "v0.0.110"
  namespace  = kubernetes_namespace.namespace.metadata[0].name

  # enabled it if you remove accidentally reloader
  # force_update = true

  set {
    name  = "reloader.watchGlobally"
    value = "false"
  }
}
