############################
# Cloned by 04_apim_io_wallet_session.tf
# Temp configuration for apimV2
# According to finish https://pagopa.atlassian.net/browse/DIS-44
############################

data "azurerm_key_vault_secret" "personal_data_vault_api_key_secret_apim_v2" {
  name         = "personal-data-vault-api-key-wallet-session"
  key_vault_id = data.azurerm_key_vault.kv.id
}

resource "azurerm_api_management_named_value" "wallet_personal_data_vault_api_key_apim_v2" {
  count = var.env_short == "p" ? 1 : 0 # only PROD and only for version V2 

  name                = "wallet-session-personal-data-vault-api-key"
  api_management_name = local.pagopa_apim_v2_name
  resource_group_name = local.pagopa_apim_rg
  display_name        = "wallet-session-personal-data-vault-api-key"
  value               = data.azurerm_key_vault_secret.personal_data_vault_api_key_secret_apim_v2.value
  secret              = true
}

data "azurerm_key_vault_secret" "wallet_jwt_signing_key_secret_apim_v2" {
  name         = "pagopa-wallet-session-jwt-signature-key-private-key"
  key_vault_id = data.azurerm_key_vault.kv.id
}

resource "azurerm_api_management_named_value" "pagopa-wallet-jwt-signing-key_apim_v2_apim_v2" {
  count = var.env_short == "p" ? 1 : 0 # only PROD and only for version V2 

  name                = "pagopa-wallet-session-jwt-signing-key"
  api_management_name = local.pagopa_apim_v2_name
  resource_group_name = local.pagopa_apim_rg
  display_name        = "pagopa-wallet-session-jwt-signing-key"
  value               = replace(trim(trim(trimspace(data.azurerm_key_vault_secret.wallet_jwt_signing_key_secret_apim_v2.value), "-----BEGIN RSA PRIVATE KEY-----"), "-----END RSA PRIVATE KEY-----"), "\n", "")
  secret              = true
}

## DEPRECATED TO REMOVE use 👆👆
resource "azurerm_api_management_named_value" "wallet-jwt-signing-key_apim_v2" {
  count = var.env_short == "p" ? 1 : 0 # only PROD and only for version V2 

  name                = "wallet-session-jwt-signing-key"
  api_management_name = local.pagopa_apim_v2_name
  resource_group_name = local.pagopa_apim_rg
  display_name        = "wallet-session-jwt-signing-key"
  value               = replace(trim(trim(trimspace(data.azurerm_key_vault_secret.wallet_jwt_signing_key_secret_apim_v2.value), "-----BEGIN RSA PRIVATE KEY-----"), "-----END RSA PRIVATE KEY-----"), "\n", "")
  secret              = true
}

##########################################
## Products session wallet token pagoPA ##
##########################################

module "apim_session_wallet_product_apim_v2" {
  count = var.env_short == "p" ? 1 : 0 # only PROD and only for version V2 

  source = "git::https://github.com/pagopa/terraform-azurerm-v3.git//api_management_product?ref=v6.3.0"

  product_id   = "session-wallet-token"
  display_name = "session wallet token pagoPA"
  description  = "Product session wallet token pagoPA"

  api_management_name = local.pagopa_apim_v2_name
  resource_group_name = local.pagopa_apim_rg

  published             = true
  subscription_required = true
  approval_required     = true
  subscriptions_limit   = 1000

  policy_xml = file("./api_product/session-wallet/_base_policy.xml")
}

#################################################
## API session wallet token pagoPA for IO      ##
#################################################
resource "azurerm_api_management_named_value" "ecommerce_io_pm_enabled_apim_v2" {
  count = var.env_short == "p" ? 1 : 0 # only PROD and only for version V2   

  name                = "enable-pm-ecommerce-io"
  api_management_name = local.pagopa_apim_v2_name
  resource_group_name = local.pagopa_apim_rg
  display_name        = "enable-pm-ecommerce-io"
  value               = var.ecommerce_io_pm_enabled
}

locals {
  apim_session_wallet_api_apim_v2 = {
    display_name          = "pagoPA - session wallet token pagoPA for IO APP"
    description           = "API session wallet token pagoPA for IO APP"
    path                  = "session-wallet"
    subscription_required = false
    service_url           = null
  }
}

# Session wallet token service APIs
resource "azurerm_api_management_api_version_set" "session_wallet_api_apim_v2" {
  count = var.env_short == "p" ? 1 : 0 # only PROD and only for version V2   

  name                = "${local.project}-session-wallet-api"
  api_management_name = local.pagopa_apim_v2_name
  resource_group_name = local.pagopa_apim_rg
  display_name        = local.apim_session_wallet_api_apim_v2.display_name
  versioning_scheme   = "Segment"
}

