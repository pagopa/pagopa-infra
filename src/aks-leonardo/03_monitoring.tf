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

  source = "git::https://github.com/pagopa/terraform-azurerm-v3.git//elastic_agent?ref=e46941fb2999b7902cd61582e27cc059e7a579a3"

  es_host = "https://weu${env}.kibana.internal.${env}.platform.pagopa.it/elastic"

  eck_version = "2.9"

  namespace      = kubernetes_namespace.monitoring.id

  dedicated_log_instance_name = [
    /* printit */ "print-payment-notice-service-microservice-chart", "print-payment-notice-generator-microservice-chart", "print-payment-notice-functions-microservice-chart"
  ]

}
