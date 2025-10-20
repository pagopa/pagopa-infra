#################################################
## Mock API session wallet token pagoPA for IO ##
#################################################
locals {
  apim_session_wallet_api_mock = {
    display_name          = "pagoPA - session wallet token pagoPA for IO APP - MOCK"
    description           = "API session wallet token pagoPA for IO APP - MOCK"
    path                  = "session-wallet/mock"
    subscription_required = false
    service_url           = null
    enabled               = var.env_short != "p" ? 1 : 0
  }
}

# Session wallet token service APIs
resource "azurerm_api_management_api_version_set" "session_wallet_api_mock" {
  count               = local.apim_session_wallet_api_mock.enabled
  name                = "${local.project}-session-wallet-api-mock"
  api_management_name = local.pagopa_apim_name
  resource_group_name = local.pagopa_apim_rg
  display_name        = local.apim_session_wallet_api_mock.display_name
  versioning_scheme   = "Segment"
}

resource "azurerm_api_management_api" "apim_session_wallet_api_mock" {
  count = local.apim_session_wallet_api_mock.enabled

  name                  = "${local.project}-session-wallet-api-mock"
  api_management_name   = local.pagopa_apim_name
  resource_group_name   = local.pagopa_apim_rg
  subscription_required = local.apim_session_wallet_api_mock.subscription_required
  version_set_id        = azurerm_api_management_api_version_set.session_wallet_api_mock[0].id
  version               = "v1"
  revision              = "1"

  description  = local.apim_session_wallet_api_mock.description
  display_name = local.apim_session_wallet_api_mock.display_name
  path         = local.apim_session_wallet_api_mock.path
  protocols    = ["https"]
  service_url  = local.apim_session_wallet_api_mock.service_url

  import {
    content_format = "openapi"
    content_value = templatefile("./api/session-wallet-mock/_openapi.json.tpl", {
      hostname = local.apim_hostname
    })
  }
}

resource "azurerm_api_management_api_policy" "apim_session_wallet_api_mock_policy" {
  count               = local.apim_session_wallet_api_mock.enabled
  api_name            = azurerm_api_management_api.apim_session_wallet_api_mock[0].name
  api_management_name = local.pagopa_apim_name
  resource_group_name = local.pagopa_apim_rg

  xml_content = templatefile("./api/session-wallet-mock/_base_policy.xml.tpl", {
    pdv_api_base_path    = var.pdv_api_base_path
  })
}
