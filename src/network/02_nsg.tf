locals {
  nsg_regions_to_create = { for region in var.nsg_regions : region => local.nsg_network_regions[region] if var.enabled_features.nsg }
}

resource "azurerm_resource_group" "nsg_rg" {
  for_each = local.nsg_regions_to_create
  location = each.key
  name     = "${local.project}-${each.value.short_name}-nsg-rg"
}

module "network_watcher_storage_account" {
  source = "./.terraform/modules/__V4__/IDH/storage_account"
  for_each = local.nsg_regions_to_create
  env = var.env
  idh_resource_tier = "basic"
  product_name = local.prefix

  domain = local.domain
  name                            = replace("${local.product}-${each.value.short_name}-nwst", "-", "")
  resource_group_name             = azurerm_resource_group.nsg_rg[each.key].name
  location                        = azurerm_resource_group.nsg_rg[each.key].location

  tags = module.tag_config.tags
}


module "network_security_group" {
  source = "./.terraform/modules/__V4__/network_security_group"
  for_each = local.nsg_regions_to_create
  prefix              = "${local.project}"
  resource_group_name = azurerm_resource_group.nsg_rg[each.key].name
  location           = azurerm_resource_group.nsg_rg[each.key].location

  vnets = each.value.vnets

  custom_security_group = each.value.nsg

  flow_logs = {
    network_watcher_name       = "NetworkWatcher_${each.key}"
    network_watcher_rg         = local.network_watcher_rg_name
    storage_account_id         = module.network_watcher_storage_account[each.key].id
    traffic_analytics_law_name = each.value.log_analytics_workspace_name
    traffic_analytics_law_rg   = each.value.log_analytics_workspace_rg
    retention_days = local.flow_log_retention_days

  }

  tags = module.tag_config.tags
}


