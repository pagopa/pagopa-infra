resource "kubernetes_namespace" "system_domain_namespace" {
  metadata {
    name = "${var.domain}-system"
  }
}

resource "kubernetes_service_account" "azure_devops" {
  metadata {
    name      = "azure-devops"
    namespace = local.system_domain_namespace
  }
  automount_service_account_token = false
}

#-------------------------------------------------------------

resource "kubernetes_role_binding" "deployer_binding" {
  metadata {
    name      = "deployer-binding"
    namespace = local.domain_namespace
  }
  role_ref {
    api_group = "rbac.authorization.k8s.io"
    kind      = "ClusterRole"
    name      = "cluster-deployer"
  }
  subject {
    kind      = "ServiceAccount"
    name      = "azure-devops"
    namespace = local.system_domain_namespace
  }
}

resource "kubernetes_role_binding" "system_deployer_binding" {
  metadata {
    name      = "system-deployer-binding"
    namespace = local.system_domain_namespace
  }
  role_ref {
    api_group = "rbac.authorization.k8s.io"
    kind      = "ClusterRole"
    name      = "system-cluster-deployer"
  }
  subject {
    kind      = "ServiceAccount"
    name      = "azure-devops"
    namespace = local.system_domain_namespace
  }
}

#
# Secrets service account on KV
#
data "kubernetes_secret" "azure_devops_secret" {
  metadata {
    name      = kubernetes_service_account.azure_devops.default_secret_name
    namespace = local.system_domain_namespace
  }
  binary_data = {
    "ca.crt" = ""
    "token"  = ""
  }
}

#tfsec:ignore:AZU023
resource "azurerm_key_vault_secret" "azure_devops_sa_token" {
  depends_on   = [kubernetes_service_account.azure_devops]
  name         = "${local.aks_name}-azure-devops-sa-token"
  value        = data.kubernetes_secret.azure_devops_secret.binary_data["token"] # base64 value
  content_type = "text/plain"

  key_vault_id = data.azurerm_key_vault.kv.id
}

#tfsec:ignore:AZU023
resource "azurerm_key_vault_secret" "azure_devops_sa_cacrt" {
  depends_on   = [kubernetes_service_account.azure_devops]
  name         = "${local.aks_name}-azure-devops-sa-cacrt"
  value        = data.kubernetes_secret.azure_devops_secret.binary_data["ca.crt"] # base64 value
  content_type = "text/plain"

  key_vault_id = data.azurerm_key_vault.kv.id
}


