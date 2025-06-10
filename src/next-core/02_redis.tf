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
