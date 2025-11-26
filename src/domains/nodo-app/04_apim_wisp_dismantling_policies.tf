#################
## Named Value ##
#################
resource "azurerm_api_management_named_value" "enable_wisp_dismantling_switch_named_value" {
  name                = "enable-wisp-dismantling-switch"
  api_management_name = local.pagopa_apim_name
  resource_group_name = local.pagopa_apim_rg
  display_name        = "enable-wisp-dismantling-switch"
  value               = var.create_wisp_converter && var.wisp_converter.enable_apim_switch
}

resource "azurerm_api_management_named_value" "wisp_brokerPSP_whitelist_named_value" {
  name                = "wisp-brokerPSP-whitelist"
  api_management_name = local.pagopa_apim_name
  resource_group_name = local.pagopa_apim_rg
  display_name        = "wisp-brokerPSP-whitelist"
  value               = var.wisp_converter.brokerPSP_whitelist
}

resource "azurerm_api_management_named_value" "wisp_channel_whitelist_named_value" {
  name                = "wisp-channel-whitelist"
  api_management_name = local.pagopa_apim_name
  resource_group_name = local.pagopa_apim_rg
  display_name        = "wisp-channel-whitelist"
  value               = var.wisp_converter.channel_whitelist
}

resource "azurerm_api_management_named_value" "wisp_nodoinviarpt_paymenttype_whitelist_named_value" {
  name                = "wisp-nodoinviarpt-paymenttype-whitelist"
  api_management_name = local.pagopa_apim_name
  resource_group_name = local.pagopa_apim_rg
  display_name        = "wisp-nodoinviarpt-paymenttype-whitelist"
  value               = var.wisp_converter.nodoinviarpt_paymenttype_whitelist
}

resource "azurerm_api_management_named_value" "wisp_dismantling_primitives" {
  name                = "wisp-dismantling-primitives"
  api_management_name = local.pagopa_apim_name
  resource_group_name = local.pagopa_apim_rg
  display_name        = "wisp-dismantling-primitives"
  value               = var.wisp_converter.dismantling_primitives
}

resource "azurerm_api_management_named_value" "wisp_dismantling_rt_primitives" {
  name                = "wisp-dismantling-rt-primitives"
  api_management_name = local.pagopa_apim_name
  resource_group_name = local.pagopa_apim_rg
  display_name        = "wisp-dismantling-rt-primitives"
  value               = var.wisp_converter.dismantling_rt_primitives
}

resource "azurerm_api_management_named_value" "wisp_dismantling_backend_url" {
  name                = "wisp-dismantling-backend-url"
  api_management_name = local.pagopa_apim_name
  resource_group_name = local.pagopa_apim_rg
  display_name        = "wisp-dismantling-backend-url"
  value               = "https://${local.nodo_hostname}/wisp-soapconverter"
}

resource "azurerm_api_management_named_value" "wisp_dismantling_converter_base_url" {
  name                = "wisp-dismantling-converter-base-url"
  api_management_name = local.pagopa_apim_name
  resource_group_name = local.pagopa_apim_rg
  display_name        = "wisp-dismantling-converter-base-url"
  value               = "https://${local.nodo_hostname}/pagopa-wispconverter"
}

resource "azurerm_api_management_named_value" "wisp_checkout_predefined_expiration_time" {
  name                = "wisp-checkout-predefined-expiration-time"
  api_management_name = local.pagopa_apim_name
  resource_group_name = local.pagopa_apim_rg
  display_name        = "wisp-checkout-predefined-expiration-time"
  value               = var.wisp_converter.checkout_predefined_expiration_time
}

resource "azurerm_api_management_named_value" "wisp_ecommerce_channels" {
  name                = "wisp-ecommerce-channels"
  api_management_name = local.pagopa_apim_name
  resource_group_name = local.pagopa_apim_rg
  display_name        = "wisp-ecommerce-channels"
  value               = var.wisp_converter.wisp_ecommerce_channels
}

#################
## Fragment    ##
#################
resource "terraform_data" "sha256_wisp_disable_payment_token_timer" {
  count = var.create_wisp_converter ? 1 : 0
  input = sha256(file("./api/nodopagamenti_api/wisp/wisp-disable-payment-token-timer.xml"))
}

resource "azapi_resource" "wisp_disable_payment_token_timer" {
  count = var.create_wisp_converter ? 1 : 0

  type = "Microsoft.ApiManagement/service/policyFragments@2022-04-01-preview"
  name = "wisp-disable-payment-token-timer"

  parent_id = data.azurerm_api_management.apim.id

  body = jsonencode({
    properties = {
      description = "[WISP] Logic to disable payment token timer"
      format      = "rawxml"
      value       = file("./api/nodopagamenti_api/wisp/wisp-disable-payment-token-timer.xml")
    }
  })

  lifecycle {
    ignore_changes = [output]
  }
}

resource "terraform_data" "sha256_wisp_receipt_ko" {
  count = var.create_wisp_converter ? 1 : 0
  input = sha256(file("./api/nodopagamenti_api/wisp/wisp-receipt-ko.xml"))
}
resource "azapi_resource" "wisp_receipt_ko" {
  count = var.create_wisp_converter ? 1 : 0

  type = "Microsoft.ApiManagement/service/policyFragments@2022-04-01-preview"
  name = "wisp-receipt-ko"

  parent_id = data.azurerm_api_management.apim.id

  body = jsonencode({
    properties = {
      description = "[WISP] Logic to send receipt ko"
      format      = "rawxml"
      value       = file("./api/nodopagamenti_api/wisp/wisp-receipt-ko.xml")
    }
  })

  lifecycle {
    ignore_changes = [output]
  }
}


resource "terraform_data" "sha256_wisp_batch_migration" {
  count = var.create_wisp_converter ? 1 : 0
  input = sha256(file("./api/nodopagamenti_api/wisp/wisp-batch-migration.xml"))
}
resource "azapi_resource" "wisp_batch_migration" {
  count = var.create_wisp_converter ? 1 : 0

  type = "Microsoft.ApiManagement/service/policyFragments@2022-04-01-preview"
  name = "wisp-batch-migration"

  parent_id = data.azurerm_api_management.apim.id

  body = jsonencode({
    properties = {
      description = "[WISP] Logic to retrieve whitelisted cis and station"
      format      = "rawxml"
      value       = file("./api/nodopagamenti_api/wisp/wisp-batch-migration.xml")
    }
  })

  lifecycle {
    ignore_changes = [output]
  }
}
