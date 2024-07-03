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

  source = "git::https://github.com/pagopa/terraform-azurerm-v3.git//elastic_agent?ref=3ab498bdc16ee65c8d1d221a1fd64784ff6548c7"

  eck_version = "2.9"

  namespace      = kubernetes_namespace.monitoring.id

  dedicated_log_instance_name = [
    /* printit */ "print-payment-notice-service-microservice-chart", "print-payment-notice-generator-microservice-chart", "print-payment-notice-functions-microservice-chart"
  ]

}
