resource "azurerm_resource_group" "pagopa_proxy_rg" {
  name     = format("%s-pagopa-proxy-rg", local.parent_project)
  location = var.location

  tags = var.tags
}


module "pagopa_proxy_redis" {
  source                = "git::https://github.com/pagopa/terraform-azurerm-v3.git//redis_cache?ref=v7.69.1"
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
  redis_version = "6"

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
