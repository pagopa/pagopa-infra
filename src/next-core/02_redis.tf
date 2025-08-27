module "redis_snet" {
  source                                    = "git::https://github.com/pagopa/terraform-azurerm-v3.git//subnet?ref=v7.50.0"
  name                                      = format("%s-redis-snet", local.product)
  address_prefixes                          = var.cidr_subnet_redis
  resource_group_name                       = azurerm_resource_group.rg_vnet.name
  virtual_network_name                      = module.vnet.name # module.vnet_integration.name ???
  private_endpoint_network_policies_enabled = var.redis_cache_params.public_access
}


module "redis" {
  count  = 1
  source = "git::https://github.com/pagopa/terraform-azurerm-v3.git//redis_cache?ref=v7.50.0"
  # name differentiated because the new ha version had to exist at the same time of the old version for migration purposes
  name                  = var.create_redis_multiaz ? "${local.product_region}-redis" : format("%s-redis", local.product)
  resource_group_name   = azurerm_resource_group.data.name
  location              = azurerm_resource_group.data.location
  capacity              = var.redis_cache_params.capacity
  enable_non_ssl_port   = false
  family                = var.redis_cache_params.family
  sku_name              = var.redis_cache_params.sku_name
  enable_authentication = true

  public_network_access_enabled = var.redis_cache_params.public_access

  redis_version = var.redis_version
  zones         = var.redis_zones

  private_endpoint = {
    enabled              = !var.redis_cache_params.public_access
    virtual_network_id   = module.vnet.id
    subnet_id            = module.redis_snet.id
    private_dns_zone_ids = [azurerm_private_dns_zone.privatelink_redis_cache_windows_net[0].id]
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

resource "azurerm_private_dns_zone_virtual_network_link" "vnet_integration_network_link" {
  name                  = format("%s-vnet-integration", local.product)
  resource_group_name   = azurerm_resource_group.rg_vnet.name
  private_dns_zone_name = azurerm_private_dns_zone.privatelink_redis_cache_windows_net[0].name
  virtual_network_id    = module.vnet_integration.id
}

# From https://github.com/pagopa/terraform-azurerm-v4/blob/0a7c2d5439660df28f2154eb86f5a8af0bbe8892/IDH/redis/main.tf#L56-L91
resource "azurerm_monitor_metric_alert" "redis_cache_used_memory_exceeded" {
  count = var.env_short == "p" ? 1 : 0

  name                = "[${module.redis[0].name}] Used Memory close to the threshold"
  resource_group_name = azurerm_resource_group.data.name
  scopes              = [module.redis[0].id]
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
    metric_name            = "usedmemorypercentage"
    aggregation            = "Maximum"
    operator               = "GreaterThan"
    threshold              = "80"
    skip_metric_validation = false
  }

  action {
    action_group_id = azurerm_monitor_action_group.slack.id
  }
  action {
    action_group_id = azurerm_monitor_action_group.email.id
  }
  action {
    action_group_id = azurerm_monitor_action_group.new_conn_srv_opsgenie[0].id
  }
  action {
    action_group_id = azurerm_monitor_action_group.infra_opsgenie.0.id
  }

  tags = module.tag_config.tags
}
