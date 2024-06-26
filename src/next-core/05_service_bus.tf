locals {
  # Map of <queue_names, queue>
  queues = { for q in var.service_bus_01_queues : q.name => q }

  # List of queue names
  queue_names = keys(local.queues)
  # List of queue values
  queue_values = values(local.queues)

  # Map of <authorization_key, authorization(queue, properties)>
  key_queue_map = {
    for qk in flatten([
      for q in var.service_bus_01_queues :
      [
        for k in q.keys : {
          key_name   = k.name
          queue_name = q.name
          listen     = k.listen
          send       = k.send
          manage     = k.manage
        }
      ]
      ]) : "${qk.key_name}" => {
      queue_name = qk.queue_name
      listen     = qk.listen
      send       = qk.send
      manage     = qk.manage
    }
  }

  # Local variable to store the map of queue names to related resource ids
  # queue_map enables access to queue_id by queue_name -> <queue_name, queue_id>
  queue_map = { for idx, name in local.queue_names : name => azurerm_servicebus_queue.service_bus_01_queue[idx].id }
}

resource "azurerm_resource_group" "service_bus_rg" {
  name     = local.sb_resource_group_name
  location = var.location

  tags = var.tags
}

# https://learn.microsoft.com/en-us/azure/service-bus-messaging/service-bus-quotas
resource "azurerm_servicebus_namespace" "service_bus_01" {
  name                = "${local.project}-servicebus-01"
  location            = var.location
  resource_group_name = local.sb_resource_group_name
  sku                 = var.service_bus_01.sku
  zone_redundant      = var.service_bus_01.sku == "Premium" # https://learn.microsoft.com/en-us/azure/well-architected/service-guides/service-bus/reliability

  capacity = try(var.service_bus_01.capacity, null)
  # premium_messaging_partitions = var.service_bus_01.premium_messaging_partitions # from azurerm version 3.9.3

  tags = var.tags

  depends_on = [
    azurerm_resource_group.service_bus_rg
  ]
}

resource "azurerm_servicebus_queue" "service_bus_01_queue" {
  count = length(local.queue_values)

  name         = local.queue_values[count.index].name
  namespace_id = azurerm_servicebus_namespace.service_bus_01.id

  enable_partitioning = var.service_bus_01.sku == "Premium" ? null : local.queue_values[count.index].enable_partitioning
  default_message_ttl = var.service_bus_01.queue_default_message_ttl

  depends_on = [
    azurerm_servicebus_namespace.service_bus_01
  ]
}

resource "azurerm_servicebus_queue_authorization_rule" "service_bus_01_queue_authorization_rule" {
  for_each = local.key_queue_map

  name     = each.key
  queue_id = local.queue_map[each.value.queue_name]

  listen = each.value.listen
  send   = each.value.send
  manage = each.value.manage

  depends_on = [
    azurerm_servicebus_namespace.service_bus_01,
    azurerm_servicebus_queue.service_bus_01_queue
  ]
}
