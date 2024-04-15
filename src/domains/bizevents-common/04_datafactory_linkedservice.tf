resource "azurerm_data_factory_linked_service_cosmosdb" "cosmos_biz_new" {
  name            = "NewCosmosDbNoSqlBizPositivi${var.env_short}LinkService"
  data_factory_id = data.azurerm_data_factory.data_factory.id

  database = "db"

  connection_string = format(
    "AccountEndpoint=%s;AccountKey=%s;Database=db;",
    data.azurerm_cosmosdb_account.bizevent_cosmos_account.endpoint,
    data.azurerm_cosmosdb_account.bizevent_cosmos_account.primary_key
  )
}
resource "azurerm_data_factory_linked_service_cosmosdb" "cosmos_biz_new_dev" {
  count = var.env_short == "d" ? 1 : 0 # used for ADF biz test developer 

  name            = "NewCosmosDbNoSqlBizPositivi${var.env_short}LinkServiceDev"
  data_factory_id = data.azurerm_data_factory.data_factory.id

  database = "db"

  connection_string = format(
    "AccountEndpoint=%s;AccountKey=%s;Database=db;",
    data.azurerm_cosmosdb_account.bizevent_cosmos_account_dev[0].endpoint,
    data.azurerm_cosmosdb_account.bizevent_cosmos_account_dev[0].primary_key
  )
}

locals {
  # pdv_hostname = var.env == "prod" ? "https://api.tokenizer.pdv.pagopa.it/tokenizer/v1" : "https://api.${var.env}.tokenizer.pdv.pagopa.it/tokenizer/v1"
  pdv_hostname = var.env == "prod" ? "https://api.tokenizer.pdv.pagopa.it/tokenizer/v1" : "https://api.uat.tokenizer.pdv.pagopa.it/tokenizer/v1" # PDV tokenizer doesn't exits in DEV env
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
