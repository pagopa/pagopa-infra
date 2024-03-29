locals {
  snapshot_secret_name            = "snapshot-secret"
  deafult_snapshot_container_name = "snapshotblob"
}

resource "azurerm_resource_group" "elk_rg" {
  name     = "${local.project}-rg"
  location = var.location

  tags = var.tags
}

resource "azurerm_storage_account" "elk_snapshot_sa" {
  name                            = replace(format("%s-sa", local.project), "-", "")
  resource_group_name             = azurerm_resource_group.elk_rg.name
  location                        = azurerm_resource_group.elk_rg.location
  account_tier                    = "Standard"
  account_replication_type        = var.snapshot_storage_replication_type
  allow_nested_items_to_be_public = false

  blob_properties {
    change_feed_enabled = var.elk_snapshot_sa.backup_enabled
    dynamic "container_delete_retention_policy" {
      for_each = var.elk_snapshot_sa.backup_enabled ? [1] : []
      content {
        days = var.elk_snapshot_sa.blob_delete_retention_days
      }

    }
    #    change_feed_retention_in_days = var.elk_snapshot_sa.backup_enabled ? var.elk_snapshot_sa.blob_delete_retention_days : null
    #    restore_policy {
    #      days = var.elk_snapshot_sa.blob_delete_retention_days
    #    }
    versioning_enabled = var.elk_snapshot_sa.backup_enabled
    dynamic "delete_retention_policy" {
      for_each = var.elk_snapshot_sa.backup_enabled ? [1] : []
      content {
        days = var.elk_snapshot_sa.blob_delete_retention_days
      }

    }
  }

  #  blob_change_feed_enabled = var.elk_snapshot_sa.backup_enabled
  #  blob_change_feed_retention_in_days = var.elk_snapshot_sa.backup_enabled ? var.elk_snapshot_sa.blob_delete_retention_days : null
  #  blob_container_delete_retention_days =  var.elk_snapshot_sa.blob_delete_retention_days
  #  blob_storage_policy ={
  #    enable_immutability_policy = false
  #    blob_restore_policy_days = var.elk_snapshot_sa.blob_delete_retention_days
  #  }
  #  blob_delete_retention_days = var.elk_snapshot_sa.blob_delete_retention_days
}

resource "azurerm_storage_container" "snapshot_container" {
  name                  = local.deafult_snapshot_container_name
  storage_account_name  = azurerm_storage_account.elk_snapshot_sa.name
  container_access_type = "private"
}

data "azurerm_storage_account" "snapshot_account" {
  depends_on = [
    azurerm_storage_container.snapshot_container
  ]
  name                = azurerm_storage_account.elk_snapshot_sa.name
  resource_group_name = azurerm_resource_group.elk_rg.name
}

resource "kubernetes_secret" "snapshot_secret" {
  metadata {
    name      = local.snapshot_secret_name
    namespace = local.elk_namespace
  }
  data = {
    "azure.client.default.account" = replace(format("%s-sa", local.project), "-", "")
    "azure.client.default.key"     = data.azurerm_storage_account.snapshot_account.primary_access_key
  }

}

module "elastic_stack" {
  depends_on = [
    azurerm_kubernetes_cluster_node_pool.elastic,
    kubernetes_secret.snapshot_secret
  ]

  source = "git::https://github.com/pagopa/terraform-azurerm-v3.git//elastic_stack?ref=v7.72.2"

  eck_version = "2.9"

  namespace      = local.elk_namespace
  nodeset_config = var.nodeset_config

  dedicated_log_instance_name = [
    /* nodo */ "nodo", "nodoreplica", "nodocron", "nodocronreplica", "pagopawebbo", "pagopawfespwfesp", "pagopafdr", "pagopafdrnodo, wispsoapconverter",
    /* afm */ "pagopaafmcalculator-microservice-chart", "pagopaafmmarketplacebe-microservice-chart", "pagopaafmutils-microservice-chart",
    /* bizevents */ "pagopabizeventsdatastore-microservice-chart", "pagopabizeventsservice-microservice-chart", "pagopanegativebizeventsdatastore-microservice-chart",
    /* apiconfig */ "pagopaapiconfig-postgresql", "pagopaapiconfig-oracle", "apiconfig-selfcare-integration-microservice-chart", "cache-oracle", "cache-postgresql", "cache-replica-oracle", "cache-replica-postgresql",
    /* ecommerce */ "pagopaecommerceeventdispatcherservice-microservice-chart", "pagopaecommercepaymentmethodsservice-microservice-chart", "pagopaecommercepaymentrequestsservice-microservice-chart", "pagopaecommercetransactionsservice-microservice-chart", "pagopaecommercetxschedulerservice-microservice-chart", "pagopanotificationsservice-microservice-chart",
    /* selfcare */ "pagopaselfcaremsbackofficebackend-microservice-chart", "backoffice-external",
    /* gps */ "gpd-core-microservice-chart", "pagopagpdpayments-microservice-chart", "pagopareportingorgsenrollment-microservice-chart", "pagopaspontaneouspayments-microservice-chart", "gpd-payments-pull"
  ]

  eck_license = file("${path.module}/env/eck_license/pagopa-spa-4a1285e5-9c2c-4f9f-948a-9600095edc2f-orchestration.json")

  env_short = var.env_short
  env       = var.env

  kibana_external_domain = var.env_short == "p" ? "https://kibana.platform.pagopa.it/kibana" : "https://kibana.${var.env}.platform.pagopa.it/kibana"

  secret_name   = var.env_short == "p" ? "${var.location_short}${var.env}-kibana-internal-platform-pagopa-it" : "${var.location_short}${var.env}-kibana-internal-${var.env}-platform-pagopa-it"
  keyvault_name = module.key_vault.name

  kibana_internal_hostname = var.env_short == "p" ? "${var.location_short}${var.env}.kibana.internal.platform.pagopa.it" : "${var.location_short}${var.env}.kibana.internal.${var.env}.platform.pagopa.it"

  snapshot_secret_name = local.snapshot_secret_name
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

# orignal
# locals {
#   kibana_url  = var.env_short == "p" ? "https://elastic:${data.kubernetes_secret.get_elastic_credential.data.elastic}@kibana.platform.pagopa.it/kibana" : "https://elastic:${data.kubernetes_secret.get_elastic_credential.data.elastic}@kibana.${var.env}.platform.pagopa.it/kibana"
#   elastic_url = var.env_short == "p" ? "https://elastic:${data.kubernetes_secret.get_elastic_credential.data.elastic}@kibana.platform.pagopa.it/elastic" : "https://elastic:${data.kubernetes_secret.get_elastic_credential.data.elastic}@kibana.${var.env}.platform.pagopa.it/elastic"
# }

# workaround
locals {
  kibana_url  = var.env_short == "d" ? "https://elastic:${data.kubernetes_secret.get_elastic_credential.data.elastic}@kibana.${var.env}.platform.pagopa.it/kibana" : "https://elastic:${data.kubernetes_secret.get_elastic_credential.data.elastic}@${local.kibana_hostname}/kibana"
  elastic_url = var.env_short == "d" ? "https://elastic:${data.kubernetes_secret.get_elastic_credential.data.elastic}@kibana.${var.env}.platform.pagopa.it/elastic" : "https://elastic:${data.kubernetes_secret.get_elastic_credential.data.elastic}@${local.kibana_hostname}/elastic"

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
