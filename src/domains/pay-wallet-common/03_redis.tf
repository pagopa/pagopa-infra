resource "azurerm_resource_group" "redis_pay_wallet_rg" {
  name     = "${local.project}-redis-rg"
  location = var.location

  tags = module.tag_config.tags
}

module "pagopa_pay_wallet_redis" {
  count = var.is_feature_enabled.redis ? 1 : 0

  source = "git::https://github.com/pagopa/terraform-azurerm-v3.git//redis_cache?ref=v8.20.1"

  name                          = "${local.project}-redis"
  resource_group_name           = azurerm_resource_group.redis_pay_wallet_rg.name
  location                      = azurerm_resource_group.redis_pay_wallet_rg.location
  capacity                      = var.redis_pay_wallet_params.capacity
  enable_non_ssl_port           = false
  family                        = var.redis_pay_wallet_params.family
  sku_name                      = var.redis_pay_wallet_params.sku_name
  enable_authentication         = true
  redis_version                 = var.redis_pay_wallet_params.version
  public_network_access_enabled = var.env_short == "d"

  zones = var.redis_pay_wallet_params.zones

  private_endpoint = {
    enabled              = var.env_short != "d"
    virtual_network_id   = data.azurerm_virtual_network.vnet_italy.id
    subnet_id            = module.redis_pagopa_pay_wallet_snet.id
    private_dns_zone_ids = [data.azurerm_private_dns_zone.privatelink_documents_azure_com.id]
  }

  // when azure can apply patch?
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
  ]

  tags = module.tag_config.tags
}

# -----------------------------------------------
# Alerts
# -----------------------------------------------

resource "azurerm_monitor_metric_alert" "redis_cache_used_memory_exceeded" {
  count = var.is_feature_enabled.redis && var.env_short == "p" ? 1 : 0


  name                = "[${var.domain != null ? "${var.domain} | " : ""}${module.pagopa_pay_wallet_redis[0].name}] Used Memory close to the threshold"
  resource_group_name = azurerm_resource_group.redis_pay_wallet_rg.name
  scopes              = [module.pagopa_pay_wallet_redis[0].id]
  description         = "The amount of cache memory in MB that is used for key/value pairs in the cache during the specified reporting interval, this amount is close to 200 MB so close to the threshold (250 MB)"
  severity            = 0
  window_size         = "PT5M"
  frequency           = "PT5M"
  auto_mitigate       = false

  target_resource_type     = "Microsoft.Cache/redis"
  target_resource_location = var.location

  # Metric info
  # https://learn.microsoft.com/en-us/azure/azure-monitor/essentials/metrics-supported#microsoftdocumentdbdatabaseaccounts
  criteria {
    metric_namespace       = "Microsoft.Cache/redis"
    metric_name            = "usedmemory"
    aggregation            = "Maximum"
    operator               = "GreaterThan"
    threshold              = "200000000"
    skip_metric_validation = false
  }

  action {
    action_group_id = data.azurerm_monitor_action_group.email.id
  }

  action {
    action_group_id = data.azurerm_monitor_action_group.slack.id
  }

  action {
    action_group_id = azurerm_monitor_action_group.payment_wallet_opsgenie[0].id
  }

  tags = module.tag_config.tags
}
