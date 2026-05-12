#####################################
##    API search Transaction ##
#####################################
locals {
  apim_searchtransactionsservice_api = {
    // EC
    display_name          = "Search Transactions Service"
    description           = "API to handle search transactions"
    path                  = "searchtransactions"
    subscription_required = false
    service_url           = null
  }
}

##############
## Products ##
##############

//Search Transactions service
module "apim_search_transactions_service" {
  source = "./.terraform/modules/__v3__/api_management_product"

  product_id   = "searchtransactions"
  display_name = "Search payment transactions"
  description  = "Product search payment transactions"

  api_management_name = local.pagopa_apim_name
  resource_group_name = local.pagopa_apim_rg

  published             = true
  subscription_required = local.apim_searchtransactionsservice_api.subscription_required
  approval_required     = false
  subscriptions_limit   = 1000

  policy_xml = file("./api_product/search-transactions/_base_policy.xml")
}

##############
## Api Vers ##
##############

resource "azurerm_api_management_api_version_set" "searchtransactions_api" {

  name                = format("%s-searchtransactions-service-api", var.env_short)
  resource_group_name = local.pagopa_apim_rg
  api_management_name = local.pagopa_apim_name
  display_name        = local.apim_searchtransactionsservice_api.display_name
  versioning_scheme   = "Segment"
}


##############
## OpenApi  ##
##############

module "apim_api_search_transactions_api_v1" {
  source = "./.terraform/modules/__v3__/api_management_api"

  name                  = format("%s-searchtransactions-service-api", local.project)
  api_management_name   = local.pagopa_apim_name
  resource_group_name   = local.pagopa_apim_rg
  product_ids           = [module.apim_search_transactions_service.product_id]
  subscription_required = local.apim_searchtransactionsservice_api.subscription_required
  version_set_id        = azurerm_api_management_api_version_set.searchtransactions_api.id
  api_version           = "v1"

  description  = local.apim_searchtransactionsservice_api.description
  display_name = local.apim_searchtransactionsservice_api.display_name
  path         = local.apim_searchtransactionsservice_api.path
  protocols    = ["https"]
  service_url  = local.apim_searchtransactionsservice_api.service_url

  content_format = "openapi"
  content_value = templatefile("./api/search-transactions-service/v1/_openapi.json.tpl", {
    host = local.apim_hostname
  })

  xml_content = templatefile("./api/search-transactions-service/v1/_base_policy.xml", {
    hostname                    = local.searchtransactions_hostname
    cie_search_segragation_code = local.cie_search_segragation_code
  })
}

data "azurerm_key_vault_secret" "search_transactions_token_secret" {
  name         = "search-transactions-token-secret"
  key_vault_id = data.azurerm_key_vault.kv.id
}

resource "azurerm_api_management_named_value" "search_transactions_token_secret_value" {
  name                = "search-transactions-token-secret-value"
  api_management_name = local.pagopa_apim_name
  resource_group_name = local.pagopa_apim_rg
  display_name        = "search-transactions-token-secret-value"
  value               = data.azurerm_key_vault_secret.search_transactions_token_secret.value
  secret              = true
}
