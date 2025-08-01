# -----------------------------------------------
# start of pagopa checkout Redis configuration
# -----------------------------------------------

# Redis resource group
resource "azurerm_resource_group" "redis_std_checkout_rg" {
  name     = "${local.project}-redis-std-rg"
  location = var.location
  tags     = module.tag_config.tags
}

module "pagopa_checkout_redis_std" {
  source                        = "./.terraform/modules/__v4__/redis_cache"
  name                          = "${local.project}-redis-std"
  resource_group_name           = azurerm_resource_group.redis_std_checkout_rg.name
  location                      = azurerm_resource_group.redis_std_checkout_rg.location
  capacity                      = var.redis_checkout_params_std.capacity
  enable_non_ssl_port           = false
  family                        = var.redis_checkout_params_std.family
  sku_name                      = var.redis_checkout_params_std.sku_name
  enable_authentication         = true
  redis_version                 = var.redis_checkout_params_std.version
  public_network_access_enabled = false
  custom_zones                  = var.redis_checkout_params_std.zones

  private_endpoint = {
    enabled              = true
    virtual_network_id   = "not-used-by-module"
    subnet_id            = module.pagopa_checkout_redis_snet.id
    private_dns_zone_ids = [data.azurerm_private_dns_zone.privatelink_redis_cache_windows_net.id]
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

resource "azurerm_monitor_metric_alert" "redis_std_cache_used_memory_exceeded" {
  count = var.env_short == "p" ? 1 : 0

  name                = "[${var.domain != null ? "${var.domain} | " : ""}${module.pagopa_checkout_redis.name}] Used Memory close to the threshold"
  resource_group_name = azurerm_resource_group.redis_std_checkout_rg.name
  scopes              = [module.pagopa_checkout_redis_std.id]
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
    action_group_id = azurerm_monitor_action_group.checkout_opsgenie[0].id
  }

  tags = module.tag_config.tags
}

# -----------------------------------------------
# end of pagopa checkout Redis configuration
# -----------------------------------------------
