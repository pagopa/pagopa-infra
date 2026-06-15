resource "azurerm_resource_group" "redis_rg" {
  name     = "${local.project}-redis-rg"
  location = var.location

  tags = module.tag_config.tags
}

module "redis" {
  source = "./.terraform/modules/__v4__/IDH/redis"

  env = var.env
  idh_resource_tier = var.redis_idh_resource_tier
  product_name = local.prefix

  location = var.location
  name = "${local.project}-redis"
  resource_group_name = azurerm_resource_group.redis_rg.name
  alert_action_group_ids = concat([data.azurerm_monitor_action_group.email.id, data.azurerm_monitor_action_group.slack.id], var.alert_use_opsgenie ? [] : [])

  embedded_subnet = {
    enabled              = true
    vnet_name            = local.spoke_data_vnet_name
    vnet_rg_name         = local.spoke_data_vnet_resource_group_name
    private_dns_zone_ids = [data.azurerm_private_dns_zone.privatelink_redis_cache_windows_net.id]
  }

  # fixme configure the cidr list and service name allowed on this redis
  embedded_nsg_configuration    = {
    source_address_prefixes      = ["*"]
    source_address_prefixes_name = local.domain
  }

  patch_schedules = [
    {
      day_of_week    = "Sunday"
      start_hour_utc = 23
    },
    {
      day_of_week    = "Monday"
      start_hour_utc = 23
    },
    {
      day_of_week    = "Tuesday"
      start_hour_utc = 23
    },
    {
      day_of_week    = "Wednesday"
      start_hour_utc = 23
    },
    {
      day_of_week    = "Thursday"
      start_hour_utc = 23
    },
    {
      day_of_week    = "Friday"
      start_hour_utc = 23
    },
    {
      day_of_week    = "Saturday"
      start_hour_utc = 23
    }
  ]

  tags = module.tag_config.tags
}

resource "azurerm_key_vault_secret" "redis_qa_access_key" {
  name         = "redis-${local.domain}-access-key"
  value        = module.redis.primary_access_key
  key_vault_id = data.azurerm_key_vault.domain_kv.id
}

resource "azurerm_key_vault_secret" "redis_qa_hostname" {
  name         = "redis-${local.domain}-hostname"
  value        = module.redis.hostname
  key_vault_id = data.azurerm_key_vault.domain_kv.id
}

resource "azurerm_key_vault_secret" "redis_qa_connection_string" {
  name         = "redis-${local.domain}-hostname"
  value        = module.redis.primary_connection_string
  key_vault_id = data.azurerm_key_vault.domain_kv.id
}
