resource "azurerm_resource_group" "redis_ecommerce_rg" {
  name     = "${local.project}-redis-rg"
  location = var.location

  tags = var.tags
}

module "pagopa_ecommerce_redis_snet" {
  source = "git::https://github.com/pagopa/terraform-azurerm-v3.git//subnet?ref=v6.7.0"

  name                                      = format("%s-redis-snet", local.project)
  address_prefixes                          = var.cidr_subnet_redis_ecommerce
  resource_group_name                       = local.vnet_resource_group_name
  virtual_network_name                      = local.vnet_name
  private_endpoint_network_policies_enabled = true
}

module "pagopa_ecommerce_redis" {
  source = "git::https://github.com/pagopa/terraform-azurerm-v3.git//redis_cache?ref=v6.7.0"

  name                  = "${local.project}-redis"
  resource_group_name   = azurerm_resource_group.redis_ecommerce_rg.name
  location              = azurerm_resource_group.redis_ecommerce_rg.location
  capacity              = var.redis_ecommerce_params.capacity
  enable_non_ssl_port   = false
  family                = var.redis_ecommerce_params.family
  sku_name              = var.redis_ecommerce_params.sku_name
  enable_authentication = true
  redis_version         = var.redis_ecommerce_params.version

  private_endpoint = {
    enabled              = true
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

  tags = var.tags
}
