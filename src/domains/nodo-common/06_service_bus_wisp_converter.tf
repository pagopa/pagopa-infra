resource "azurerm_servicebus_namespace" "wisp-converter-servicebus" {
  #   count = var.env_short == "d" ? 0 : 1

  name                = "${local.project}-servicebus"
  location            = azurerm_resource_group.wisp_converter_rg[0].location
  resource_group_name = azurerm_resource_group.wisp_converter_rg[0].name
  sku                 = "Basic"

  tags = var.tags

  depends_on = [
    azurerm_resource_group.wisp_converter_rg
  ]
}

resource "azurerm_servicebus_queue" "paainviartqueue" {
  name         = "paainviart"
  namespace_id = azurerm_servicebus_namespace.wisp-converter-servicebus.id
  depends_on = [
    azurerm_servicebus_namespace.wisp-converter-servicebus
  ]
}

