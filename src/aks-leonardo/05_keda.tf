resource "kubernetes_namespace" "keda" {
  metadata {
    name = "keda"
  }
}

locals {
  keda_namespace_name = kubernetes_namespace.keda.metadata[0].name
}

module "keda_pod_identity" {
  source = "git::https://github.com/pagopa/terraform-azurerm-v3.git//kubernetes_pod_identity?ref=v8.17.1"

  resource_group_name = azurerm_resource_group.rg_aks.name
  location            = var.location

  identity_name = "${local.keda_namespace_name}-pod-identity"
  tenant_id     = data.azurerm_subscription.current.tenant_id

  cluster_name = module.aks_leonardo.name
  namespace    = kubernetes_namespace.keda.metadata[0].name

  depends_on = [
    module.aks_leonardo
  ]
}

resource "azurerm_role_assignment" "keda_monitoring_reader" {
  scope                = data.azurerm_subscription.current.id
  role_definition_name = "Monitoring Reader"
  principal_id         = module.keda_pod_identity.identity.principal_id

  depends_on = [
    module.aks_leonardo,
    module.keda_pod_identity
  ]
}

resource "helm_release" "keda" {
  name       = "keda"
  chart      = "keda"
  repository = "https://kedacore.github.io/charts"
  version    = var.keda_helm_version
  namespace  = kubernetes_namespace.keda.metadata[0].name
  wait       = false

  set {
    name  = "podIdentity.activeDirectory.identity"
    value = "${local.keda_namespace_name}-pod-identity"
  }
}
