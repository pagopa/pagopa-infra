#####################################
##    API search Transaction ##
#####################################
locals {
  apim_searchtransactionswebview_api = {
    // EC
    display_name          = "Search Transactions Webview"
    description           = "API to expose search transactions webview"
    path                  = "ciesearch"
    subscription_required = false
    service_url           = null
  }
}

##############
## Products ##
##############

//Search Transactions Webview
module "apim_search_transactions_webview" {
  source = "./.terraform/modules/__v3__/api_management_product"

  product_id   = "searchtransactionswebview"
  display_name = local.apim_searchtransactionswebview_api.display_name
  description  = local.apim_searchtransactionswebview_api.description

  api_management_name = local.pagopa_apim_name
  resource_group_name = local.pagopa_apim_rg

  published             = true
  subscription_required = local.apim_searchtransactionswebview_api.subscription_required
  approval_required     = false

  policy_xml = file("./api_product/search-transactions/_base_policy.xml")
}

##############
## Api Vers ##
##############

resource "azurerm_api_management_api_version_set" "searchtransactions_webview_api" {

  name                = format("%s-searchtransactions-webview-api", var.env_short)
  resource_group_name = local.pagopa_apim_rg
  api_management_name = local.pagopa_apim_name
  display_name        = local.apim_searchtransactionswebview_api.display_name
  versioning_scheme   = "Segment"
}


##############
## OpenApi  ##
##############

module "apim_api_search_transactions_webview_api_v1" {
  source = "./.terraform/modules/__v3__/api_management_api"

  name                  = format("%s-searchtransactions-webview-api", local.project)
  api_management_name   = local.pagopa_apim_name
  resource_group_name   = local.pagopa_apim_rg
  product_ids           = [module.apim_search_transactions_webview.product_id]
  subscription_required = local.apim_searchtransactionswebview_api.subscription_required
  version_set_id        = azurerm_api_management_api_version_set.searchtransactions_webview_api.id
  api_version           = "v1"

  description  = local.apim_searchtransactionswebview_api.description
  display_name = local.apim_searchtransactionswebview_api.display_name
  path         = local.apim_searchtransactionswebview_api.path
  protocols    = ["https"]
  service_url  = local.apim_searchtransactionswebview_api.service_url

  content_format = "openapi"
  content_value = templatefile("./api/search-transactions-webview/v1/_openapi.json.tpl", {
    hostname = local.apim_hostname
  })

  xml_content = templatefile("./api/search-transactions-webview/v1/_base_policy.xml", {
    hostname = local.shared_hostname
  })
}
