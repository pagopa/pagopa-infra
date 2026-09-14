resource "azurerm_resource_group" "redis_rg" {
  name     = "${local.project}-redis-rg"
  location = var.location

  tags = module.tag_config.tags
}

module "managed_redis" {
  source = "./.terraform/modules/__v4__/IDH/managed_redis"

  # General
  product_name        = local.prefix
  env                 = var.env
  location            = var.location
  resource_group_name = azurerm_resource_group.redis_rg.name
  tags                = module.tag_config.tags

  # IDH Resources
  idh_resource_tier = "balanced_0_5gb_no_cluster"

  # Redis Settings
  name = local.project

  # Network

  embedded_subnet = {
    enabled              = true
    vnet_name            = local.spoke_data_vnet_name
    vnet_rg_name         = local.spoke_data_vnet_resource_group_name
    private_dns_zone_ids = [data.azurerm_private_dns_zone.privatelink_redis_azure_net.id]
  }

  alert_action_group_ids = concat([data.azurerm_monitor_action_group.email.id, data.azurerm_monitor_action_group.slack.id], var.alert_use_opsgenie ? [] : [])
}

resource "azurerm_key_vault_secret" "qa_centralhub_redis_url" {
  name         = "qa-centralhub-redis-url"
  value        = module.managed_redis.primary_connection_url
  key_vault_id = data.azurerm_key_vault.domain_kv.id
}