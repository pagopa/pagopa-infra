data "azurerm_redis_cache" "redis" {
  name                = "${local.product}-redis"
  resource_group_name = data.azurerm_resource_group.data.name
}
