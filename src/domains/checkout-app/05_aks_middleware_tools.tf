module "tls_checker" {
  source = "./.terraform/modules/__v3__/tls_checker"

  https_endpoint                                            = local.checkout_hostname
  alert_name                                                = local.checkout_hostname
  alert_enabled                                             = true
  helm_chart_present                                        = true
  helm_chart_version                                        = var.tls_cert_check_helm.chart_version
  namespace                                                 = kubernetes_namespace.namespace.metadata[0].name
  helm_chart_image_name                                     = var.tls_cert_check_helm.image_name
  helm_chart_image_tag                                      = var.tls_cert_check_helm.image_tag
  location_string                                           = var.location_string
  kv_secret_name_for_application_insights_connection_string = "ai-${var.env_short}-connection-string"
  application_insights_resource_group                       = data.azurerm_resource_group.monitor_rg.name
  application_insights_id                                   = data.azurerm_application_insights.application_insights.id
  application_insights_action_group_ids                     = [data.azurerm_monitor_action_group.slack.id, data.azurerm_monitor_action_group.email.id]
  keyvault_name                                             = data.azurerm_key_vault.key_vault_checkout.name
  keyvault_tenant_id                                        = data.azurerm_client_config.current.tenant_id

  workload_identity_enabled              = true
  workload_identity_service_account_name = module.workload_identity.workload_identity_service_account_name
  workload_identity_client_id            = module.workload_identity.workload_identity_client_id
  depends_on                             = [module.workload_identity]
}

resource "helm_release" "cert_mounter" {
  name         = "cert-mounter-blueprint"
  repository   = "https://pagopa.github.io/aks-helm-cert-mounter-blueprint"
  chart        = "cert-mounter-blueprint"
  version      = "1.0.4"
  namespace    = var.domain
  timeout      = 120
  force_update = true

  values = [
    templatefile("${path.root}/helm/cert-mounter.yaml.tpl", {
      NAMESPACE        = var.domain,
      DOMAIN           = var.domain
      CERTIFICATE_NAME = replace(local.checkout_hostname, ".", "-"),
      ENV_SHORT        = var.env_short,
    })
  ]
}

resource "helm_release" "reloader" {
  name       = "reloader-checkout"
  repository = "https://stakater.github.io/stakater-charts"
  chart      = "reloader"
  version    = "v1.0.48"
  namespace  = kubernetes_namespace.namespace.metadata[0].name

  set {
    name  = "reloader.watchGlobally"
    value = "false"
  }
}
