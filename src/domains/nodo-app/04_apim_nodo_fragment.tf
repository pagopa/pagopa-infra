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
  wisp_activate_inbound_policy_file               = file("./api/nodopagamenti_api/decoupler/wisp_activate_inbound_policy.xml")
  wisp_activate_outbound_policy_file               = file("./api/nodopagamenti_api/decoupler/wisp_activate_outbound_policy.xml")
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

#####
# nuova connettività
#####
resource "terraform_data" "sha256_nuova_connettivita_policy" {
  input = sha256(local.nuova_connettivita_policy_file)
}
resource "azapi_resource" "nuova_connettivita_policy" {
  type      = "Microsoft.ApiManagement/service/policyFragments@2022-04-01-preview"
  name      = "ndp-nuova-connettivita"
  parent_id = data.azurerm_api_management.apim.id

  body = jsonencode({
    properties = {
      description = "Setting placeholder value for nuova connettività"
      format      = "rawxml"
      value       = local.nuova_connettivita_policy_file
    }
  })

  lifecycle {
    ignore_changes = [output]
  }
}


########################################
##########     DECOUPLER      ##########
########################################

# Fragment: ndp-set-base-url-policy
resource "terraform_data" "sha256_set_base_url_policy" {
  input = sha256(local.set_base_url_policy_file)
}
resource "azapi_resource" "set_base_url_policy" {
  type      = "Microsoft.ApiManagement/service/policyFragments@2022-04-01-preview"
  name      = "ndp-set-base-url-policy"
  parent_id = data.azurerm_api_management.apim.id

  body = jsonencode({
    properties = {
      description = "Fragment to extract Base URL, starting from baseNodeId"
      format      = "rawxml"
      value       = local.set_base_url_policy_file
    }
  })

  lifecycle {
    ignore_changes = [output]
  }

  depends_on = [
  ]
}

# Fragment: ndp-start-payment-policy
resource "terraform_data" "sha256_start_payment_inbound_policy" {
  input = sha256(local.start_payment_inbound_policy_file)
}
resource "azapi_resource" "start_payment_inbound_policy" {
  type      = "Microsoft.ApiManagement/service/policyFragments@2022-04-01-preview"
  name      = "ndp-start-payment-policy"
  parent_id = data.azurerm_api_management.apim.id

  body = jsonencode({
    properties = {
      description = "Fragment to handle inbound logic regarding activation of a payment"
      format      = "rawxml"
      value       = local.start_payment_inbound_policy_file
    }
  })

  lifecycle {
    ignore_changes = [output]
  }

  depends_on = [
    azurerm_api_management_named_value.ndp_eCommerce_trxId_ttl,
    azurerm_api_management_named_value.ndp_nodo_fc_nav_ttl
    // #TODO [FCADAC] add data on enable_nm3_switch
  ]
}

# Fragment: ndp-extract-fiscalCode-noticeNumber
resource "terraform_data" "sha256_extract_fc_nav_policy" {
  input = sha256(local.ndp_extract_fiscalcode_noticenumber_policy_file)
}
resource "azapi_resource" "extract_fc_nav_policy" {
  type      = "Microsoft.ApiManagement/service/policyFragments@2022-04-01-preview"
  name      = "ndp-extract-fiscalCode-noticeNumber-policy"
  parent_id = data.azurerm_api_management.apim.id

  body = jsonencode({
    properties = {
      description = "Fragment to create RequestInfo data structure, needed for start_payment_inbound_policy"
      format      = "rawxml"
      value       = local.ndp_extract_fiscalcode_noticenumber_policy_file
    }
  })

  lifecycle {
    ignore_changes = [output]
  }

  depends_on = [
  ]
}

# Fragment: ndp-spo-inbound-policy
resource "terraform_data" "sha256_spo_inbound_policy" {
  input = sha256(local.spo_inbound_policy_file)
}
resource "azapi_resource" "spo_inbound_policy" {
  type      = "Microsoft.ApiManagement/service/policyFragments@2022-04-01-preview"
  name      = "ndp-spo-inbound-policy"
  parent_id = data.azurerm_api_management.apim.id

  body = jsonencode({
    properties = {
      description = "Fragment to handle inbound logic regarding SendPaymentOutcome primitives"
      format      = "rawxml"
      value       = local.spo_inbound_policy_file
    }
  })

  lifecycle {
    ignore_changes = [output]
  }

  depends_on = [
  ]
}

# Fragment: ndp-rpt-inbound-policy
resource "terraform_data" "sha256_rpt_inbound_policy" {
  input = sha256(local.rpt_inbound_policy_file)
}
resource "azapi_resource" "rpt_inbound_policy" {
  type      = "Microsoft.ApiManagement/service/policyFragments@2022-04-01-preview"
  name      = "ndp-rpt-inbound-policy"
  parent_id = data.azurerm_api_management.apim.id

  body = jsonencode({
    properties = {
      description = "Fragment to handle inbound logic regarding RPT-like primitives"
      format      = "rawxml"
      value       = local.rpt_inbound_policy_file
    }
  })

  lifecycle {
    ignore_changes = [output]
  }

  depends_on = [
  ]
}