module "apim_session_wallet_api_v1_apim_v2" {
  source = "git::https://github.com/pagopa/terraform-azurerm-v3.git//api_management_api?ref=v6.3.0"

  count = var.env_short == "p" ? 1 : 0 # only PROD and only for version V2   

  name                  = "${local.project}-session-wallet-api"
  api_management_name   = local.pagopa_apim_v2_name
  resource_group_name   = local.pagopa_apim_rg
  product_ids           = [module.apim_session_wallet_product_apim_v2[0].product_id]
  subscription_required = local.apim_session_wallet_api_apim_v2.subscription_required
  version_set_id        = azurerm_api_management_api_version_set.session_wallet_api_apim_v2[0].id
  api_version           = "v1"

  description  = local.apim_session_wallet_api_apim_v2.description
  display_name = local.apim_session_wallet_api_apim_v2.display_name
  path         = local.apim_session_wallet_api_apim_v2.path
  protocols    = ["https"]
  service_url  = local.apim_session_wallet_api_apim_v2.service_url

  content_format = "openapi"
  content_value = templatefile("./api/session-wallet/v1/_openapi.json.tpl", {
    hostname = local.apim_hostname
  })

  xml_content = templatefile("./api/session-wallet/v1/_base_policy.xml.tpl", {
    hostname             = null
    io_backend_base_path = var.io_backend_base_path
    pdv_api_base_path    = var.pdv_api_base_path
  })
}

#######################################################################
## Fragment policy to chk JWT session wallet token pagoPA for IO     ##
#######################################################################

resource "azapi_resource" "fragment_chk_jwt_session_token_apim_v2" {
  count = var.env_short == "p" ? 1 : 0 # only PROD and only for version V2 

  depends_on = [azurerm_api_management_named_value.wallet-jwt-signing-key_apim_v2]

  # provider  = azapi.apim
  type      = "Microsoft.ApiManagement/service/policyFragments@2022-04-01-preview"
  name      = "jwt-chk-wallet-session"
  parent_id = data.azurerm_api_management.apim.id

  body = jsonencode({
    properties = {
      description = "Component that permits to check JWT session wallet token pagoPA for IO"
      format      = "rawxml"
      value = templatefile("./api/session-wallet/v1/_fragment_policiy_chk_jwt.tpl.xml", {
      })

    }
  })

  lifecycle {
    ignore_changes = [output]
  }

}

resource "azapi_resource" "fragment_jwt_session_token_apim_v2" {
  count = var.env_short == "p" ? 1 : 0 # only PROD and only for version V2 

  depends_on = [azurerm_api_management_named_value.wallet-jwt-signing-key_apim_v2]

  # provider  = azapi.apim
  type      = "Microsoft.ApiManagement/service/policyFragments@2022-04-01-preview"
  name      = "jwt-chk-wallet-session"
  parent_id = data.azurerm_api_management.apim_v2.id

  body = jsonencode({
    properties = {
      description = "Component that permits to check JWT session wallet token pagoPA for IO"
      format      = "rawxml"
      value = templatefile("./api/session-wallet/v1/_fragment_policiy_chk_jwt.tpl.xml", {
      })

    }
  })

  lifecycle {
    ignore_changes = [output]
  }

}

#######################################################################
## Fragment policy to chk PM token pagoPA for IO                     ##
#######################################################################

resource "azapi_resource" "fragment_chk_pm_session_token_apim_v2" {
  count = var.env_short == "p" ? 1 : 0 # only PROD and only for version V2   

  # provider  = azapi.apim
  type      = "Microsoft.ApiManagement/service/policyFragments@2022-04-01-preview"
  name      = "pm-chk-wallet-session"
  parent_id = data.azurerm_api_management.apim.id

  body = jsonencode({
    properties = {
      description = "Component that permits to check PM session wallet token pagoPA for IO"
      format      = "rawxml"
      value = templatefile("./api/session-wallet/v1/_fragment_policiy_chk_token.tpl.xml", {
      })

    }
  })

  lifecycle {
    ignore_changes = [output]
  }
}

resource "azapi_resource" "fragment_pm_session_token_apim_v2" {
  count = var.env_short == "p" ? 1 : 0 # only PROD and only for version V2   

  # provider  = azapi.apim
  type      = "Microsoft.ApiManagement/service/policyFragments@2022-04-01-preview"
  name      = "pm-chk-wallet-session"
  parent_id = data.azurerm_api_management.apim_v2.id

  body = jsonencode({
    properties = {
      description = "Component that permits to check PM session wallet token pagoPA for IO"
      format      = "rawxml"
      value = templatefile("./api/session-wallet/v1/_fragment_policiy_chk_token.tpl.xml", {
      })

    }
  })

  lifecycle {
    ignore_changes = [output]
  }
}