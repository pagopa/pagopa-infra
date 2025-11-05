data "azurerm_key_vault_secret" "list_trx_for_io_api_key_secret" {
  name         = "list-trx-4-io-api-key"
  key_vault_id = data.azurerm_key_vault.kv.id
}

# data "azurerm_key_vault_secret" "list_trx_for_io_api_key_secret_apim_v2" {
#   name         = "list-trx-4-io-api-key"
#   key_vault_id = data.azurerm_key_vault.kv.id
# }

resource "azurerm_api_management_named_value" "list_trx_for_io_api_key_secret" {
  name                = "list-trx-for-io-api-key"
  api_management_name = local.pagopa_apim_name
  resource_group_name = local.pagopa_apim_rg
  display_name        = "list-trx-for-io-api-key"
  value               = data.azurerm_key_vault_secret.list_trx_for_io_api_key_secret.value
  secret              = true
}


#####################################
##    API Biz Events & Transaction ##
#####################################
locals {
  apim_bizevents_service_api = {
    // EC
    display_name          = "Biz Events Service"
    description           = "API to handle biz events payments"
    path                  = "bizevents/service"
    subscription_required = true
    service_url           = null
  }
  apim_bizevents_helpdesk_api = {
    // Helpdesk
    display_name          = "Biz Events Helpdesk"
    description           = "API for helpdesk on biz events payments"
    path                  = "bizevents/helpdesk"
    subscription_required = true
    service_url           = null
  }
  apim_transaction_service_api = {
    // AppIO
    display_name          = "Biz Events Transaction Service"
    description           = "API to handle biz events transactions"
    path                  = "bizevents/tx-service"
    subscription_required = true
    service_url           = null
  }
  apim_bizevents_nodo_sync_product = {
    // BizEvent-NdP synchronization - manual API
    display_name          = "Biz Events-NdP Sync"
    description           = "API to handle manual sync from NdP to Biz Events"
    path                  = "bizevents/nodo-sync"
    subscription_required = true
    service_url           = null
  }
}

##############
## Products ##
##############

module "apim_bizevents_product_all_in_one" {
  # only for test
  count  = var.env_short != "p" ? 1 : 0
  source = "./.terraform/modules/__v3__/api_management_product"

  product_id   = "bizevents-all-in-one"
  display_name = "bizevents-all-in-one"
  description  = "bizevents-all-in-one"

  api_management_name = local.pagopa_apim_name
  resource_group_name = local.pagopa_apim_rg

  published             = true
  subscription_required = true
  approval_required     = false
  subscriptions_limit   = 2

  policy_xml = file("./api_product/bizevents-service/_base_policy.xml")
}

// EC user(s)
module "apim_bizevents_product" {
  source = "./.terraform/modules/__v3__/api_management_product"

  product_id   = "bizevents"
  display_name = local.apim_bizevents_service_api.display_name
  description  = local.apim_bizevents_service_api.description

  api_management_name = local.pagopa_apim_name
  resource_group_name = local.pagopa_apim_rg

  published             = true
  subscription_required = local.apim_bizevents_service_api.subscription_required
  approval_required     = false
  subscriptions_limit   = 1000

  policy_xml = file("./api_product/bizevents-service/_base_policy.xml")
}

// Helpdesk
module "apim_bizevents_helpdesk_product" {
  source = "./.terraform/modules/__v3__/api_management_product"

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
  source = "./.terraform/modules/__v3__/api_management_product"

  product_id   = "bizevent-transactions"
  display_name = local.apim_transaction_service_api.display_name
  description  = local.apim_transaction_service_api.description

  api_management_name = local.pagopa_apim_name
  resource_group_name = local.pagopa_apim_rg

  published             = true
  subscription_required = local.apim_transaction_service_api.subscription_required
  approval_required     = true
  subscriptions_limit   = 1000

  policy_xml = file("./api_product/transaction-service/_base_policy.xml")
}

// BizEvent-NdP synchronization - manual API
module "apim_bizevents_nodo_sync_product" {
  source = "./.terraform/modules/__v3__/api_management_product"

