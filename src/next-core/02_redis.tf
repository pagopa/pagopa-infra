data "azurerm_private_dns_zone" "privatelink_redis_azure_com" {
  name                = "privatelink.redis.cache.windows.net"
  resource_group_name = data.azurerm_resource_group.rg_vnet.name
}

data "azurerm_subnet" "redis_subnet" {
  name                 = "${local.product}-redis-snet"
  resource_group_name  = data.azurerm_resource_group.rg_vnet.name
  virtual_network_name = data.azurerm_virtual_network.vnet_core.name
}

module "redis" {
  count                 = var.create_redis_multiaz ? 1 : 0
  source                = "git::https://github.com/pagopa/terraform-azurerm-v3.git//redis_cache?ref=v7.50.0"
  name                  = "${local.product_region}-redis"
  resource_group_name   = data.azurerm_resource_group.data.name
  location              = data.azurerm_resource_group.data.location
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
    virtual_network_id   = data.azurerm_virtual_network.vnet_core.id
    subnet_id            = data.azurerm_subnet.redis_subnet.id
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


