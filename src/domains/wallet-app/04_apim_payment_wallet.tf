##############
## Groups ##
##############

resource "azurerm_api_management_group" "payment-wallet" {
  name                = "payment-wallet"
  resource_group_name = local.pagopa_apim_rg
  api_management_name = local.pagopa_apim_name
  display_name        = "Payment Wallet"
}

##############
## Products ##
##############

module "apim_payment_wallet_product" {
  source = "git::https://github.com/pagopa/terraform-azurerm-v3.git//api_management_product?ref=v6.3.0"

  product_id   = "payment-wallet"
  display_name = "payment wallet pagoPA"
  description  = "Product for payment wallet pagoPA"

  api_management_name = local.pagopa_apim_name
  resource_group_name = local.pagopa_apim_rg

  published             = true
  subscription_required = true
  approval_required     = true
  subscriptions_limit   = 1000

  policy_xml = file("./api_product/_base_policy.xml")
}

#################################################
## API payment wallet for IO                   ##
#################################################
locals {
  apim_payment_wallet_api = {
    display_name          = "pagoPA - payment wallet API for IO APP"
    description           = "API to support payment wallet for IO APP"
    path                  = "payment-wallet"
    subscription_required = false
    service_url           = null
  }
}

# Payment wallet service APIs
resource "azurerm_api_management_api_version_set" "payment_wallet_api" {
  name                = "${local.project}-payment-wallet-api"
  resource_group_name = local.pagopa_apim_rg
  api_management_name = local.pagopa_apim_name
  display_name        = local.apim_payment_wallet_api.display_name
  versioning_scheme   = "Segment"
}

module "apim_payment_wallet_api_v1" {
  source = "git::https://github.com/pagopa/terraform-azurerm-v3.git//api_management_api?ref=v6.3.0"

  name                  = "${local.project}-payment-wallet-api"
  api_management_name   = local.pagopa_apim_name
  resource_group_name   = local.pagopa_apim_rg
  product_ids           = [module.apim_payment_wallet_product.product_id]
  subscription_required = local.apim_payment_wallet_api.subscription_required
  version_set_id        = azurerm_api_management_api_version_set.payment_wallet_api.id
  api_version           = "v1"

  description  = local.apim_payment_wallet_api.description
  display_name = local.apim_payment_wallet_api.display_name
  path         = local.apim_payment_wallet_api.path
  protocols    = ["https"]
  service_url  = local.apim_payment_wallet_api.service_url

  content_format = "openapi"
  content_value = templatefile("./api/payment-wallet/v1/_openapi.json.tpl", {
    hostname = local.apim_hostname
  })

  xml_content = templatefile("./api/payment-wallet/v1/_base_policy.xml.tpl", {
    hostname = local.wallet_hostname
  })
}

resource "azurerm_api_management_api_operation_policy" "get_wallets_for_user" {
  api_name            = "${local.project}-payment-wallet-api-v1"
  resource_group_name = local.pagopa_apim_rg
  api_management_name = local.pagopa_apim_name
  operation_id        = "getWalletsByIdUser"

  xml_content = var.payment_wallet_with_pm_enabled ? templatefile("./api/payment-wallet/v1/_get_wallets_by_user_with_pm.xml.tpl", {
    ecommerce-basepath = local.ecommerce_hostname
  }) : templatefile("./api/payment-wallet/v1/_get_wallets_by_user.xml.tpl", { pdv_api_base_path = var.pdv_api_base_path, io_backend_base_path = var.io_backend_base_path })

}

resource "azurerm_api_management_api_operation_policy" "get_wallet_for_user_and_id" {
  api_name            = "${local.project}-payment-wallet-api-v1"
  resource_group_name = local.pagopa_apim_rg
  api_management_name = local.pagopa_apim_name
  operation_id        = "getWalletById"

  xml_content = var.payment_wallet_with_pm_enabled ? templatefile("./api/payment-wallet/v1/_get_wallets_by_user_and_walletId_with_pm.xml.tpl", {
    ecommerce-basepath = local.ecommerce_hostname
  }) : templatefile("./api/payment-wallet/v1/_get_wallets_by_user_and_walletId.xml.tpl", { pdv_api_base_path = var.pdv_api_base_path, io_backend_base_path = var.io_backend_base_path })

}

resource "azurerm_api_management_api_operation_policy" "post_wallets" {
  api_name            = "${local.project}-payment-wallet-api-v1"
  resource_group_name = local.pagopa_apim_rg
  api_management_name = local.pagopa_apim_name
  operation_id        = "createWallet"

  xml_content = var.payment_wallet_with_pm_enabled ? templatefile("./api/payment-wallet/v1/_post_wallets_with_pm_policy.xml.tpl", {
    env                = var.env,
    ecommerce-basepath = local.ecommerce_hostname
    }) : templatefile("./api/payment-wallet/v1/_post_wallets_policy.xml.tpl", {
    env = var.env, pdv_api_base_path = var.pdv_api_base_path, io_backend_base_path = var.io_backend_base_path
  })
}

