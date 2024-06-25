locals {
  # Map of <queue_names, queue>
  queues = { for q in var.service_bus_01_queues : q.name => q }

  # List of queue names
  queue_names = keys(local.queues)

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
}

resource "azurerm_servicebus_namespace" "service_bus_01" {
  name                = "${local.project}-servicebus-01"
  location            = var.location
  resource_group_name = local.msg_resource_group_name
  sku                 = var.service_bus_01.sku

  tags = var.tags
}

resource "azurerm_servicebus_queue" "service_bus_01_queue" {
  count = length(local.queue_names)

  name         = local.queue_names[count.index]
  namespace_id = azurerm_servicebus_namespace.service_bus_01.id

  depends_on = [
    azurerm_servicebus_namespace.service_bus_01
  ]
}

# Local variable to store the map of queue names to related resource ids
locals {
  queue_map = { for idx, name in local.queue_names : name => azurerm_servicebus_queue.service_bus_01_queue[idx].id }
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
