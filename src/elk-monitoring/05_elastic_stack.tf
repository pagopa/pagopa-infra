module "elastic_stack" {
  source = "git::https://github.com/pagopa/azurerm.git//elastic_stack?ref=v4.2.0"

  balancer_node_number   = var.elastic_cluster_config.num_node_balancer
  master_node_number     = var.elastic_cluster_config.num_node_master
  hot_node_number        = var.elastic_cluster_config.num_node_hot
  warm_node_number       = var.elastic_cluster_config.num_node_warm
  cold_node_number       = var.elastic_cluster_config.num_node_cold
  balancer_storage_size  = var.elastic_cluster_config.storage_size_balancer
  master_storage_size    = var.elastic_cluster_config.storage_size_master
  hot_storage_size       = var.elastic_cluster_config.storage_size_hot
  warm_storage_size      = var.elastic_cluster_config.storage_size_warm
  cold_storage_size      = var.elastic_cluster_config.storage_size_cold
  balancer_storage_class = "${local.project}-elastic-aks-storage-hot"
  master_storage_class   = "${local.project}-elastic-aks-storage-hot"
  hot_storage_class      = "${local.project}-elastic-aks-storage-hot"
  warm_storage_class     = "${local.project}-elastic-aks-storage-warm"
  cold_storage_class     = "${local.project}-elastic-aks-storage-cold"

  kibana_external_domain = "https://kibana.dev.platform.pagopa.it/kibana" ####TEMP "${local.apim_hostname}/kibana"

  secret_name   = "weu${var.env}-kibana-internal-${var.env}-platform-pagopa-it"
  keyvault_name = module.key_vault.name

  kibana_internal_hostname = local.kibana_hostname
}


