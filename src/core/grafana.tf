

resource "azurerm_dashboard_grafana" "example" {
  name                              = format("%s-grafana", local.project)
  resource_group_name               = azurerm_resource_group.data.location
  location                          = azurerm_resource_group.data.location
  api_key_enabled                   = false
  deterministic_outbound_ip_enabled = true
  public_network_access_enabled     = true

  identity {
    type = "SystemAssigned"
  }

  tags = {
    key = "gilda-k6"
  }
}