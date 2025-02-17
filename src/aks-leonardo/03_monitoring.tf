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
module "elastic_agent" {

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

