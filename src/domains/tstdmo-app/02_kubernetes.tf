resource "kubernetes_namespace" "namespace" {
  metadata {
    name = local.domain
  }
}

module "workload_identity" {
  source = "./.terraform/modules/__v4__/kubernetes_workload_identity_configuration"

  workload_identity_name_prefix         = local.domain
  workload_identity_resource_group_name = data.azurerm_kubernetes_cluster.aks.resource_group_name
  aks_name                              = data.azurerm_kubernetes_cluster.aks.name
  aks_resource_group_name               = data.azurerm_kubernetes_cluster.aks.resource_group_name
  namespace                             = local.domain

  key_vault_id                      = data.azurerm_key_vault.key_vault.id
  key_vault_certificate_permissions = ["Get"]
  key_vault_key_permissions         = ["Get"]
  key_vault_secret_permissions      = ["Get"]
}

resource "kubernetes_pod_disruption_budget_v1" "tstdmo_pdb" {

  for_each = var.pod_disruption_budgets

  metadata {
    namespace = kubernetes_namespace.namespace.metadata[0].name
    name      = each.key
  }
  spec {
    min_available = each.value.minAvailable
    selector {
      match_labels = each.value.matchLabels
    }
  }
}


resource "kubernetes_namespace" "namespace_system" {
  metadata {
    name = "${local.domain}-system"
  }
}

module "kubernetes_service_account" {
  source    = "./.terraform/modules/__v4__/kubernetes_service_account"
  name      = "azure-devops"
  namespace = "${local.domain}-system"
}

#tfsec:ignore:AZU023
resource "azurerm_key_vault_secret" "azure_devops_sa_token" {
  depends_on   = [module.kubernetes_service_account]
  name         = "${local.aks_name}-azure-devops-sa-token"
  value        = module.kubernetes_service_account.sa_token # base64 value
  content_type = "text/plain"

  key_vault_id = data.azurerm_key_vault.key_vault.id
}

#tfsec:ignore:AZU023
resource "azurerm_key_vault_secret" "azure_devops_sa_cacrt" {
  depends_on   = [module.kubernetes_service_account]
  name         = "${local.aks_name}-azure-devops-sa-cacrt"
  value        = module.kubernetes_service_account.sa_ca_cert # base64 value
  content_type = "text/plain"

  key_vault_id = data.azurerm_key_vault.key_vault.id
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

module "tls_checker" {
  source = "./.terraform/modules/__v4__/tls_checker"

  https_endpoint                                            = local.domain_hostname
  alert_name                                                = local.domain_hostname
  alert_enabled                                             = true
  helm_chart_present                                        = true
  namespace                                                 = kubernetes_namespace.namespace.metadata[0].name
  location_string                                           = var.location_string
  kv_secret_name_for_application_insights_connection_string = "app-insight-connection-string"
  application_insights_resource_group                       = data.azurerm_resource_group.monitor_rg.name
  application_insights_id                                   = data.azurerm_application_insights.application_insights.id
  application_insights_action_group_ids                     = [data.azurerm_monitor_action_group.slack.id, data.azurerm_monitor_action_group.email.id]
  keyvault_name                                             = data.azurerm_key_vault.key_vault.name
  keyvault_tenant_id                                        = data.azurerm_client_config.current.tenant_id

  workload_identity_enabled              = true
  workload_identity_service_account_name = module.workload_identity.workload_identity_service_account_name
  workload_identity_client_id            = module.workload_identity.workload_identity_client_id

  depends_on = [module.workload_identity]
}

module "cert_mounter" {
  source = "./.terraform/modules/__v4__/cert_mounter"

  namespace        = local.domain
  certificate_name = replace(local.domain_hostname, ".", "-")
  kv_name          = data.azurerm_key_vault.key_vault.name
  tenant_id        = data.azurerm_subscription.current.tenant_id

  workload_identity_service_account_name = module.workload_identity.workload_identity_service_account_name
  workload_identity_client_id            = module.workload_identity.workload_identity_client_id

  depends_on = [module.workload_identity]
}

resource "helm_release" "reloader" {
  name       = "reloader"
  repository = "https://stakater.github.io/stakater-charts"
  chart      = "reloader"
  version    = "v1.0.69"
  namespace  = kubernetes_namespace.namespace.metadata[0].name

  set {
    name  = "reloader.watchGlobally"
    value = "false"
  }
}


