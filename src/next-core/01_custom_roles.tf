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
      "Microsoft.Web/staticSites/listSecrets/action",
      "Microsoft.Web/staticSites/listAppSettings/action",
      "Microsoft.Logic/workflows/triggers/listCallbackUrl/action", # read callback url from logic app triggers
      "Microsoft.ContainerService/*/read",                         # help to generate cluster credentials
      # "Microsoft.ContainerService/managedClusters/read",                                 # help to generate cluster credentials
      # "Microsoft.ContainerService/managedClusters/listClusterUserCredential/action",     # help to generate cluster credentials
      # "Microsoft.ContainerService/managedClusters/accessProfiles/listCredential/action", # help to generate cluster credentials and read cluster roles
      "Microsoft.EventHub/namespaces/*/listKeys/action", #help to list key for event hub connection (mandatory for tf:azurerm_eventhub_authorization_rule)
      # "Microsoft.EventHub/namespaces/eventhubs/authorizationRules/listKeys/action",      #help to list key for event hub connection (mandatory for tf:azurerm_eventhub_authorization_rule)
      "Microsoft.ServiceBus/namespaces/*/listKeys/action", #help to list key for service bus connection
      # "Microsoft.ServiceBus/namespaces/authorizationRules/listKeys/action",              #help to list key for service bus connection
      # "Microsoft.ServiceBus/namespaces/queues/authorizationRules/listKeys/action",
      "Microsoft.Cache/*/listKeys/action", # Redis List
      "Microsoft.Cache/redis/read",        # Redis
      "Microsoft.Cache/redis/*/read",      # redis
      # "Microsoft.Cache/redis/patchSchedules/read", # redis
      # "Microsoft.Cache/redis/listKeys/action", # Redis List
      "Microsoft.Web/sites/*/listkeys/action",
      "Microsoft.Web/sites/read",
      "Microsoft.Web/sites/*/read",
      "Microsoft.Web/serverfarms/read",
      # "Microsoft.Web/sites/config/read",
      # "Microsoft.Web/sites/host/listkeys/action",
      "Microsoft.Storage/*/read",
      "Microsoft.Storage/*/listkeys/action", # terraform get status backend
      "Microsoft.Storage/storageAccounts/*/read",
      "Microsoft.Storage/storageAccounts/queueServices/*/read",
      "Microsoft.Storage/storageAccounts/tableServices/*/read",
      "Microsoft.Storage/storageAccounts/blobServices/*/read",
      # "Microsoft.Storage/storageAccounts/listkeys/action",             # terraform get status backend
      # "Microsoft.Storage/storageAccounts/blobServices/read",
      # "Microsoft.Storage/storageAccounts/fileServices/read",
      # "Microsoft.Storage/storageAccounts/queueServices/read",
      # "Microsoft.Storage/storageAccounts/read",
      "Microsoft.ContainerRegistry/registries/read",          #ACR
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
      "Microsoft.App/*/read",                  #container app envs
      "Microsoft.App/jobs/listSecrets/action", # container app jobs
      # "Microsoft.App/managedEnvironments/read", #container app envs
      "Microsoft.Security/*/read",
      # "Microsoft.Security/advancedThreatProtectionSettings/read",
      "Microsoft.Authorization/*/read",
      "Microsoft.Compute/*/read",
      # "Microsoft.Compute/sshPublicKeys/read",
      "Microsoft.ManagedIdentity/userAssignedIdentities/read",                              #managed identity
      "Microsoft.ManagedIdentity/userAssignedIdentities/federatedIdentityCredentials/read", #managed identity
      "Microsoft.DBforPostgreSQL/servers/read",                                             #postgresql
      "Microsoft.DBforPostgreSQL/servers/*/read",                                           #postgreql
      # "Microsoft.DBforPostgreSQL/servers/databases/read", #postgreql
      # "Microsoft.DBforPostgreSQL/servers/firewallRules/read", #postgresql
      # "Microsoft.DBforPostgreSQL/servers/configurations/read", #postgresql
      "Microsoft.DBforPostgreSQL/flexibleServers/read",                     #postgres flexible
      "Microsoft.DBforPostgreSQL/flexibleServers/*/read",                   #postgres flexible
      "Microsoft.DocumentDB/databaseAccounts/read",                         #cosmosdb
      "Microsoft.DocumentDB/databaseAccounts/*/read",                       #cosmos mongodb
      "Microsoft.DocumentDB/databaseAccounts/listConnectionStrings/action", #cosmosdb
      "Microsoft.DocumentDB/databaseAccounts/listKeys/action",              #cosmosdb
      "Microsoft.DocumentDB/databaseAccounts/readonlykeys/action",          #cosmosdb
      # "Microsoft.DocumentDB/databaseAccounts/sqlDatabases/read", #cosmosdb
      # "Microsoft.DocumentDB/databaseAccounts/tables/read", #cosmosdb
      # "Microsoft.DocumentDB/databaseAccounts/sqlDatabases/containers/read", #cosmosdb
      # "Microsoft.DocumentDB/databaseAccounts/mongodbDatabases/throughputSettings/read", #cosmosdb
      # "Microsoft.DocumentDB/databaseAccounts/mongodbDatabases/read", #cosmos mongodb
      # "Microsoft.DocumentDB/databaseAccounts/mongodbDatabases/collections/read", #cosmosdb mongodb
      "Microsoft.ContainerService/managedClusters/accessProfiles/listCredential/action", #aks
      "Microsoft.Kusto/clusters/read",
      "Microsoft.Kusto/clusters/*/read",
      # "Microsoft.Kusto/clusters/databases/read",                                         #DAX
      # "Microsoft.Kusto/clusters/databases/*/read",
      # "Microsoft.Kusto/clusters/databases/principalAssignments/read",
      "Microsoft.DataFactory/factories/read",
      "Microsoft.DataFactory/factories/*/read",
      # "Microsoft.DataFactory/factories/linkedservices/read",
      # "Microsoft.DataFactory/factories/pipelines/read",
      "Microsoft.EventGrid/systemTopics/read",
      "Microsoft.EventGrid/systemTopics/*/read",
      # "Microsoft.EventGrid/systemTopics/eventSubscriptions/read",
      "Microsoft.EventHub/namespaces/read",
      "Microsoft.EventHub/namespaces/*/read",
      # "Microsoft.EventHub/namespaces/eventhubs/read",
      # "Microsoft.EventHub/namespaces/eventhubs/authorizationRules/read",
      "Microsoft.Cdn/profiles/read",
      "Microsoft.Cdn/profiles/*/read",
      # "Microsoft.Cdn/profiles/endpoints/read",
      "Microsoft.DataFactory/factories/*/read",
      # "Microsoft.DataFactory/factories/datasets/read",
      "Microsoft.ApiManagement/service/portalsettings/listSecrets/action",
      "Microsoft.ApiManagement/service/tenant/listSecrets/action",
      "Microsoft.ApiManagement/service/subscriptions/listSecrets/action",
      "Microsoft.Compute/virtualMachineScaleSets/write", #scale the VMSS
      "Microsoft.AppConfiguration/configurationStores/*/read",
      "Microsoft.AppConfiguration/configurationStores/*/action"

    ]

    data_actions = [
      "Microsoft.AppConfiguration/configurationStores/*/read",
      "Microsoft.AppConfiguration/configurationStores/*/action"
    ]
  }
}
