module "redis" {

  source = "git::https://github.com/pagopa/azurerm.git//redis_cache?ref=v1.0.37"

  name                  = format("%s-redis", local.project)
  resource_group_name   = azurerm_resource_group.db_rg.name
  location              = azurerm_resource_group.db_rg.location
  capacity              = var.redis_capacity
  enable_non_ssl_port   = false
  family                = var.redis_family
  sku_name              = var.redis_sku_name
  enable_authentication = true
  subnet_id             = length(module.redis_snet.*.id) == 0 ? null : module.redis_snet[0].id

  tags = var.tags
}
