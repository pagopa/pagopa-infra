resource "azurerm_role_definition" "iac_reader" {
  name        = "PagoPA Platform ${title(var.env)} IaC Reader"
  scope       = data.azurerm_subscription.current.id
  description = "Custom role for pagopa platform team. Infrastructure as Code read-only role"

  permissions {

    actions = [
      "Microsoft.Resources/deployments/exportTemplate/action", # read arm template deployments
      "Microsoft.Resources/*/read",                            #resources
      # "Microsoft.Resources/subscriptions/resourcegroups/read", #resources
      "Microsoft.Web/sites/config/list/action",       # read app config for function app, app service
      "Microsoft.Web/sites/slots/config/list/action", # read app config for function app, app service slots
      "Microsoft.ContainerService/*/read",            # help to generate cluster credentials
      # "Microsoft.ContainerService/managedClusters/read",                                 # help to generate cluster credentials
      # "Microsoft.ContainerService/managedClusters/listClusterUserCredential/action",     # help to generate cluster credentials
      # "Microsoft.ContainerService/managedClusters/accessProfiles/listCredential/action", # help to generate cluster credentials and read cluster roles
      "Microsoft.EventHub/namespaces/*/listKeys/action", #help to list key for event hub connection (mandatory for tf:azurerm_eventhub_authorization_rule)
      # "Microsoft.EventHub/namespaces/eventhubs/authorizationRules/listKeys/action",      #help to list key for event hub connection (mandatory for tf:azurerm_eventhub_authorization_rule)
      "Microsoft.ServiceBus/namespaces/*/listKeys/action", #help to list key for service bus connection
      # "Microsoft.ServiceBus/namespaces/authorizationRules/listKeys/action",              #help to list key for service bus connection
      # "Microsoft.ServiceBus/namespaces/queues/authorizationRules/listKeys/action",
      "Microsoft.Cache/*/listKeys/action", # Redis List
      # "Microsoft.Cache/redis/listKeys/action", # Redis List
      "Microsoft.Web/sites/*/listkeys/action",
      # "Microsoft.Web/sites/host/listkeys/action",
      "Microsoft.Storage/*/listkeys/action", # terraform get status backend
      # "Microsoft.Storage/storageAccounts/listkeys/action",             # terraform get status backend
      # "Microsoft.Storage/storageAccounts/blobServices/read",
      # "Microsoft.Storage/storageAccounts/fileServices/read",
      # "Microsoft.Storage/storageAccounts/queueServices/read",
      "Microsoft.Storage/*/read",
      # "Microsoft.Storage/storageAccounts/read",
      "Microsoft.ContainerRegistry/*/listCredentials/action", # ACR list
      # "Microsoft.ContainerRegistry/registries/listCredentials/action", # ACR list
      "Microsoft.ApiManagement/*/read",
      # "Microsoft.ApiManagement/service/read",
      "Microsoft.KeyVault/*/read", #KeyVault
      # "Microsoft.KeyVault/vaults/read", #KeyVault
      "Microsoft.OperationalInsights/*/read",
      # "Microsoft.OperationalInsights/workspaces/read",
      "Microsoft.Insights/*/read",
      # "Microsoft.Insights/actionGroups/read",
      # "Microsoft.Insights/components/read",
      # "Microsoft.Insights/metricAlerts/read",
      "Microsoft.Network/*/read",
      # "Microsoft.Network/virtualNetworks/read",
      # "Microsoft.Network/virtualNetworks/subnets/read",
      "Microsoft.App/*/read", #container app envs
      # "Microsoft.App/managedEnvironments/read", #container app envs
      "Microsoft.Security/*/read",
      # "Microsoft.Security/advancedThreatProtectionSettings/read",
      "Microsoft.Authorization/*/read",
    ]
  }
}

# "PagoPA IaC Reader",
# "Reader",
# "Reader and Data Access",
# "Storage Blob Data Reader",
# "Storage File Data SMB Share Reader",
# "Storage Queue Data Reader",
# "Storage Table Data Reader",
# "PagoPA Export Deployments Template",
# "Key Vault Secrets User",
# "DocumentDB Account Contributor",
# "API Management Service Contributor",
