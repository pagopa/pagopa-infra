locals {
  # Map of <queue_names, queue>
  queues = { for q in var.service_bus_wisp_queues : q.name => q }

  # List of queue names
  queue_names = [for q in var.service_bus_wisp_queues : q.name]

  # List of queue values
  queue_values = [for q in var.service_bus_wisp_queues : q]

  # Map of <authorization_key, authorization(queue, properties)>
  key_queue_map = {
    for qk in flatten([
      for q in var.service_bus_wisp_queues :
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
  queue_map = {
    for idx, name in local.queue_names : name =>
    azurerm_servicebus_queue.service_bus_wisp_queue[idx].id
  }
}

resource "azurerm_resource_group" "service_bus_rg" {
  name     = local.sb_resource_group_name
  location = var.location

  tags = module.tag_config.tags
}

# https://learn.microsoft.com/en-us/azure/service-bus-messaging/service-bus-quotas
resource "azurerm_servicebus_namespace" "service_bus_wisp" {
  name                = "${local.project}-servicebus-wisp"
  location            = var.location
  resource_group_name = local.sb_resource_group_name
  sku                 = var.service_bus_wisp.sku
  zone_redundant      = var.service_bus_wisp.sku == "Premium"
  # https://learn.microsoft.com/en-us/azure/well-architected/service-guides/service-bus/reliability

  capacity                     = try(var.service_bus_wisp.capacity, null)
  premium_messaging_partitions = var.service_bus_wisp.premium_messaging_partitions

  dynamic "network_rule_set" {
    for_each = var.env_short == "p" ? [1] : []
    content {
      trusted_services_allowed = true

      default_action                = "Deny"
      public_network_access_enabled = true
      network_rules {
        subnet_id                            = data.azurerm_subnet.aks_subnet.id
        ignore_missing_vnet_service_endpoint = false
      }

    }
  }

  tags = module.tag_config.tags

  depends_on = [
    azurerm_resource_group.service_bus_rg
  ]
}

resource "azurerm_servicebus_queue" "service_bus_wisp_queue" {
  count = length(local.queue_values)

  name         = local.queue_values[count.index].name
  namespace_id = azurerm_servicebus_namespace.service_bus_wisp.id

  enable_partitioning = local.queue_values[count.index].enable_partitioning
  default_message_ttl = var.service_bus_wisp.queue_default_message_ttl

  depends_on = [
    azurerm_servicebus_namespace.service_bus_wisp
  ]
}

resource "azurerm_servicebus_queue_authorization_rule" "service_bus_wisp_queue_authorization_rule" {
  for_each = local.key_queue_map

  name     = each.key
  queue_id = local.queue_map[each.value.queue_name]

  listen = each.value.listen
  send   = each.value.send
  manage = each.value.manage

  depends_on = [
    azurerm_servicebus_namespace.service_bus_wisp,
    azurerm_servicebus_queue.service_bus_wisp_queue
  ]
}
