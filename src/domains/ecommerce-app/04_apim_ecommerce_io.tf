data "azurerm_key_vault_secret" "personal_data_vault_api_key_secret" {
  name         = "personal-data-vault-api-key"
  key_vault_id = data.azurerm_key_vault.kv.id
}

resource "azurerm_api_management_named_value" "ecommerce-personal-data-vault-api-key" {
  name                = "ecommerce-personal-data-vault-api-key"
  api_management_name = local.pagopa_apim_name
  resource_group_name = local.pagopa_apim_rg
  display_name        = "ecommerce-personal-data-vault-api-key"
  value               = data.azurerm_key_vault_secret.personal_data_vault_api_key_secret.value
  secret              = true
}

data "azurerm_key_vault_secret" "ecommerce_io_jwt_signing_key" {
  name         = "ecommerce-io-jwt-signing-key"
  key_vault_id = data.azurerm_key_vault.kv.id
}

resource "azurerm_api_management_named_value" "ecommerce-io-jwt-signing-key" {
  name                = "ecommerce-io-jwt-signing-key"
  api_management_name = local.pagopa_apim_name
  resource_group_name = local.pagopa_apim_rg
  display_name        = "ecommerce-io-jwt-signing-key"
  value               = data.azurerm_key_vault_secret.ecommerce_io_jwt_signing_key.value
  secret              = true
}

##############
## Products ##
##############

module "apim_ecommerce_io_product" {
  source = "./.terraform/modules/__v3__/api_management_product"

  product_id   = "ecommerce-io"
  display_name = "eCommerce for IO App"
  description  = "eCommerce pagoPA product dedicated to IO App"

  api_management_name = local.pagopa_apim_name
  resource_group_name = local.pagopa_apim_rg

  published             = true
  subscription_required = true
  approval_required     = true
  subscriptions_limit   = 1000

  policy_xml = file("./api_product/_base_policy.xml")
}

# pagopa-ecommerce APIs for io
locals {
  apim_ecommerce_io_api = {
    display_name          = "eCommerce API for IO App"
    description           = "eCommerce pagoPA API dedicated to IO App for pagoPA payment"
    path                  = "ecommerce/io"
    subscription_required = false
    service_url           = null
  }

  apim_ecommerce_io_outcomes = {
    display_name          = "eCommerce API for app IO outcomes"
    description           = "API's exposed from eCommerce services to app IO to handle pagoPA payment outcomes"
    path                  = "ecommerce/io-outcomes"
    subscription_required = false
    service_url           = null
  }
}

resource "azurerm_api_management_api_version_set" "ecommerce_io_api_v1" {
  name                = "${local.project}-ecommerce-io-api"
  resource_group_name = local.pagopa_apim_rg
  api_management_name = local.pagopa_apim_name
  display_name        = local.apim_ecommerce_io_api.display_name
  versioning_scheme   = "Segment"
}

data "azurerm_key_vault_secret" "ecommerce_io_sessions_jwt_secret" {
  name         = "sessions-jwt-secret"
  key_vault_id = data.azurerm_key_vault.kv.id
}

resource "azurerm_api_management_named_value" "ecommerce_io_transaction_jwt_signing_key" {
  name                = "ecommerce-io-transaction-jwt-signing-key"
  api_management_name = local.pagopa_apim_name
  resource_group_name = local.pagopa_apim_rg
  display_name        = "ecommerce-io-transaction-jwt-signing-key"
  value               = data.azurerm_key_vault_secret.ecommerce_io_sessions_jwt_secret.value
  secret              = true
}

#################################################
## API eCommerce outcomes for App IO               ##
#################################################

resource "azurerm_api_management_api_version_set" "ecommerce_io_outcomes_api" {
  name                = "${local.project}-ecommerce-io-outcomes-api"
  resource_group_name = local.pagopa_apim_rg
  api_management_name = local.pagopa_apim_name
  display_name        = local.apim_ecommerce_io_outcomes.display_name
  versioning_scheme   = "Segment"
}

module "apim_ecommerce_io_outcomes_api_v1" {
  source = "./.terraform/modules/__v3__/api_management_api"

