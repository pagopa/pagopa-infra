#####################
## Resource Group:-
#####################
resource "azurerm_resource_group" "grafana_rg" {
  name     = format("%s-rg", local.project)
  location = var.location

  tags = var.tags
}


##############################
## Azure Managed Grafana:-
##############################
resource "azapi_resource" "azgrafana" {
  type        = "Microsoft.Dashboard/grafana@2022-08-01" 
  name        = format("%s", local.project)
  parent_id   = azurerm_resource_group.grafana_rg.id
  location    = azurerm_resource_group.grafana_rg.location

  identity {
    type      = "SystemAssigned"
  }

  body = jsonencode({
    sku = {
      name = "Standard"
    }
    properties = {
      publicNetworkAccess = "Enabled",
      zoneRedundancy = "Disabled",
      apiKey = "Enabled",
      deterministicOutboundIP = "Disabled"
    }
  })
  response_export_values = ["properties.endpoint", "identity.principalId"]
}


resource "azurerm_role_assignment" "grafana_rg" {
  scope = "/subscriptions/${data.azurerm_client_config.current.subscription_id}"
  // Moniroting Reader
  // https://docs.microsoft.com/en-us/azure/role-based-access-control/built-in-roles#monitoring-reader
  role_definition_id = "/subscriptions/${data.azurerm_client_config.current.subscription_id}/providers/Microsoft.Authorization/roleDefinitions/43d0d8ad-25c7-4714-9337-8ba259a9fe05"
  principal_id       = jsondecode(azapi_resource.azgrafana.output).identity.principalId
}