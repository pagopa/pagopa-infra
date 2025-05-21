######
# ndphost header
######
locals {
  ndphost_header_file = templatefile("./api_product/nodo_pagamenti_api/ndphost_header.xml.tpl", {
    content = file("./api_product/nodo_pagamenti_api/env/${var.env}/ndphost_header.xml")
  })

  nuova_connettivita_policy_file = file("./api_product/nodo_pagamenti_api/nuova_connettivita_policy.xml")

  start_payment_inbound_policy_file = file("./api/nodopagamenti_api/decoupler/start_payment_inbound_policy.xml")
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


#####
# decoupler
#####
resource "terraform_data" "sha256_start_payment_inbound_policy" {
  input = sha256(local.start_payment_inbound_policy_file)
}
resource "azapi_resource" "start_payment_inbound_policy" {
  type      = "Microsoft.ApiManagement/service/policyFragments@2022-04-01-preview"
  name      = "ndp-start-payment-policy"
  parent_id = data.azurerm_api_management.apim.id

  body = jsonencode({
    properties = {
      description = "Inbound policy regarding activation of a payment"
      format      = "rawxml"
      value       = local.start_payment_inbound_policy_file
    }
  })

  lifecycle {
    ignore_changes = [output]
  }
}
