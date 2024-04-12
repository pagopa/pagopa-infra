# already created into observability domain

# resource "azurerm_data_factory_linked_service_cosmosdb" "cosmos_biz" {
#   name             = "CosmosDbNoSqlBizPositivi${var.env_short}LinkService"
#   data_factory_id  = data.azurerm_data_factory.qi_data_factory.id
#   account_endpoint = data.azurerm_cosmosdb_account.bizevent_cosmos_account.endpoint
#   account_key      = data.azurerm_cosmosdb_account.bizevent_cosmos_account.primary_key
#   database         = "db"
# }

data "azurerm_data_factory" "data_factory" {
  name                = "pagopa-${var.env_short}-weu-nodo-df"
  resource_group_name = "pagopa-${var.env_short}-weu-nodo-df-rg"
}

data "azurerm_key_vault_secret" "tokenizer_api_key" {
  name         = "tokenizer-api-key"
  key_vault_id = module.key_vault.id
}

locals {
  pdv_hostname = var.env == "prod" ? "https://api.tokenizer.pdv.pagopa.it/tokenizer/v1" : "https://api.${var.env}.tokenizer.pdv.pagopa.it/tokenizer/v1"
}


resource "azapi_resource" "tokenizer_rest_service" {
  type      = "Microsoft.DataFactory/factories/linkedservices@2018-06-01"
  name      = "${var.env}_TokenizerRestService"
  parent_id = data.azurerm_data_factory.data_factory.id

  body = jsonencode({
    "properties" : {
      "annotations" : [],
      "type" : "RestService",
      "typeProperties" : {
        "url" : "${local.pdv_hostname}",
        "enableServerCertificateValidation" : false,
        "authenticationType" : "Anonymous",
        "authHeaders" : {
          "x-api-key" : {
            "type" : "SecureString",
            "value" : "${data.azurerm_key_vault_secret.tokenizer_api_key.value}"
          }
        }
      },
      "connectVia" : {
        "referenceName" : "AutoResolveIntegrationRuntime",
        "type" : "IntegrationRuntimeReference"
      }
  } })

}