  name                  = "${local.project}-ecommerce-io-outcomes-api"
  api_management_name   = local.pagopa_apim_name
  resource_group_name   = local.pagopa_apim_rg
  product_ids           = [module.apim_ecommerce_io_product.product_id]
  subscription_required = local.apim_ecommerce_io_outcomes.subscription_required
  version_set_id        = azurerm_api_management_api_version_set.ecommerce_io_outcomes_api.id
  api_version           = "v1"

  description  = local.apim_ecommerce_io_outcomes.description
  display_name = local.apim_ecommerce_io_outcomes.display_name
  path         = local.apim_ecommerce_io_outcomes.path
  protocols    = ["https"]
  service_url  = local.apim_ecommerce_io_outcomes.service_url

  content_format = "openapi"
  content_value = templatefile("./api/ecommerce-io-outcomes/v1/_openapi.json.tpl", {
    hostname = local.apim_hostname
  })

  xml_content = file("./api/ecommerce-io-outcomes/v1/_base_policy.xml.tpl")
}


###########################
###                     ###
### ECOMMERCE IO V2     ###
###                     ###
###########################

module "apim_ecommerce_io_api_v2" {
  source = "./.terraform/modules/__v3__/api_management_api"

  name                  = "${local.project}-ecommerce-io-api"
  resource_group_name   = local.pagopa_apim_rg
  api_management_name   = local.pagopa_apim_name
  product_ids           = [module.apim_ecommerce_io_product.product_id]
  subscription_required = local.apim_ecommerce_io_api.subscription_required
  version_set_id        = azurerm_api_management_api_version_set.ecommerce_io_api_v1.id
  api_version           = "v2"
  service_url           = local.apim_ecommerce_io_api.service_url

  description  = local.apim_ecommerce_io_api.description
  display_name = local.apim_ecommerce_io_api.display_name
  path         = local.apim_ecommerce_io_api.path
  protocols    = ["https"]

  content_format = "openapi"
  content_value = templatefile("./api/ecommerce-io/v2/_openapi.json.tpl", {
    host = local.apim_hostname
  })

  xml_content = templatefile("./api/ecommerce-io/v2/_base_policy.xml.tpl", {
    ecommerce_ingress_hostname = local.ecommerce_hostname
    wallet_ingress_hostname    = local.wallet_hostname
  })
}

resource "azurerm_api_management_api_operation_policy" "io_post_wallet_transactions_v2" {
  api_name            = "${local.project}-ecommerce-io-api-v2"
  resource_group_name = local.pagopa_apim_rg
  api_management_name = local.pagopa_apim_name
  operation_id        = "createWalletForTransactionsForIO"

  xml_content = templatefile("./api/ecommerce-io/v2/_wallet_transactions.xml.tpl", {
    wallet-basepath = local.wallet_hostname
  })
}

resource "azurerm_api_management_api_operation_policy" "io_transaction_authorization_request_v2" {
  api_name            = "${local.project}-ecommerce-io-api-v2"
  resource_group_name = local.pagopa_apim_rg
  api_management_name = local.pagopa_apim_name
  operation_id        = "requestTransactionAuthorizationForIO"

  xml_content = templatefile("./api/ecommerce-io/v2/_auth_request.xml.tpl", {
    authurl-basepath = var.env_short == "d" ? local.apim_hostname : "{{wisp2-gov-it}}"
    wallet-basepath  = local.wallet_hostname
  })
}

resource "azurerm_api_management_api_operation_policy" "io_calculate_fee_v2" {
  api_name            = "${local.project}-ecommerce-io-api-v2"
  resource_group_name = local.pagopa_apim_rg
  api_management_name = local.pagopa_apim_name
  operation_id        = "calculateFeesForIO"

  xml_content = templatefile("./api/ecommerce-io/v2/_calculate_fees_policy.xml.tpl",
    {
      ecommerce-basepath = local.ecommerce_hostname
      wallet-basepath    = local.wallet_hostname
    }
  )
}

resource "azurerm_api_management_api_operation_policy" "create_transactions_v2" {
  api_name            = "${local.project}-ecommerce-io-api-v2"
  resource_group_name = local.pagopa_apim_rg
  api_management_name = local.pagopa_apim_name
  operation_id        = "newTransactionForIO"

  xml_content = templatefile("./api/ecommerce-io/v2/post_transactions.xml.tpl", {
    ecommerce_ingress_hostname = local.ecommerce_hostname
  })
}
