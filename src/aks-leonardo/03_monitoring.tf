resource "kubernetes_namespace" "monitoring" {
  metadata {
    name = "monitoring"
  }
}

module "aks_prometheus_install" {
  source = "git::https://github.com/pagopa/terraform-azurerm-v3.git//kubernetes_prometheus_install?ref=v8.17.1"

  prometheus_namespace = kubernetes_namespace.monitoring.metadata[0].name
  storage_class_name   = "default-zrs"
}

module "elastic_agent" {

  source = "git::https://github.com/pagopa/terraform-azurerm-v3.git//elastic_agent?ref=introducing-agent-module"

  es_host = var.env == "p" ? "https://weu${var.env}.kibana.internal.platform.pagopa.it:443/elastic" : "https://weu${var.env}.kibana.internal.${var.env}.platform.pagopa.it:443/elastic"

  eck_version = "2.9"

  namespace = kubernetes_namespace.monitoring.id

  dedicated_log_instance_name = [
    /* printit */ "print-payment-notice-service", "print-payment-notice-generator", "print-payment-notice-functions"
  ]

}

// TODO mettere nel kv il secret quickstart-es-elastic-user tramite sops