  product_id   = "bizevents-nodo-sync"
  display_name = local.apim_bizevents_nodo_sync_product.display_name
  description  = local.apim_bizevents_nodo_sync_product.description

  api_management_name = local.pagopa_apim_name
  resource_group_name = local.pagopa_apim_rg

  published             = true
  subscription_required = local.apim_bizevents_nodo_sync_product.subscription_required
  approval_required     = true
  subscriptions_limit   = 1000

  policy_xml = file("./api_product/nodo-sync/_base_policy.xml")
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

resource "azurerm_api_management_api_version_set" "api_bizevents_transactions_jwt_api" {

  name                = format("%s-bizevents-transaction-service-api-jwt", var.env_short)
  resource_group_name = local.pagopa_apim_rg
  api_management_name = local.pagopa_apim_name
  display_name        = "${local.apim_transaction_service_api.display_name} JWT"
  versioning_scheme   = "Segment"
}


##############
## OpenApi  ##
##############

# #fetch technical support api product APIM product
# data "azurerm_api_management_product" "technical_support_api_product" {
#   product_id          = "technical_support_api"
#   api_management_name = local.pagopa_apim_name
#   resource_group_name = local.pagopa_apim_rg
# }

module "apim_api_bizevents_api_v1" {
  source = "./.terraform/modules/__v3__/api_management_api"

  name                = format("%s-bizevents-service-api", local.project)
  api_management_name = local.pagopa_apim_name
  resource_group_name = local.pagopa_apim_rg
  product_ids = var.env_short == "p" ? [
    module.apim_bizevents_product.product_id
    ] : [
    module.apim_bizevents_product.product_id,
    module.apim_bizevents_product_all_in_one[0].product_id
  ]
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
  source = "./.terraform/modules/__v3__/api_management_api"

  name                = format("%s-bizevents-helpdesk-api", local.project)
  api_management_name = local.pagopa_apim_name
  resource_group_name = local.pagopa_apim_rg
  product_ids = var.env_short == "p" ? [
    module.apim_bizevents_helpdesk_product.product_id,
    data.azurerm_api_management_product.technical_support_api_product.product_id
    ] : [
    module.apim_bizevents_helpdesk_product.product_id,
    module.apim_bizevents_product_all_in_one[0].product_id,
    data.azurerm_api_management_product.technical_support_api_product.product_id
  ]
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
  source = "./.terraform/modules/__v3__/api_management_api"

  name                = format("%s-bizevents-transaction-service-api", local.project)
  api_management_name = local.pagopa_apim_name
  resource_group_name = local.pagopa_apim_rg
  product_ids = var.env_short == "p" ? [
    module.apim_transactions_product.product_id, "technical_support_api"
    ] : [
    module.apim_transactions_product.product_id,
    module.apim_bizevents_product_all_in_one[0].product_id,
    "technical_support_api"
  ]
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
module "apim_api_bizevents_transactions_api_jwt_v1" {
  source = "./.terraform/modules/__v3__/api_management_api"

  name                = format("%s-bizevents-transaction-service-api-jwt", local.project)
  api_management_name = local.pagopa_apim_name
  resource_group_name = local.pagopa_apim_rg
  product_ids         = [module.apim_transactions_product.product_id]
  # subscription_required = local.apim_transaction_service_api.subscription_required
  subscription_required = false # use jwt
  version_set_id        = azurerm_api_management_api_version_set.api_bizevents_transactions_api.id
  api_version           = "v1"

  description  = "${local.apim_transaction_service_api.description} JWT"
  display_name = "${local.apim_transaction_service_api.display_name} JWT"
  path         = "${local.apim_transaction_service_api.path}-jwt"
  protocols    = ["https"]
  service_url  = local.apim_transaction_service_api.service_url

  content_format = "openapi"
  content_value = templatefile("./api/transaction-service/v1/_openapi-jwt.json.tpl", {
    host = local.apim_hostname
  })

  xml_content = templatefile("./api/transaction-service/v1/_base_policy-jwt.xml", {
    hostname          = local.bizevents_hostname
    pdv_api_base_path = var.pdv_api_base_path
  })
}


