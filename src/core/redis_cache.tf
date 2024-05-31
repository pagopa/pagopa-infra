data "azurerm_private_dns_zone" "privatelink_redis_azure_com" {
  name                = "privatelink.redis.cache.windows.net"
  resource_group_name = azurerm_resource_group.rg_vnet.name
}

## Redis subnet
module "redis_snet" {
  source                                         = "git::https://github.com/pagopa/azurerm.git//subnet?ref=v2.18.3"
  name                                           = format("%s-redis-snet", local.project)
  address_prefixes                               = var.cidr_subnet_redis
  resource_group_name                            = azurerm_resource_group.rg_vnet.name
  virtual_network_name                           = module.vnet.name # module.vnet_integration.name ???
  enforce_private_link_endpoint_network_policies = !var.redis_cache_params.public_access
}

module "redis" {
  source                = "git::https://github.com/pagopa/azurerm.git//redis_cache?ref=v2.18.3"
  name                  = format("%s-redis", local.project)
  resource_group_name   = azurerm_resource_group.data.name
  location              = azurerm_resource_group.data.location
  capacity              = var.redis_cache_params.capacity
  enable_non_ssl_port   = false
  family                = var.redis_cache_params.family
  sku_name              = var.redis_cache_params.sku_name
  enable_authentication = true

  public_network_access_enabled = var.redis_cache_params.public_access

  private_endpoint = {
    enabled              = !var.redis_cache_params.public_access
    virtual_network_id   = module.vnet.id
    subnet_id            = module.redis_snet.id
    private_dns_zone_ids = [data.azurerm_private_dns_zone.privatelink_redis_azure_com.id]
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

  tags = var.tags
}

resource "azurerm_private_dns_zone_virtual_network_link" "vnet_integration_network_link" {
  name                  = format("%s-vnet-integration", local.project)
  resource_group_name   = azurerm_resource_group.rg_vnet.name
  private_dns_zone_name = data.azurerm_private_dns_zone.privatelink_redis_azure_com.name
  virtual_network_id    = module.vnet_integration.id
}

# Already apply forcing redis_connection_string on apim_module
resource "azurerm_api_management_redis_cache" "apim_external_cache_redis" {
  name              = "apim-external-cache-redis"
  api_management_id = var.enabled_features.apim_migrated ? data.azurerm_api_management.apim_migrated[0].id : module.apim[0].id
  connection_string = module.redis.primary_connection_string
  description       = "APIM external cache Redis"
  redis_cache_id    = module.redis.id
  cache_location    = var.location
}