resource "azurerm_api_management_api_operation_policy" "get_payment_methods" {
  api_name            = "${local.project}-payment-wallet-api-v1"
  resource_group_name = local.pagopa_apim_rg
  api_management_name = local.pagopa_apim_name
  operation_id        = "getAllPaymentMethods"

  xml_content = templatefile("./api/payment-wallet/v1/_get_payment_methods_policy.xml.tpl", { ecommerce_hostname = local.ecommerce_hostname }
  )
}

#################################################
## API wallet notifications service            ##
#################################################
locals {
  apim_payment_wallet_notifications_service_api = {
    display_name          = "wallet pagoPA - NPG notifications API"
    description           = "API to support npg notifications related to onboarding"
    path                  = "payment-wallet-notifications"
    subscription_required = false
    service_url           = null
  }
}

# NPG notifications service APIs
resource "azurerm_api_management_api_version_set" "npg_notifications_api" {
  name                = "${local.project}-npg-notifications-api"
  resource_group_name = local.pagopa_apim_rg
  api_management_name = local.pagopa_apim_name
  display_name        = local.apim_payment_wallet_notifications_service_api.display_name
  versioning_scheme   = "Segment"
}

module "apim_wallet_service_notifications_api_v1" {
  source = "git::https://github.com/pagopa/terraform-azurerm-v3.git//api_management_api?ref=v6.3.0"

  name                  = "${local.project}-notifications-service-api"
  api_management_name   = local.pagopa_apim_name
  resource_group_name   = local.pagopa_apim_rg
  product_ids           = [module.apim_payment_wallet_product.product_id]
  subscription_required = local.apim_payment_wallet_notifications_service_api.subscription_required
  version_set_id        = azurerm_api_management_api_version_set.npg_notifications_api.id
  api_version           = "v1"

  description  = local.apim_payment_wallet_notifications_service_api.description
  display_name = local.apim_payment_wallet_notifications_service_api.display_name
  path         = local.apim_payment_wallet_notifications_service_api.path
  protocols    = ["https"]
  service_url  = local.apim_payment_wallet_notifications_service_api.service_url

  content_format = "openapi"
  content_value = templatefile("./api/npg-notifications/v1/_openapi.json.tpl", {
    hostname = local.apim_hostname
  })

  xml_content = templatefile("./api/npg-notifications/v1/_base_policy.xml.tpl", {
    hostname = local.wallet_hostname
  })
}

resource "azurerm_api_management_api_operation_policy" "notify_wallet" {
  api_name            = module.apim_wallet_service_notifications_api_v1.name
  resource_group_name = local.pagopa_apim_rg
  api_management_name = local.pagopa_apim_name
  operation_id        = "notifyWallet"

  xml_content = templatefile("./api/npg-notifications/v1/_wallets_policy.xml.tpl", {
    hostname = local.wallet_hostname
  })
}

resource "azurerm_api_management_api_operation_policy" "notify_transaction_wallet" {
  api_name            = module.apim_wallet_service_notifications_api_v1.name
  resource_group_name = local.pagopa_apim_rg
  api_management_name = local.pagopa_apim_name
  operation_id        = "notifyTransactionWallet"

  xml_content = templatefile("./api/npg-notifications/v1/_transactions_wallets_base_policy.xml.tpl", {
    hostname = local.wallet_hostname
  })
}

#################################################
## API wallet service for Webview                   ##
#################################################
locals {
  apim_webview_payment_wallet_api = {
    display_name          = "pagoPA - wallet API for webview"
    description           = "API to support payment wallet for webview"
    path                  = "webview-payment-wallet"
    subscription_required = false
    service_url           = null
  }
}

# Wallet service APIs
resource "azurerm_api_management_api_version_set" "wallet_webview_api" {
  name                = format("%s-webview-api", local.project)
  resource_group_name = local.pagopa_apim_rg
  api_management_name = local.pagopa_apim_name
  display_name        = local.apim_webview_payment_wallet_api.display_name
  versioning_scheme   = "Segment"
}

module "apim_webview_payment_wallet_api_v1" {
  source = "git::https://github.com/pagopa/terraform-azurerm-v3.git//api_management_api?ref=v6.3.0"

  name                  = "${local.project}-webview-api"
  api_management_name   = local.pagopa_apim_name
  resource_group_name   = local.pagopa_apim_rg
  product_ids           = [module.apim_payment_wallet_product.product_id]
  subscription_required = local.apim_webview_payment_wallet_api.subscription_required
  version_set_id        = azurerm_api_management_api_version_set.wallet_webview_api.id
  api_version           = "v1"

