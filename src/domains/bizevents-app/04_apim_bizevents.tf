#####################################
##    API Biz Events & Transaction ##
#####################################
locals {
  apim_bizevents_service_api = { // EC
    display_name          = "Biz Events Service"
    description           = "API to handle biz events payments"
    path                  = "bizevents/service"
    subscription_required = true
    service_url           = null
  }
  apim_bizevents_helpdesk_api = { // Helpdesk
    display_name          = "Biz Events Helpdesk"
    description           = "API for helpdesk on biz events payments"
    path                  = "bizevents/helpdesk"
    subscription_required = true
    service_url           = null
  }
  apim_transaction_service_api = { // AppIO
    display_name          = "Biz Events Transaction Service"
    description           = "API to handle biz events transactions"
    path                  = "bizevents/tx-service"
    subscription_required = true
    service_url           = null
  }
}

##############
## Products ##
##############

// EC user(s)
module "apim_bizevents_product" {
  source = "git::https://github.com/pagopa/terraform-azurerm-v3.git//api_management_product?ref=v6.4.1"

  product_id   = "bizevents"
  display_name = local.apim_bizevents_service_api.display_name
  description  = local.apim_bizevents_service_api.description

  api_management_name = local.pagopa_apim_name
  resource_group_name = local.pagopa_apim_rg

  published             = false
  subscription_required = local.apim_bizevents_service_api.subscription_required
  approval_required     = true
  subscriptions_limit   = 1000

  policy_xml = file("./api_product/bizevents-service/_base_policy.xml")
}

// Helpdesk
module "apim_bizevents_helpdesk_product" {
  source = "git::https://github.com/pagopa/terraform-azurerm-v3.git//api_management_product?ref=v6.4.1"

  product_id   = "bizevents-helpdesk"
  display_name = local.apim_bizevents_helpdesk_api.display_name
  description  = local.apim_bizevents_helpdesk_api.description

  api_management_name = local.pagopa_apim_name
  resource_group_name = local.pagopa_apim_rg

  published             = false
  subscription_required = local.apim_bizevents_helpdesk_api.subscription_required
  approval_required     = true
  subscriptions_limit   = 1000

  policy_xml = file("./api_product/bizevents-helpdesk/_base_policy.xml")
}

// AppIO user
module "apim_transactions_product" {
  source = "git::https://github.com/pagopa/terraform-azurerm-v3.git//api_management_product?ref=v6.4.1"

  product_id   = "bizevent-transactions"
  display_name = local.apim_transaction_service_api.display_name
  description  = local.apim_transaction_service_api.description

  api_management_name = local.pagopa_apim_name
  resource_group_name = local.pagopa_apim_rg

  published             = false
  subscription_required = local.apim_transaction_service_api.subscription_required
  approval_required     = true
  subscriptions_limit   = 1000

  policy_xml = file("./api_product/transaction-service/_base_policy.xml")
}


##############
## Api Vers ##
##############

resource "azurerm_api_management_api_version_set" "api_bizevents_api" {

  name                = format("%s-bizevents-service-api", var.env_short)
  resource_group_name = local.pagopa_apim_rg
  api_management_name = local.pagopa_apim_name
  display_name        = local.apim_bizevents_service_api.display_name
  versioning_scheme   = "Segment"
}

resource "azurerm_api_management_api_version_set" "api_bizevents_helpdesk_api" {

  name                = format("%s-bizevents-helpdesk-api", var.env_short)
  resource_group_name = local.pagopa_apim_rg
  api_management_name = local.pagopa_apim_name
  display_name        = local.apim_bizevents_helpdesk_api.display_name
  versioning_scheme   = "Segment"
}

resource "azurerm_api_management_api_version_set" "api_bizevents_transactions_api" {

  name                = format("%s-bizevents-transaction-service-api", var.env_short)
  resource_group_name = local.pagopa_apim_rg
  api_management_name = local.pagopa_apim_name
  display_name        = local.apim_transaction_service_api.display_name
  versioning_scheme   = "Segment"
}


##############
## OpenApi  ##
##############

module "apim_api_bizevents_api_v1" {
  source = "git::https://github.com/pagopa/terraform-azurerm-v3.git//api_management_api?ref=v6.4.1"

  name                  = format("%s-bizevents-service-api", local.project)
  api_management_name   = local.pagopa_apim_name
  resource_group_name   = local.pagopa_apim_rg
  product_ids           = [module.apim_bizevents_product.product_id]
  subscription_required = local.apim_bizevents_service_api.subscription_required
  version_set_id        = azurerm_api_management_api_version_set.api_bizevents_api.id
  api_version           = "v1"

  description  = local.apim_bizevents_service_api.description
  display_name = local.apim_bizevents_service_api.display_name
  path         = local.apim_bizevents_service_api.path
  protocols    = ["https"]
  service_url  = local.apim_bizevents_service_api.service_url

  content_format = "openapi"
  content_value = templatefile("./api/bizevents-service/v1/_openapi.json.tpl", {
    host = local.apim_hostname
  })

  xml_content = templatefile("./api/bizevents-service/v1/_base_policy.xml", {
    hostname = local.bizevents_hostname
  })
}

module "apim_api_bizevents_helpdesk_api_v1" {
  source = "git::https://github.com/pagopa/terraform-azurerm-v3.git//api_management_api?ref=v6.4.1"

  name                  = format("%s-bizevents-helpdesk-api", local.project)
  api_management_name   = local.pagopa_apim_name
  resource_group_name   = local.pagopa_apim_rg
  product_ids           = [module.apim_bizevents_helpdesk_product.product_id]
  subscription_required = local.apim_bizevents_helpdesk_api.subscription_required
  version_set_id        = azurerm_api_management_api_version_set.api_bizevents_helpdesk_api.id
  api_version           = "v1"

  description  = local.apim_bizevents_helpdesk_api.description
  display_name = local.apim_bizevents_helpdesk_api.display_name
  path         = local.apim_bizevents_helpdesk_api.path
  protocols    = ["https"]
  service_url  = local.apim_bizevents_helpdesk_api.service_url

  content_format = "openapi"
  content_value = templatefile("./api/bizevents-helpdesk/v1/_openapi.json.tpl", {
    host = local.apim_hostname
  })

  xml_content = templatefile("./api/bizevents-helpdesk/v1/_base_policy.xml", {
    hostname = local.bizevents_hostname
  })
}

module "apim_api_bizevents_transactions_api_v1" {
  source = "git::https://github.com/pagopa/terraform-azurerm-v3.git//api_management_api?ref=v6.4.1"

  name                  = format("%s-bizevents-transaction-service-api", local.project)
  api_management_name   = local.pagopa_apim_name
  resource_group_name   = local.pagopa_apim_rg
  product_ids           = [module.apim_transactions_product.product_id]
  subscription_required = local.apim_transaction_service_api.subscription_required
  version_set_id        = azurerm_api_management_api_version_set.api_bizevents_transactions_api.id
  api_version           = "v1"

  description  = local.apim_transaction_service_api.description
  display_name = local.apim_transaction_service_api.display_name
  path         = local.apim_transaction_service_api.path
  protocols    = ["https"]
  service_url  = local.apim_transaction_service_api.service_url

  content_format = "openapi"
  content_value = templatefile("./api/transaction-service/v1/_openapi.json.tpl", {
    host = local.apim_hostname
  })

  xml_content = templatefile("./api/transaction-service/v1/_base_policy.xml", {
    hostname = local.bizevents_hostname
  })
}
