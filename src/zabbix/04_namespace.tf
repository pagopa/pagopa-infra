resource "kubernetes_namespace" "domain_namespace" {
  metadata {
    name = var.domain
  }
}

module "domain_pod_identity" {
  source = "git::https://github.com/pagopa/terraform-azurerm-v3.git//kubernetes_pod_identity?ref=v7.23.0"

  resource_group_name = local.aks_resource_group_name
  location            = var.location
  tenant_id           = data.azurerm_subscription.current.tenant_id
  cluster_name        = local.aks_name

  identity_name = "${var.domain}-pod-identity"
  namespace     = kubernetes_namespace.domain_namespace.metadata[0].name
  key_vault_id  = data.azurerm_key_vault.kv_core.id

  key_permissions    = ["Get", "Decrypt"]
  secret_permissions = ["Get"]
}

resource "helm_release" "reloader" {
  name       = "reloader"
  repository = "https://stakater.github.io/stakater-charts"
  chart      = "reloader"
  version    = "v1.0.30"
  namespace  = kubernetes_namespace.domain_namespace.metadata[0].name

  set {
    name  = "reloader.watchGlobally"
    value = "false"
  }
}
