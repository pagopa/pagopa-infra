######
# ndphost header
######
locals {
  ndphost_header_file = templatefile("./api_product/nodo_pagamenti_api/ndphost_header.xml.tpl", {
    content = file("./api_product/nodo_pagamenti_api/env/${var.env}/ndphost_header.xml")
  })

  nuova_connettivita_policy_file = file("./api_product/nodo_pagamenti_api/nuova_connettivita_policy.xml")

  start_payment_inbound_policy_file               = file("./api/nodopagamenti_api/decoupler/start_payment_inbound_policy.xml")
  ndp_extract_fiscalcode_noticenumber_policy_file = file("./api/nodopagamenti_api/decoupler/extract_fiscalCode_noticeNumber_policy.xml")
  set_base_url_policy_file                        = file("./api/nodopagamenti_api/decoupler/set_base_url_policy.xml")
  spo_inbound_policy_file                         = file("./api/nodopagamenti_api/decoupler/spo_inbound_policy.xml")
  rpt_inbound_policy_file                         = file("./api/nodopagamenti_api/decoupler/rpt_inbound_policy.xml")
  cache_token_object_outbound_policy_file         = file("./api/nodopagamenti_api/decoupler/cache_token_object_outbound_policy.xml")
  end_payment_cache_removal_outbound_policy_file  = file("./api/nodopagamenti_api/decoupler/end_payment_cache_removal_outbound_policy.xml")
  verificatore_inbound_policy_file                = file("./api/nodopagamenti_api/decoupler/verificatore_inbound_policy.xml")
  verificatore_outbound_policy_file               = file("./api/nodopagamenti_api/decoupler/verificatore_outbound_policy.xml")
  verificatore_activateIOPayment_inbound_policy_file    = file("./api/nodopagamenti_api/decoupler/verificatore_activateIOPayment_inbound_policy.xml")
  verificatore_activateIOPayment_outbound_policy_file   = file("./api/nodopagamenti_api/decoupler/verificatore_activateIOPayment_outbound_policy.xml")
  wisp_activate_inbound_policy_file                     = file("./api/nodopagamenti_api/decoupler/wisp_activate_inbound_policy.xml")
  wisp_activate_outbound_policy_file                    = file("./api/nodopagamenti_api/decoupler/wisp_activate_outbound_policy.xml")
}

resource "terraform_data" "sha256_ndphost_header" {
  input = sha256(local.ndphost_header_file)
}
resource "azapi_resource" "ndphost_header" {
  type      = "Microsoft.ApiManagement/service/policyFragments@2022-04-01-preview"
  name      = "ndphost-header"
  parent_id = data.azurerm_api_management.apim.id

  body = jsonencode({
    properties = {
      description = "Setting header about ndphost"
      format      = "rawxml"
      value       = local.ndphost_header_file
    }
  })

  lifecycle {
    ignore_changes = [output]
  }
}

# Fragment: ndp-nuova-connettivita
resource "azurerm_api_management_policy_fragment" "nuova_connettivita_policy" {
  api_management_id = data.azurerm_api_management.apim.id
  name              = "ndp-nuova-connettivita"
  description       = "Setting placeholder value for nuova connettività"
  format            = "rawxml"
  value             = local.nuova_connettivita_policy_file
}

########################################
##########     DECOUPLER      ##########
########################################

# Fragment: ndp-set-base-url-policy
resource "azurerm_api_management_policy_fragment" "set_base_url_policy" {
  api_management_id = data.azurerm_api_management.apim.id
  name              = "ndp-set-base-url-policy"
  description       = "Fragment to extract Base URL, starting from baseNodeId"
  format            = "rawxml"
  value             = local.set_base_url_policy_file
}

# Fragment: ndp-start-payment-policy
resource "azurerm_api_management_policy_fragment" "start_payment_inbound_policy" {
  api_management_id = data.azurerm_api_management.apim.id
  name              = "ndp-start-payment-policy"
  description       = "Fragment to handle inbound logic regarding activation of a payment"
  format            = "rawxml"
  value             = local.start_payment_inbound_policy_file

  depends_on = [
    azurerm_api_management_named_value.ndp_eCommerce_trxId_ttl,
    azurerm_api_management_named_value.ndp_nodo_fc_nav_ttl
    // #TODO [FCADAC] add data on enable_nm3_switch
  ]
}

# Fragment: ndp-extract-fiscalCode-noticeNumber
resource "azurerm_api_management_policy_fragment" "extract_fc_nav_policy" {
  api_management_id = data.azurerm_api_management.apim.id
  name              = "ndp-extract-fiscalCode-noticeNumber-policy"
  description       = "Fragment to create RequestInfo data structure, needed for start_payment_inbound_policy"
  format            = "rawxml"
  value             = local.ndp_extract_fiscalcode_noticenumber_policy_file

  depends_on = [
  ]
}

