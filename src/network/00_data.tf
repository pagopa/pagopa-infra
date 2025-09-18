data "azurerm_virtual_machine" "data_factory_proxy" {
  count = var.enabled_features.data_factory_proxy ? 1 : 0
  name                = "db-nodo-proxy-vm"
  resource_group_name = "pagopa-${var.env_short}-weu-nodo-vmss-rg"
}

