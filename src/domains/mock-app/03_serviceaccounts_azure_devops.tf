resource "kubernetes_namespace" "namespace_system" {
  count = var.mock_enabled ? 1 : 0
  metadata {
    name = "${var.domain}-system"
  }
}

resource "kubernetes_service_account" "azure_devops" {
  count = var.mock_enabled ? 1 : 0

  metadata {
    name      = "azure-devops"
    namespace = kubernetes_namespace.namespace_system[0].metadata[0].name
  }
  automount_service_account_token = false
}

data "kubernetes_secret" "azure_devops_secret" {
  count = var.mock_enabled ? 1 : 0
  metadata {
    name      = kubernetes_service_account.azure_devops[0].default_secret_name
    namespace = kubernetes_namespace.namespace_system[0].metadata[0].name
  }
  binary_data = {
    "ca.crt" = ""
    "token"  = ""
  }
}

#tfsec:ignore:AZU023
resource "azurerm_key_vault_secret" "azure_devops_sa_token" {
  count        = var.mock_enabled ? 1 : 0
  depends_on   = [kubernetes_service_account.azure_devops]
  name         = "${local.aks_name}-azure-devops-sa-token"
  value        = data.kubernetes_secret.azure_devops_secret[0].binary_data["token"] # base64 value
  content_type = "text/plain"

  key_vault_id = data.azurerm_key_vault.kv.id
}

#tfsec:ignore:AZU023
resource "azurerm_key_vault_secret" "azure_devops_sa_cacrt" {
  count        = var.mock_enabled ? 1 : 0
  depends_on   = [kubernetes_service_account.azure_devops]
  name         = "${local.aks_name}-azure-devops-sa-cacrt"
  value        = data.kubernetes_secret.azure_devops_secret[0].binary_data["ca.crt"] # base64 value
  content_type = "text/plain"

  key_vault_id = data.azurerm_key_vault.kv.id
}

#-------------------------------------------------------------
#
# Role binding
#

resource "kubernetes_role_binding" "deployer_binding" {
  count = var.mock_enabled ? 1 : 0
  metadata {
    name      = "deployer-binding"
    namespace = kubernetes_namespace.namespace[0].metadata[0].name
  }
  role_ref {
    api_group = "rbac.authorization.k8s.io"
    kind      = "ClusterRole"
    name      = "cluster-deployer"
  }
  subject {
    kind      = "ServiceAccount"
    name      = "azure-devops"
    namespace = kubernetes_namespace.namespace_system[0].metadata[0].name
  }
}

resource "kubernetes_role_binding" "system_deployer_binding" {
  count = var.mock_enabled ? 1 : 0
  metadata {
    name      = "system-deployer-binding"
    namespace = kubernetes_namespace.namespace_system[0].metadata[0].name
  }
  role_ref {
    api_group = "rbac.authorization.k8s.io"
    kind      = "ClusterRole"
    name      = "system-cluster-deployer"
  }
  subject {
    kind      = "ServiceAccount"
    name      = "azure-devops"
    namespace = kubernetes_namespace.namespace_system[0].metadata[0].name
  }
}