# Fragment: ndp-spo-inbound-policy
resource "azurerm_api_management_policy_fragment" "spo_inbound_policy" {
  api_management_id = data.azurerm_api_management.apim.id
  name              = "ndp-spo-inbound-policy"
  description       = "Fragment to handle inbound logic regarding SendPaymentOutcome primitives"
  format            = "rawxml"
  value             = local.spo_inbound_policy_file

  depends_on = [
  ]
}

# Fragment: ndp-rpt-inbound-policy
resource "azurerm_api_management_policy_fragment" "rpt_inbound_policy" {
  api_management_id = data.azurerm_api_management.apim.id
  name              = "ndp-rpt-inbound-policy"
  description       = "Fragment to handle inbound logic regarding RPT-like primitives"
  format            = "rawxml"
  value             = local.rpt_inbound_policy_file

  depends_on = [
  ]
}

# Fragment: ndp-cache-token-object-outbound-policy
resource "azurerm_api_management_policy_fragment" "cache_token_object_outbound_policy" {
  api_management_id = data.azurerm_api_management.apim.id
  name              = "ndp-cache-token-object-outbound-policy"
  description       = "Fragment to handle outbound logic regarding inserting token-related object in cache"
  format            = "rawxml"
  value             = local.cache_token_object_outbound_policy_file

  depends_on = [
  ]
}

# Fragment: ndp-end-payment-cache-removal-outbound-policy
resource "azurerm_api_management_policy_fragment" "end_payment_cache_removal_outbound_policy" {
  api_management_id = data.azurerm_api_management.apim.id
  name              = "ndp-end-payment-cache-removal-outbound-policy"
  description       = "Fragment to handle outbound logic regarding removing token-related object from cache"
  format            = "rawxml"
  value             = local.end_payment_cache_removal_outbound_policy_file

  depends_on = [
  ]
}

# Fragment: ndp-verificatore-inbound-policy
resource "azurerm_api_management_policy_fragment" "verificatore_inbound_policy" {
  api_management_id = data.azurerm_api_management.apim.id
  name              = "ndp-verificatore-inbound-policy"
  description       = "Fragment to handle inbound logic regarding verificatore"
  format            = "rawxml"
  value             = local.verificatore_inbound_policy_file
}

# Fragment: ndp-verificatore-outbound-policy
resource "azurerm_api_management_policy_fragment" "verificatore_outbound_policy" {
  api_management_id = data.azurerm_api_management.apim.id
  name              = "ndp-verificatore-outbound-policy"
  description       = "Fragment to handle outbound logic regarding verificatore"
  format            = "rawxml"
  value             = local.verificatore_outbound_policy_file
}

# Fragment: ndp-verificatore-activateIOPayment-inbound-policy
resource "azurerm_api_management_policy_fragment" "verificatore_activateIOPayment_inbound_policy" {
  api_management_id = data.azurerm_api_management.apim.id
  name              = "ndp-verificatore-activateIOPayment-inbound-policy"
  description       = "Fragment to handle inbound logic regarding verificatore for activateIOPayment"
  format            = "rawxml"
  value             = local.verificatore_activateIOPayment_inbound_policy_file
}

# Fragment: ndp-verificatore-activateIOPayment-outbound-policy
resource "azurerm_api_management_policy_fragment" "verificatore_activateIOPayment_outbound_policy" {
  api_management_id = data.azurerm_api_management.apim.id
  name              = "ndp-verificatore-activateIOPayment-outbound-policy"
  description       = "Fragment to handle outbound logic regarding verificatore for activateIOPayment"
  format            = "rawxml"
  value             = local.verificatore_activateIOPayment_outbound_policy_file
}

# Fragment: ndp-wisp-activate-inbound-policy
resource "azurerm_api_management_policy_fragment" "wisp_activate_inbound_policy" {
  api_management_id = data.azurerm_api_management.apim.id
  name              = "ndp-wisp-activate-inbound-policy"
  description       = "Fragment to handle inbound logic regarding wisp dismantling"
  format            = "rawxml"
  value             = local.wisp_activate_inbound_policy_file
}

# Fragment: ndp-wisp-activate-outbound-policy
resource "azurerm_api_management_policy_fragment" "wisp_activate_outbound_policy" {
  api_management_id = data.azurerm_api_management.apim.id
  name              = "ndp-wisp-activate-outbound-policy"
  description       = "Fragment to handle outbound logic regarding wisp dismantling"
  format            = "rawxml"
  value             = local.wisp_activate_outbound_policy_file
}
