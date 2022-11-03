resource "kubernetes_namespace" "namespace" {
  metadata {
    name = var.domain
  }
}

# module "ingress" {
#   source = "git::https://github.com/pagopa/azurerm.git//kubernetes_ingress?ref=v2.13.1"

#   resource_group_name = local.aks_resource_group_name
#   location            = var.location
#   tenant_id           = data.azurerm_subscription.current.tenant_id
#   cluster_name        = local.aks_name

#   name      = kubernetes_namespace.namespace.metadata[0].name
#   namespace = kubernetes_namespace.namespace.metadata[0].name
#   key_vault = data.azurerm_key_vault.kv

#   host = "${local.ingress_hostname}.${local.internal_dns_zone_name}"
#   rules = [
#     {
#       path         = "/pagopa-ecommerce-transactions-service/(.*)"
#       service_name = "pagopaecommercetransactionsservice-microservice-chart"
#       service_port = 8080
#     }
#   ]
# }

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

  set {
    name  = "reloader.watchGlobally"
    value = "false"
  }
}
