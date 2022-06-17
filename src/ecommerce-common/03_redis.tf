resource "azurerm_resource_group" "redis_ecommerce_rg" {
  name     = format("%s-redis-rg", local.project)
  location = var.location

  tags = var.tags
}

module "pagopa_ecommerce_redis_snet" {
  source                                         = "git::https://github.com/pagopa/azurerm.git//subnet?ref=v2.18.3"
  name                                           = format("%s-redis-snet", local.project)
  address_prefixes                               = var.cidr_subnet_redis_ecommerce
  resource_group_name                            = local.vnet_resource_group_name
  virtual_network_name                           = local.vnet_name
  enforce_private_link_endpoint_network_policies = true
}

module "pagopa_ecommerce_redis" {
  source                = "git::https://github.com/pagopa/azurerm.git//redis_cache?ref=v2.18.3"
  name                  = format("%s-redis", local.project)
  resource_group_name   = azurerm_resource_group.redis_ecommerce_rg.name
  location              = azurerm_resource_group.redis_ecommerce_rg.location
  capacity              = var.redis_ecommerce_params.capacity
  enable_non_ssl_port   = false
  family                = var.redis_ecommerce_params.family
  sku_name              = var.redis_ecommerce_params.sku_name
  enable_authentication = true

  private_endpoint = {
    enabled              = true
    virtual_network_id   = data.terraform_remote_state.core.outputs.vnet_id
    subnet_id            = module.pagopa_ecommerce_redis_snet.id
    private_dns_zone_ids = [azurerm_private_dns_zone.privatelink_ecommerce_redis.id]
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