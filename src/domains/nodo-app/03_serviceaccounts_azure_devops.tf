resource "kubernetes_namespace" "namespace_system" {
  metadata {
    name = "${var.domain}-system"
  }
}

resource "kubernetes_service_account" "azure_devops" {
  metadata {
    name      = "azure-devops"
    namespace = kubernetes_namespace.namespace_system.metadata[0].name
  }
  automount_service_account_token = false
}

data "kubernetes_secret" "azure_devops_secret" {
  metadata {
    name      = kubernetes_service_account.azure_devops.default_secret_name
    namespace = kubernetes_namespace.namespace_system.metadata[0].name
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

#--------------------------------------------------------------------------------------------------

resource "kubernetes_role_binding" "deployer_binding" {
  metadata {
    name      = "deployer-binding"
    namespace = kubernetes_namespace.namespace.metadata[0].name
  }
  role_ref {
    api_group = "rbac.authorization.k8s.io"
    kind      = "ClusterRole"
    name      = "cluster-deployer"
  }
  subject {
    kind      = "ServiceAccount"
    name      = "azure-devops"
    namespace = kubernetes_namespace.namespace_system.metadata[0].name
  }
}
resource "kubernetes_role_binding" "deployer_binding_2" {
  metadata {
    name      = "deployer-binding-2"
    namespace = "nodo-cron" # kubernetes_namespace.namespace.metadata[0].name
  }
  role_ref {
    api_group = "rbac.authorization.k8s.io"
    kind      = "ClusterRole"
    name      = "cluster-deployer"
  }
  subject {
    kind      = "ServiceAccount"
    name      = "azure-devops"
    namespace = kubernetes_namespace.namespace_system.metadata[0].name
  }
}

resource "kubernetes_role_binding" "system_deployer_binding" {
  metadata {
    name      = "system-deployer-binding"
    namespace = kubernetes_namespace.namespace_system.metadata[0].name
  }
  role_ref {
    api_group = "rbac.authorization.k8s.io"
    kind      = "ClusterRole"
    name      = "system-cluster-deployer"
  }
  subject {
    kind      = "ServiceAccount"
    name      = "azure-devops"
    namespace = kubernetes_namespace.namespace_system.metadata[0].name
  }
}
resource "kubernetes_role_binding" "system_deployer_binding_2" {
  metadata {
    name      = "system-deployer-binding-2"
    namespace = "nodo-cron-system" # kubernetes_namespace.namespace_system.metadata[0].name
  }
  role_ref {
    api_group = "rbac.authorization.k8s.io"
    kind      = "ClusterRole"
    name      = "system-cluster-deployer"
  }
  subject {
    kind      = "ServiceAccount"
    name      = "azure-devops"
    namespace = kubernetes_namespace.namespace_system.metadata[0].name
  }
}

resource "kubernetes_role_binding" "kube_system_reader_binding" {
  metadata {
    name      = "kube-system-reader-${var.domain}"
    namespace = "kube-system"
  }
  role_ref {
    api_group = "rbac.authorization.k8s.io"
    kind      = "ClusterRole"
    name      = "kube-system-reader"
  }
  subject {
    kind      = "ServiceAccount"
    name      = "azure-devops"
    namespace = kubernetes_namespace.namespace_system.metadata[0].name
  }
}


