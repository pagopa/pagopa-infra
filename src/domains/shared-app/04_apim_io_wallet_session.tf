data "azurerm_key_vault_secret" "personal_data_vault_api_key_secret" {
  name         = "personal-data-vault-api-key-wallet-session"
  key_vault_id = data.azurerm_key_vault.kv.id
}

resource "azurerm_api_management_named_value" "wallet_personal_data_vault_api_key" {
  name                = "wallet-session-personal-data-vault-api-key"
  api_management_name = local.pagopa_apim_name
  resource_group_name = local.pagopa_apim_rg
  display_name        = "wallet-session-personal-data-vault-api-key"
  value               = data.azurerm_key_vault_secret.personal_data_vault_api_key_secret.value
  secret              = true
}

data "azurerm_key_vault_secret" "wallet_jwt_signing_key_secret" {
  name         = "pagopa-wallet-session-jwt-signature-key-private-key"
  key_vault_id = data.azurerm_key_vault.kv.id
}

resource "azurerm_api_management_named_value" "pagopa-wallet-jwt-signing-key" {
  name                = "pagopa-wallet-session-jwt-signing-key"
  api_management_name = local.pagopa_apim_name
  resource_group_name = local.pagopa_apim_rg
  display_name        = "pagopa-wallet-session-jwt-signing-key"
  value               = replace(trim(trim(trimspace(data.azurerm_key_vault_secret.wallet_jwt_signing_key_secret.value), "-----BEGIN RSA PRIVATE KEY-----"), "-----END RSA PRIVATE KEY-----"), "\n", "")
  secret              = true
}

## DEPRECATED TO REMOVE use 👆👆
resource "azurerm_api_management_named_value" "wallet-jwt-signing-key" {
  name                = "wallet-session-jwt-signing-key"
  api_management_name = local.pagopa_apim_name
  resource_group_name = local.pagopa_apim_rg
  display_name        = "wallet-session-jwt-signing-key"
  value               = replace(trim(trim(trimspace(data.azurerm_key_vault_secret.wallet_jwt_signing_key_secret.value), "-----BEGIN RSA PRIVATE KEY-----"), "-----END RSA PRIVATE KEY-----"), "\n", "")
  secret              = true
}

##########################################
## Products session wallet token pagoPA ##
##########################################

module "apim_session_wallet_product" {
  source = "./.terraform/modules/__v3__/api_management_product"

  product_id   = "session-wallet-token"
  display_name = "session wallet token pagoPA"
  description  = "Product session wallet token pagoPA"

  api_management_name = local.pagopa_apim_name
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


locals {
  apim_session_wallet_api = {
    display_name          = "pagoPA - session wallet token pagoPA for IO APP"
    description           = "API session wallet token pagoPA for IO APP"
    path                  = "session-wallet"
    subscription_required = false
    service_url           = null
  }
}

# Session wallet token service APIs
resource "azurerm_api_management_api_version_set" "session_wallet_api" {
  name                = "${local.project}-session-wallet-api"
  api_management_name = local.pagopa_apim_name
  resource_group_name = local.pagopa_apim_rg
  display_name        = local.apim_session_wallet_api.display_name
  versioning_scheme   = "Segment"
}

module "apim_session_wallet_api_v1" {
  source = "./.terraform/modules/__v3__/api_management_api"

  name                  = "${local.project}-session-wallet-api"
  api_management_name   = local.pagopa_apim_name
  resource_group_name   = local.pagopa_apim_rg
  product_ids           = [module.apim_session_wallet_product.product_id]
  subscription_required = local.apim_session_wallet_api.subscription_required
  version_set_id        = azurerm_api_management_api_version_set.session_wallet_api.id
  api_version           = "v1"

  description  = local.apim_session_wallet_api.description
  display_name = local.apim_session_wallet_api.display_name
  path         = local.apim_session_wallet_api.path
  protocols    = ["https"]
  service_url  = local.apim_session_wallet_api.service_url

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

resource "terraform_data" "sha256_fragment_chk_jwt_session_token" {
  input = sha256(file("./api/session-wallet/v1/_fragment_policiy_chk_jwt.tpl.xml"))
}

resource "azapi_resource" "fragment_chk_jwt_session_token" {
  depends_on = [azurerm_api_management_named_value.wallet-jwt-signing-key, terraform_data.sha256_fragment_chk_jwt_session_token]

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
    # replace_triggered_by = [ terraform_data.sha256_fragment_chk_jwt_session_token.output ]
  }

}
