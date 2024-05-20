data "kubernetes_namespace" "namespace" {
  metadata {
    name = local.elk_namespace
  }
}

module "pod_identity" {
  source = "git::https://github.com/pagopa/terraform-azurerm-v3.git//kubernetes_pod_identity?ref=v7.70.1"

  resource_group_name = local.aks_resource_group_name
  location            = var.location
  tenant_id           = data.azurerm_subscription.current.tenant_id
  cluster_name        = local.aks_name

  identity_name = "${data.kubernetes_namespace.namespace.metadata[0].name}-pod-identity" // TODO add env in name
  namespace     = data.kubernetes_namespace.namespace.metadata[0].name
  key_vault_id  = module.key_vault.id

  secret_permissions = ["Get"]
}

resource "helm_release" "reloader" {
  name       = "reloader"
  repository = "https://stakater.github.io/stakater-charts"
  chart      = "reloader"
  version    = "v1.0.48"
  namespace  = data.kubernetes_namespace.namespace.metadata[0].name

  set {
    name  = "reloader.watchGlobally"
    value = "false"
  }
}