  description  = local.apim_webview_payment_wallet_api.description
  display_name = local.apim_webview_payment_wallet_api.display_name
  path         = local.apim_webview_payment_wallet_api.path
  protocols    = ["https"]
  service_url  = local.apim_webview_payment_wallet_api.service_url

  content_format = "openapi"
  content_value = templatefile("./api/webview-payment-wallet/v1/_openapi.json.tpl", {
    hostname = local.apim_hostname
  })

  xml_content = templatefile("./api/webview-payment-wallet/v1/_base_policy.xml.tpl", {
    hostname              = local.wallet_hostname
    payment_wallet_origin = "https://${var.dns_zone_prefix}.${var.external_domain}/"
  })
}

data "azurerm_key_vault_secret" "personal_data_vault_api_key_secret" {
  name         = "personal-data-vault-api-key"
  key_vault_id = data.azurerm_key_vault.kv.id
}

resource "azurerm_api_management_named_value" "personal-data-vault-api-key" {
  name                = "personal-data-vault-api-key"
  api_management_name = local.pagopa_apim_name
  resource_group_name = local.pagopa_apim_rg
  display_name        = "personal-data-vault-api-key"
  value               = data.azurerm_key_vault_secret.personal_data_vault_api_key_secret.value
  secret              = true
}

data "azurerm_key_vault_secret" "wallet_jwt_signing_key_secret" {
  name         = "wallet-jwt-signing-key"
  key_vault_id = data.azurerm_key_vault.kv.id
}

resource "azurerm_api_management_named_value" "wallet-jwt-signing-key" {
  name                = "wallet-jwt-signing-key"
  api_management_name = local.pagopa_apim_name
  resource_group_name = local.pagopa_apim_rg
  display_name        = "wallet-jwt-signing-key"
  value               = data.azurerm_key_vault_secret.wallet_jwt_signing_key_secret.value
  secret              = true
}

resource "azurerm_api_management_api_operation_policy" "get_psps_for_wallet" {
  api_name            = module.apim_webview_payment_wallet_api_v1.name
  resource_group_name = local.pagopa_apim_rg
  api_management_name = local.pagopa_apim_name
  operation_id        = "getPspsForWallet"

  xml_content = templatefile("./api/webview-payment-wallet/v1/get_psps_policy.xml.tpl", {
    payment_wallet_origin = "https://${var.dns_zone_prefix}.${var.external_domain}/"
    gec_hostname          = var.env_short == "p" ? "weuprod.afm.internal.platform.pagopa.it" : "weu${var.env}.afm.internal.${var.env}.platform.pagopa.it"
    ecommerce_hostname    = local.ecommerce_hostname
    wallet_hostname       = local.wallet_hostname
  })
}

#################################################
## API wallet outcomes for App IO               ##
#################################################
locals {
  apim_payment_wallet_outcomes_api = {
    display_name          = "pagoPA - wallet outcomes API for IO"
    description           = "API to support payment wallet outcomes handling for IO"
    path                  = "payment-wallet-outcomes"
    subscription_required = false
    service_url           = null
  }
}

# Wallet service APIs
resource "azurerm_api_management_api_version_set" "wallet_outcomes_api" {
  name                = format("%s-outcomes-api", local.project)
  resource_group_name = local.pagopa_apim_rg
  api_management_name = local.pagopa_apim_name
  display_name        = local.apim_payment_wallet_outcomes_api.display_name
  versioning_scheme   = "Segment"
}

module "apim_payment_wallet_outcomes_api_v1" {
  source = "git::https://github.com/pagopa/terraform-azurerm-v3.git//api_management_api?ref=v6.3.0"

  name                  = "${local.project}-outcomes-api"
  api_management_name   = local.pagopa_apim_name
  resource_group_name   = local.pagopa_apim_rg
  product_ids           = [module.apim_payment_wallet_product.product_id]
  subscription_required = local.apim_payment_wallet_outcomes_api.subscription_required
  version_set_id        = azurerm_api_management_api_version_set.wallet_outcomes_api.id
  api_version           = "v1"

  description  = local.apim_payment_wallet_outcomes_api.description
  display_name = local.apim_payment_wallet_outcomes_api.display_name
  path         = local.apim_payment_wallet_outcomes_api.path
  protocols    = ["https"]
  service_url  = local.apim_payment_wallet_outcomes_api.service_url

  content_format = "openapi"
  content_value = templatefile("./api/payment-wallet-outcomes-for-io/v1/_openapi.json.tpl", {
    hostname = local.apim_hostname
  })

  xml_content = file("./api/payment-wallet-outcomes-for-io/v1/_base_policy.xml.tpl")
}

