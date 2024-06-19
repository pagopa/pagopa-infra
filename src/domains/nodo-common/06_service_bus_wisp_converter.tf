resource "azurerm_servicebus_namespace" "wisp_converter_servicebus" {
  count = var.enable_wisp_converter ? 1 : 0

  name                = "${local.project}-servicebus"
  location            = azurerm_resource_group.wisp_converter_rg[0].location
  resource_group_name = azurerm_resource_group.wisp_converter_rg[0].name
  sku                 = var.wisp_converter_service_bus.sku

  tags = var.tags

  depends_on = [
    azurerm_resource_group.wisp_converter_rg
  ]
}

resource "azurerm_servicebus_namespace_authorization_rule" "wisp_converter_servicebus_ns_auth" {
  count = var.enable_wisp_converter ? 1 : 0

  name         = "${local.project}-servicebus-ns-manager"
  namespace_id = azurerm_servicebus_namespace.wisp_converter_servicebus[0].id

  listen = true
  send   = true
  manage = true
}

# QUEUE Payment Timeout
resource "azurerm_servicebus_queue" "wisp_converter_payment_timeout" {
  count = var.enable_wisp_converter ? 1 : 0

  name         = "wisp_payment_timeout"
  namespace_id = azurerm_servicebus_namespace.wisp_converter_servicebus[0].id

  requires_duplicate_detection         = var.wisp_converter_service_bus.requires_duplicate_detection
  dead_lettering_on_message_expiration = var.wisp_converter_service_bus.dead_lettering_on_message_expiration
  enable_partitioning                  = var.wisp_converter_service_bus.enable_partitioning

  depends_on = [
    azurerm_servicebus_namespace.wisp_converter_servicebus,
    azurerm_servicebus_namespace_authorization_rule.wisp_converter_servicebus_ns_auth
  ]
}

# QUEUE paainviart retry
resource "azurerm_servicebus_queue" "wisp_converter_paainviart" {
  count = var.enable_wisp_converter ? 1 : 0

  name         = "paainviart"
  namespace_id = azurerm_servicebus_namespace.wisp_converter_servicebus[0].id

  requires_duplicate_detection         = var.wisp_converter_service_bus.requires_duplicate_detection
  dead_lettering_on_message_expiration = var.wisp_converter_service_bus.dead_lettering_on_message_expiration
  enable_partitioning                  = var.wisp_converter_service_bus.enable_partitioning

  depends_on = [
    azurerm_servicebus_namespace.wisp_converter_servicebus,
    azurerm_servicebus_namespace_authorization_rule.wisp_converter_servicebus_ns_auth
  ]
}

resource "azurerm_servicebus_queue_authorization_rule" "wisp_converter_payment_timeout_consumer" {
  count = var.enable_wisp_converter ? 1 : 0

  name     = "wisp-payment-timeout-consumer"
  queue_id = azurerm_servicebus_queue.wisp_converter_payment_timeout[0].id

  listen = true
  send   = false
  manage = false
}
