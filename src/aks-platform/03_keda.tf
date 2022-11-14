resource "kubernetes_namespace" "keda" {
  metadata {
    name = "keda"
  }
}

module "keda_pod_identity" {
  source = "git::https://github.com/pagopa/azurerm.git//kubernetes_pod_identity?ref=v2.13.1"

  resource_group_name = azurerm_resource_group.aks_rg.name
  location            = var.location
  identity_name       = "${kubernetes_namespace.keda.metadata[0].name}-pod-identity"
  tenant_id           = data.azurerm_subscription.current.tenant_id
  cluster_name        = module.aks.name
  namespace           = kubernetes_namespace.keda.metadata[0].name
}

resource "azurerm_role_assignment" "keda_monitoring_reader" {
  scope                = data.azurerm_subscription.current.id
  role_definition_name = "Monitoring Reader"
  principal_id         = module.keda_pod_identity.identity.principal_id
}

resource "helm_release" "keda" {
  name       = "keda"
  chart      = "keda"
  repository = "https://kedacore.github.io/charts"
  version    = var.keda_helm.chart_version
  namespace  = kubernetes_namespace.keda.metadata[0].name

  set {
    name  = "podIdentity.activeDirectory.identity"
    value = "${kubernetes_namespace.keda.metadata[0].name}-pod-identity"
  }
  set {
    name  = "image.keda.repository"
    value = var.keda_helm.keda.image_name
  }
  set {
    name  = "image.keda.tag"
    value = var.keda_helm.keda.image_tag
  }
  set {
    name  = "image.metrics_api_server.repository"
    value = var.keda_helm.metrics_api_server.image_name
  }
  set {
    name  = "image.metrics_api_server.tag"
    value = var.keda_helm.metrics_api_server.image_tag
  }
}
