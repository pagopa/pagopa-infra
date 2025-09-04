locals {
  product = "${var.prefix}-${var.env_short}"
  domain  = "dbsecurity"
  project = "${local.product}-${var.location_short}-${local.domain}"

  vnet_italy_name                = "${local.product}-itn-vnet"
  vnet_italy_resource_group_name = "${local.product}-itn-vnet-rg"
  vnet_core_resource_group_name  = "${local.product}-vnet-rg"
  vnet_core_name                 = "${local.product}-vnet"

  key_vault_core_name    = "${local.product}-itn-core-kv"
  key_vault_core_rg_name = "${local.product}-itn-core-sec-rg"


  log_analytics_italy_workspace_name                = "${local.product}-${var.location_short}-core-law"
  log_analytics_italy_workspace_resource_group_name = "${local.product}-${var.location_short}-core-monitor-rg"
}
