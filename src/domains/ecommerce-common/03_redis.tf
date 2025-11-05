resource "azurerm_resource_group" "redis_ecommerce_rg" {
  name     = "${local.project}-redis-rg"
  location = var.location

  tags = module.tag_config.tags
}

module "pagopa_ecommerce_redis_snet" {
  source = "git::https://github.com/pagopa/terraform-azurerm-v3.git//subnet?ref=v8.42.3"

  name                                      = format("%s-redis-snet", local.project)
  address_prefixes                          = var.cidr_subnet_redis_ecommerce
  resource_group_name                       = local.vnet_resource_group_name
  virtual_network_name                      = local.vnet_name
  private_endpoint_network_policies_enabled = true
}

module "pagopa_ecommerce_redis" {
  source = "git::https://github.com/pagopa/terraform-azurerm-v3.git//redis_cache?ref=v8.42.3"

  # name has been differentiated due to a migration instance created to handle the switch to an HA instance
  name                          = var.redis_ecommerce_params.ha_enabled ? "${local.project}-redis-ha" : "${local.project}-redis"
  resource_group_name           = azurerm_resource_group.redis_ecommerce_rg.name
  location                      = azurerm_resource_group.redis_ecommerce_rg.location
  capacity                      = var.redis_ecommerce_params.capacity
  enable_non_ssl_port           = false
  family                        = var.redis_ecommerce_params.family
  sku_name                      = var.redis_ecommerce_params.sku_name
  enable_authentication         = true
  redis_version                 = var.redis_ecommerce_params.version
  public_network_access_enabled = var.env_short == "d"
  zones                         = var.redis_ecommerce_params.zones

  private_endpoint = {
    enabled              = var.env_short != "d"
    virtual_network_id   = "/subscriptions/bbe47ad4-08b3-4925-94c5-1278e5819b86/resourceGroups/pagopa-d-vnet-rg/providers/Microsoft.Network/virtualNetworks/pagopa-d-vnet"
    subnet_id            = module.pagopa_ecommerce_redis_snet.id
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
  count = var.env_short == "p" ? 1 : 0

  name                = "[${var.domain != null ? "${var.domain} | " : ""}${module.pagopa_ecommerce_redis.name}] Used Memory close to the threshold"
  resource_group_name = azurerm_resource_group.redis_ecommerce_rg.name
  scopes              = [module.pagopa_ecommerce_redis.id]
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
    action_group_id = azurerm_monitor_action_group.ecommerce_opsgenie[0].id
  }

  action {
    action_group_id = azurerm_monitor_action_group.service_management_opsgenie[0].id
  }

  tags = module.tag_config.tags
}


