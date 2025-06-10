# -----------------------------------------------
# start of pagopa proxy Redis configuration
# -----------------------------------------------

resource "azurerm_resource_group" "pagopa_proxy_rg" {
  name     = format("%s-pagopa-proxy-rg", local.parent_project)
  location = var.location

  tags = module.tag_config.tags
}


module "pagopa_proxy_redis" {
  source                = "git::https://github.com/pagopa/terraform-azurerm-v3.git//redis_cache?ref=v8.42.3"
  name                  = format("%s-pagopa-proxy-redis", local.parent_project)
  resource_group_name   = azurerm_resource_group.pagopa_proxy_rg.name
  location              = azurerm_resource_group.pagopa_proxy_rg.location
  capacity              = var.pagopa_proxy_redis_capacity
  enable_non_ssl_port   = false
  family                = var.pagopa_proxy_redis_family
  sku_name              = var.pagopa_proxy_redis_sku_name
  enable_authentication = true

  private_endpoint = {
    enabled              = var.redis_private_endpoint_enabled
    virtual_network_id   = data.azurerm_resource_group.rg_vnet.id
    subnet_id            = module.pagopa_proxy_redis_snet.id
    private_dns_zone_ids = var.redis_private_endpoint_enabled ? [data.azurerm_private_dns_zone.privatelink_redis_cache_windows_net.id] : []
  }

  zones         = var.redis_zones
  redis_version = var.redis_version

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
# end of pagopa checkout Redis configuration
# -----------------------------------------------


# -----------------------------------------------
# start of pagopa checkout Redis configuration
# -----------------------------------------------

# Redis resource group
resource "azurerm_resource_group" "redis_checkout_rg" {
  name     = "${local.project}-redis-rg"
  location = var.location
  tags     = module.tag_config.tags
}

# Redis cache subnet
module "pagopa_checkout_redis_snet" {
  source = "git::https://github.com/pagopa/terraform-azurerm-v3.git//subnet?ref=v8.83.1"

  name                                      = "${local.project}-redis-snet"
  address_prefixes                          = var.cidr_subnet_redis_checkout
  resource_group_name                       = data.azurerm_resource_group.rg_vnet.name
  virtual_network_name                      = data.azurerm_virtual_network.vnet.name
  private_endpoint_network_policies_enabled = true
}



module "pagopa_checkout_redis" {
  source                        = "git::https://github.com/pagopa/terraform-azurerm-v3.git//redis_cache?ref=v8.83.1"
  name                          = var.redis_checkout_params.ha_enabled ? "${local.project}-redis-ha" : "${local.project}-redis"
  resource_group_name           = azurerm_resource_group.redis_checkout_rg.name
  location                      = azurerm_resource_group.redis_checkout_rg.location
  capacity                      = var.redis_checkout_params.capacity
  enable_non_ssl_port           = false
  family                        = var.redis_checkout_params.family
  sku_name                      = var.redis_checkout_params.sku_name
  enable_authentication         = true
  redis_version                 = var.redis_checkout_params.version
  public_network_access_enabled = false
  zones                         = var.redis_checkout_params.zones

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

resource "azurerm_monitor_metric_alert" "redis_cache_used_memory_exceeded" {
  count = var.env_short == "p" ? 1 : 0

  name                = "[${var.domain != null ? "${var.domain} | " : ""}${module.pagopa_checkout_redis.name}] Used Memory close to the threshold"
  resource_group_name = azurerm_resource_group.redis_checkout_rg.name
  scopes              = [module.pagopa_checkout_redis.id]
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
