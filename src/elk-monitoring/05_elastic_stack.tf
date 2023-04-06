module "elastic_stack" {
  depends_on = [
    azurerm_kubernetes_cluster_node_pool.elastic
  ]

  source = "git::https://github.com/pagopa/azurerm.git//elastic_stack?ref=v4.14.0"

  namespace      = local.elk_namespace
  nodeset_config = var.nodeset_config

  dedicated_log_instance_name = ["nodo", "nodoreplica", "nodocron", "nodocronreplica", "pagopawebbo", "pagopawfespwfesp", "pagopafdr"]


  eck_license = file("${path.module}/env/eck_license/pagopa-spa-4a1285e5-9c2c-4f9f-948a-9600095edc2f-orchestration.json")

  env_short = var.env_short
  env       = var.env

  kibana_external_domain = var.env_short == "p" ? "https://kibana.platform.pagopa.it/kibana" : "https://kibana.${var.env}.platform.pagopa.it/kibana"

  secret_name   = var.env_short == "p" ? "${var.location_short}${var.env}-kibana-internal-platform-pagopa-it" : "${var.location_short}${var.env}-kibana-internal-${var.env}-platform-pagopa-it"
  keyvault_name = module.key_vault.name

  kibana_internal_hostname = var.env_short == "p" ? "${var.location_short}${var.env}.kibana.internal.platform.pagopa.it" : "${var.location_short}${var.env}.kibana.internal.${var.env}.platform.pagopa.it"
}

data "kubernetes_secret" "get_elastic_credential" {
  depends_on = [
    module.elastic_stack
  ]

  metadata {
    name      = "quickstart-es-elastic-user"
    namespace = local.elk_namespace
  }
}

locals {
  kibana_url  = var.env_short == "p" ? "https://elastic:${data.kubernetes_secret.get_elastic_credential.data.elastic}@kibana.platform.pagopa.it/kibana" : "https://elastic:${data.kubernetes_secret.get_elastic_credential.data.elastic}@kibana.${var.env}.platform.pagopa.it/kibana"
  elastic_url = var.env_short == "p" ? "https://elastic:${data.kubernetes_secret.get_elastic_credential.data.elastic}@kibana.platform.pagopa.it/elastic" : "https://elastic:${data.kubernetes_secret.get_elastic_credential.data.elastic}@kibana.${var.env}.platform.pagopa.it/elastic"
}

## opentelemetry
resource "helm_release" "opentelemetry_operator_helm" {
  depends_on = [
    module.elastic_stack
  ]

  # provisioner "local-exec" {
  #   when        = destroy
  #   command     = "kubectl delete crd opentelemetrycollectors.opentelemetry.io"
  #   interpreter = ["/bin/bash", "-c"]
  # }
  # provisioner "local-exec" {
  #   when        = destroy
  #   command     = "kubectl delete crd instrumentations.opentelemetry.io"
  #   interpreter = ["/bin/bash", "-c"]
  # }

  name       = "opentelemetry-operator"
  repository = "https://open-telemetry.github.io/opentelemetry-helm-charts"
  chart      = "opentelemetry-operator"
  version    = var.opentelemetry_operator_helm.chart_version
  namespace  = local.elk_namespace

  values = [
    "${file("${var.opentelemetry_operator_helm.values_file}")}"
  ]

}

data "kubernetes_secret" "get_apm_token" {
  depends_on = [
    helm_release.opentelemetry_operator_helm
  ]

  metadata {
    name      = "quickstart-apm-token"
    namespace = local.elk_namespace
  }
}
resource "kubectl_manifest" "otel_collector" {
  depends_on = [
    data.kubernetes_secret.get_apm_token
  ]
  yaml_body = templatefile("${path.module}/env/opentelemetry_operator_helm/otel.yaml", {
    namespace = local.elk_namespace
    apm_token = data.kubernetes_secret.get_apm_token.data.secret-token
  })

  force_conflicts = true
  wait            = true
}