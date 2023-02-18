module "elastic_stack" {
  #source = "git::https://github.com/pagopa/azurerm.git//elastic_stack?ref=v4.2.0"
  source = "/Users/massimoscattarella/projects/pagopa/azurerm/elastic_stack"

  namespace = "elastic-system"

  nodeset_config = {
    balancer-nodes = {
      count = var.elastic_cluster_config.num_node_balancer
      roles = []
      storage = var.elastic_cluster_config.storage_size_balancer
      storageClassName = "${local.project}-elastic-aks-storage-hot"
    },
    master-nodes = {
      count = var.elastic_cluster_config.num_node_master
      roles = ["master"]
      storage = var.elastic_cluster_config.storage_size_master
      storageClassName = "${local.project}-elastic-aks-storage-hot"
    },
    data-hot-nodes = {
      count = var.elastic_cluster_config.num_node_hot
      roles = ["ingest","data_content","data_hot"]
      storage = var.elastic_cluster_config.storage_size_hot
      storageClassName = "${local.project}-elastic-aks-storage-hot"
    },
    data-warm-nodes = {
      count = var.elastic_cluster_config.num_node_warm
      roles = ["ingest","data_content", "data_warm"]
      storage = var.elastic_cluster_config.storage_size_warm
      storageClassName = "${local.project}-elastic-aks-storage-warm"
    },
    data-cold-nodes = {
      count = var.elastic_cluster_config.num_node_cold
      roles = ["ingest","data_content", "data_cold", "data_frozen", "ml", "transform", "remote_cluster_client"]
      storage = var.elastic_cluster_config.storage_size_cold
      storageClassName = "${local.project}-elastic-aks-storage-cold"
    }
  }

  kibana_external_domain = var.env_short == "p" ? "https://kibana.platform.pagopa.it/kibana" : "https://kibana.${var.env}.platform.pagopa.it/kibana"

  secret_name   = var.env_short == "p" ? "${var.location_short}${var.env}-kibana-internal-platform-pagopa-it" : "${var.location_short}${var.env}-kibana-internal-${var.env}-platform-pagopa-it"
  keyvault_name = module.key_vault.name

  kibana_internal_hostname = var.env_short == "p" ? "${var.location_short}${var.env}.kibana.internal.platform.pagopa.it" : "${var.location_short}${var.env}.kibana.internal.${var.env}.platform.pagopa.it"
}


