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

  set {
    name  = "reloader.watchGlobally"
    value = "false"
  }
}

# https://pagopa.atlassian.net/wiki/spaces/DEVOPS/pages/611648258/AKS+Blueprint+upgrade+from+v1+to+v2
resource "helm_release" "cert-mounter" {
  name       = "cert-mounter-blueprint"
  chart      = "cert-mounter-blueprint"
  repository = "https://pagopa.github.io/aks-helm-cert-mounter-blueprint"
  version    = "1.0.4"
  namespace  = kubernetes_namespace.namespace.metadata[0].name

  set {
    name  = "namespace"
    value = kubernetes_namespace.namespace.metadata[0].name
  }

  set {
    name  = "deployment.create"
    value = "true"
  }

  set {
    name  = "kvCertificatesName[0]"
    value = replace("${local.ingress_hostname}.${local.internal_dns_zone_name}", ".", "-")
  }

  set {
    name  = "keyvault.name"
    value = data.azurerm_key_vault.kv.name
  }

  set {
    name  = "keyvault.tenantId"
    value = data.azurerm_client_config.current.tenant_id
  }
}
