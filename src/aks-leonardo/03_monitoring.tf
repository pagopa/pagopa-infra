resource "kubernetes_namespace" "monitoring" {
  metadata {
    name = "monitoring"
  }
}

#
# Prometheus
#
module "aks_prometheus_install" {
  source = "git::https://github.com/pagopa/terraform-azurerm-v3.git//kubernetes_prometheus_install?ref=v8.78.1"

  prometheus_namespace = kubernetes_namespace.monitoring.metadata[0].name
  storage_class_name   = "default-zrs"
}

#
# Elastic
#

moved {
  from = module.elastic_agent
  to   = module.elastic_agent[0]
}

module "elastic_agent" {
  count  = var.enable_elastic_agent ? 1 : 0
  source = "git::https://github.com/pagopa/terraform-azurerm-v3.git//elastic_agent?ref=v8.50.0"

  es_host = var.env_short == "p" ? "https://weu${var.env}.kibana.internal.platform.pagopa.it:443/elastic" : "https://weu${var.env}.kibana.internal.${var.env}.platform.pagopa.it:443/elastic"

  eck_version = "2.9"

  namespace = kubernetes_namespace.monitoring.id

  dedicated_log_instance_name = [
    /* printit */ "print-payment-notice-service", "print-payment-notice-generator", "print-payment-notice-functions"
  ]

}

#
# Kubernetes Event Exporter
#
module "kubernetes_event_exporter" {
  count     = var.env_short != "p" ? 0 : 1
  source    = "git::https://github.com/pagopa/terraform-azurerm-v3.git//kubernetes_event_exporter?ref=v8.76.0"
  namespace = "monitoring"

  custom_config = "env/itn-prod/exporter/kubernetes-event-exporter-config.yml.tftpl"
  custom_variables = {
    enable_slack           = false
    enable_opsgenie        = true
    opsgenie_receiver_name = "opsgenie"
    opsgenie_api_key       = data.azurerm_key_vault_secret.opsgenie_kubexporter_api_key.0.value
  }
}

data "azurerm_key_vault_secret" "opsgenie_kubexporter_api_key" {
  count        = var.env_short != "p" ? 0 : 1
  key_vault_id = data.azurerm_key_vault.kv_italy.id
  name         = "opsgenie-infra-kubexporter-webhook-token"
}

// TODO mettere nel kv il secret quickstart-es-elastic-user tramite sops


## PROMETHUES MANAGED ON AKS
# Refer: Resource created on next-core 02_monitor.tf
data "azurerm_monitor_workspace" "workspace" {
  count               = var.env != "prod" ? 1 : 0
  name                = "pagopa-${var.env_short}-${var.location}-monitor-workspace"
  resource_group_name = "pagopa-${var.env_short}-monitor-rg"
}

module "prometheus_managed_addon" {
  count                  = var.env != "prod" ? 1 : 0
  source                 = "git::https://github.com/pagopa/terraform-azurerm-v3.git//kubernetes_prometheus_managed?ref=v8.84.0"
  cluster_name           = module.aks_leonardo.name
  resource_group_name    = module.aks_leonardo.aks_resource_group_name
  location               = var.location
  custom_gf_location     = "westeurope"
  location_short         = var.location_short
  monitor_workspace_name = data.azurerm_monitor_workspace.workspace.0.name
  monitor_workspace_rg   = data.azurerm_monitor_workspace.workspace.0.resource_group_name
  grafana_name           = "pagopa-${var.env_short}-weu-grafana"    # Integrate with weu grafana
  grafana_resource_group = "pagopa-${var.env_short}-weu-grafana-rg" # Integrate with weu grafana

  # takes a list and replaces any elements that are lists with a
  # flattened sequence of the list contents.
  # In this case, we enable OpsGenie only on prod env
  action_groups_id = flatten([
    [
      data.azurerm_monitor_action_group.slack.id,
      data.azurerm_monitor_action_group.email.id
    ],
    (var.env == "prod" ? [
      data.azurerm_monitor_action_group.opsgenie.0.id
    ] : [])
  ])

  tags = var.tags
}