# Fragment: ndp-cache-token-object-outbound-policy
resource "terraform_data" "sha256_cache_token_object_outbound_policy" {
  input = sha256(local.cache_token_object_outbound_policy_file)
}
resource "azapi_resource" "cache_token_object_outbound_policy" {
  type      = "Microsoft.ApiManagement/service/policyFragments@2022-04-01-preview"
  name      = "ndp-cache-token-object-outbound-policy"
  parent_id = data.azurerm_api_management.apim.id

  body = jsonencode({
    properties = {
      description = "Fragment to handle outbound logic regarding inserting token-related object in cache"
      format      = "rawxml"
      value       = local.cache_token_object_outbound_policy_file
    }
  })

  lifecycle {
    ignore_changes = [output]
  }

  depends_on = [
  ]
}

# Fragment: ndp-end-payment-cache-removal-outbound-policy
resource "terraform_data" "sha256_end_payment_cache_removal_outbound_policy" {
  input = sha256(local.end_payment_cache_removal_outbound_policy_file)
}
resource "azapi_resource" "end_payment_cache_removal_outbound_policy" {
  type      = "Microsoft.ApiManagement/service/policyFragments@2022-04-01-preview"
  name      = "ndp-end-payment-cache-removal-outbound-policy"
  parent_id = data.azurerm_api_management.apim.id

  body = jsonencode({
    properties = {
      description = "Fragment to handle outbound logic regarding removing token-related object from cache"
      format      = "rawxml"
      value       = local.end_payment_cache_removal_outbound_policy_file
    }
  })

  lifecycle {
    ignore_changes = [output]
  }

  depends_on = [
  ]
}

# Fragment: ndp-verificatore-inbound-policy
resource "terraform_data" "sha256_verificatore_inbound_policy" {
  input = sha256(local.verificatore_inbound_policy_file)
}
resource "azapi_resource" "verificatore_inbound_policy" {
  type      = "Microsoft.ApiManagement/service/policyFragments@2022-04-01-preview"
  name      = "ndp-verificatore-inbound-policy"
  parent_id = data.azurerm_api_management.apim.id

  body = jsonencode({
    properties = {
      description = "Fragment to handle inbound logic regarding verificatore"
      format      = "rawxml"
      value       = local.verificatore_inbound_policy_file
    }
  })

  lifecycle {
    ignore_changes = [output]
  }

  depends_on = [
  ]
}

# Fragment: ndp-verificatore-outbound-policy
resource "terraform_data" "sha256_verificatore_outbound_policy" {
  input = sha256(local.verificatore_outbound_policy_file)
}
resource "azapi_resource" "verificatore_outbound_policy" {
  type      = "Microsoft.ApiManagement/service/policyFragments@2022-04-01-preview"
  name      = "ndp-verificatore-outbound-policy"
  parent_id = data.azurerm_api_management.apim.id

  body = jsonencode({
    properties = {
      description = "Fragment to handle outbound logic regarding verificatore"
      format      = "rawxml"
      value       = local.verificatore_outbound_policy_file
    }
  })

  lifecycle {
    ignore_changes = [output]
  }

  depends_on = [
  ]
}

# Fragment: ndp-wisp-activate-inbound-policy
resource "terraform_data" "sha256_wisp_activate_inbound_policy" {
  input = sha256(local.wisp_activate_inbound_policy_file)
}
resource "azapi_resource" "wisp_activate_inbound_policy" {
  type      = "Microsoft.ApiManagement/service/policyFragments@2022-04-01-preview"
  name      = "ndp-wisp-activate-inbound-policy"
  parent_id = data.azurerm_api_management.apim.id

  body = jsonencode({
    properties = {
      description = "Fragment to handle inbound logic regarding wisp dismantling"
      format      = "rawxml"
      value       = local.wisp_activate_inbound_policy_file
    }
  })

  lifecycle {
    ignore_changes = [output]
  }

  depends_on = [
  ]
}

# Fragment: ndp-wisp-activate-outbound-policy
resource "terraform_data" "sha256_wisp_activate_outbound_policy" {
  input = sha256(local.wisp_activate_outbound_policy_file)
}
resource "azapi_resource" "wisp_activate_outbound_policy" {
  type      = "Microsoft.ApiManagement/service/policyFragments@2022-04-01-preview"
  name      = "ndp-wisp-activate-outbound-policy"
  parent_id = data.azurerm_api_management.apim.id

  body = jsonencode({
    properties = {
      description = "Fragment to handle outbound logic regarding wisp dismantling"
      format      = "rawxml"
      value       = local.wisp_activate_outbound_policy_file
    }
  })

  lifecycle {
    ignore_changes = [output]
  }

  depends_on = [
  ]
}
