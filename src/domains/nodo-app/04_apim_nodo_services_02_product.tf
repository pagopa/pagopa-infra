###################
## Nodo Products ##
###################

locals {
  base_policy_nodo = templatefile("./api_product/nodo_pagamenti_api/base_policy.xml.tpl", { # decoupler ON
    address-range-from       = var.env_short == "p" ? "10.1.128.0" : "0.0.0.0"
    address-range-to         = var.env_short == "p" ? "10.1.128.255" : "0.0.0.0"
    is-nodo-auth-pwd-replace = false
  })
}

resource "terraform_data" "sha256_apim_nodo_dei_pagamenti_product" {
  input = sha256(local.base_policy_nodo)
}

module "apim_nodo_dei_pagamenti_product" {
  source = "./.terraform/modules/__v3__/api_management_product"

  product_id   = "nodo-2-0"                               #TODO [FCADAC] remove -2-0
  display_name = "AAA Nodo dei Pagamenti 2.0"             #TODO [FCADAC] remove AAA 2.0
  description  = "AAA Product for Nodo dei Pagamenti 2.0" #TODO [FCADAC] remove AAA 2.0

  api_management_name = data.azurerm_api_management.apim.name
  resource_group_name = data.azurerm_api_management.apim.resource_group_name

  published             = true
  subscription_required = false
  approval_required     = false

  policy_xml = local.base_policy_nodo
}
