#################################################
## API payment wallet for migration            ##
#################################################
locals {
  apim_payment_wallet_migrations_api = {
    display_name          = "pagoPA - payment wallet migrations API"
    description           = "API dedicated to migrate wallet from Payment Manager"
    path                  = "payment-wallet-migrations"
    subscription_required = true
    service_url           = null
  }
  apim_payment_wallet_migrations_for_cstar_api = {
    display_name          = "pagoPA - payment wallet migrations API for CSTAR"
    description           = "API dedicated to migrate wallet from Payment Manager"
    path                  = "payment-wallet-migrations-for-cstar"
    subscription_required = true
    service_url           = null
  }
}

# Payment wallet for migrations APIs
resource "azurerm_api_management_api_version_set" "payment_wallet_migrations_api" {
  count               = var.payment_wallet_migrations_enabled ? 1 : 0
  name                = "${local.project}-migrations-api"
  resource_group_name = local.pagopa_apim_rg
  api_management_name = local.pagopa_apim_name
  display_name        = local.apim_payment_wallet_migrations_api.display_name
  versioning_scheme   = "Segment"
}

module "apim_payment_wallet_migrations_api_v1" {
  count  = var.payment_wallet_migrations_enabled ? 1 : 0
  source = "git::https://github.com/pagopa/terraform-azurerm-v3.git//api_management_api?ref=v6.3.0"

  name                  = "${local.project}-migrations-api"
  api_management_name   = local.pagopa_apim_name
  resource_group_name   = local.pagopa_apim_rg
  product_ids           = [module.apim_payment_wallet_product.product_id]
  subscription_required = local.apim_payment_wallet_migrations_api.subscription_required
  version_set_id        = azurerm_api_management_api_version_set.payment_wallet_migrations_api[0].id
  api_version           = "v1"

  description  = local.apim_payment_wallet_migrations_api.description
  display_name = local.apim_payment_wallet_migrations_api.display_name
  path         = local.apim_payment_wallet_migrations_api.path
  protocols    = ["https"]
  service_url  = local.apim_payment_wallet_migrations_api.service_url

  content_format = "openapi"
  content_value = templatefile("./api/payment-wallet-migrations/v1/_openapi.json.tpl", {
    hostname = local.apim_hostname
  })

  xml_content = templatefile("./api/payment-wallet-migrations/v1/_base_policy.xml.tpl", {
    hostname = local.wallet_hostname
  })
}

module "apim_payment_wallet_migrations_for_cstar_api_v1" {
  count  = var.payment_wallet_migrations_enabled ? 1 : 0
  source = "git::https://github.com/pagopa/terraform-azurerm-v3.git//api_management_api?ref=v6.3.0"

  name                  = "${local.project}-migrations-for-cstar-api"
  api_management_name   = local.pagopa_apim_name
  resource_group_name   = local.pagopa_apim_rg
  product_ids           = [module.apim_payment_wallet_product.product_id]
  subscription_required = local.apim_payment_wallet_migrations_for_cstar_api.subscription_required
  version_set_id        = azurerm_api_management_api_version_set.payment_wallet_migrations_api[0].id
  api_version           = "v1"

  description  = local.apim_payment_wallet_migrations_for_cstar_api.description
  display_name = local.apim_payment_wallet_migrations_for_cstar_api.display_name
  path         = local.apim_payment_wallet_migrations_for_cstar_api.path
  protocols    = ["https"]
  service_url  = local.apim_payment_wallet_migrations_for_cstar_api.service_url

  content_format = "openapi"
  content_value = templatefile("./api/payment-wallet-migrations-for-cstar/v1/_openapi.json.tpl", {
    hostname = local.apim_hostname
  })

  xml_content = templatefile("./api/payment-wallet-migrations-for-cstar/v1/_base_policy.xml.tpl", {
    hostname = local.wallet_hostname
  })
}

resource "azurerm_api_management_api_operation_policy" "create_wallet_pm" {
  count = var.payment_wallet_migrations_enabled ? 1 : 0

  api_name            = module.apim_payment_wallet_migrations_api_v1[0].name
  resource_group_name = local.pagopa_apim_rg
  api_management_name = local.pagopa_apim_name
  operation_id        = "createWalletByPM"

  xml_content = templatefile("./api/payment-wallet-migrations/v1/_create_wallet_pm.xml.tpl", {
    pdv_api_base_path = var.pdv_api_base_path
    }
  )
}