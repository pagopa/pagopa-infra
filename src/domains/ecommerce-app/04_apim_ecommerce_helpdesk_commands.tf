##############
## Products ##
##############

module "apim_ecommerce_helpdesk_commands_product" {
  source = "./.terraform/modules/__v3__/api_management_product"

  product_id   = "ecommerce-helpdesk-commands"
  display_name = "ecommerce pagoPA helpdesk commands service"
  description  = "Product for ecommerce pagoPA helpdesk commands service"

  api_management_name = local.pagopa_apim_name
  resource_group_name = local.pagopa_apim_rg

  published             = true
  subscription_required = true
  approval_required     = true
  subscriptions_limit   = 1000

  policy_xml = file("./api_product/_base_policy.xml")
}

#############################################
## API ecommerce helpdesk commands service ##
#############################################
locals {
  apim_pagopa_ecommerce_helpdesk_commands_service_api = {
    display_name          = "pagoPA ecommerce - helpdesk commands service API"
    description           = "API to support manual operation for ecommerce transacions - helpdesk commands service"
    path                  = "ecommerce/helpdesk-commands-service"
    subscription_required = true
    service_url           = null
  }
}

# helpdesk service APIs
resource "azurerm_api_management_api_version_set" "pagopa_ecommerce_helpdesk_commands_service_api" {
  name                = "${local.project}-helpdesk-commands-service-api"
  resource_group_name = local.pagopa_apim_rg
  api_management_name = local.pagopa_apim_name
  display_name        = local.apim_pagopa_ecommerce_helpdesk_commands_service_api.display_name
  versioning_scheme   = "Segment"
}


#helpdesk api for ecommerce
module "apim_pagopa_ecommerce_helpdesk_commands_service_api_v1" {
  source = "./.terraform/modules/__v3__/api_management_api"

  name                  = "${local.project}-helpdesk-commands-service-api"
  api_management_name   = local.pagopa_apim_name
  resource_group_name   = local.pagopa_apim_rg
  product_ids           = [module.apim_ecommerce_helpdesk_commands_product.product_id]
  subscription_required = local.apim_pagopa_ecommerce_helpdesk_commands_service_api.subscription_required
  version_set_id        = azurerm_api_management_api_version_set.pagopa_ecommerce_helpdesk_commands_service_api.id
  api_version           = "v1"

  description  = local.apim_pagopa_ecommerce_helpdesk_commands_service_api.description
  display_name = local.apim_pagopa_ecommerce_helpdesk_commands_service_api.display_name
  path         = local.apim_pagopa_ecommerce_helpdesk_commands_service_api.path
  protocols    = ["https"]
  service_url  = local.apim_pagopa_ecommerce_helpdesk_commands_service_api.service_url

  content_format = "openapi"
  content_value = templatefile("./api/ecommerce-helpdesk-commands-api/v1/_openapi.json.tpl", {
    hostname = local.apim_hostname
  })

  xml_content = templatefile("./api/ecommerce-helpdesk-commands-api/v1/_base_policy.xml.tpl", {
    hostname      = local.ecommerce_hostname
    pagopa_vpn    = var.pagopa_vpn.ips[0]
    pagopa_vpn_dr = var.pagopa_vpn_dr.ips[0]
  })
}

data "azurerm_key_vault_secret" "pagopa_ecommerce_helpdesk_commands_service_rest_api_primary_key" {
  name         = "ecommerce-helpdesk-service-primary-api-key"
  key_vault_id = data.azurerm_key_vault.kv.id
}

data "azurerm_key_vault_secret" "pagopa_ecommerce_helpdesk_commands_service_rest_api_secondary_key" {
  name         = "ecommerce-helpdesk-service-secondary-api-key"
  key_vault_id = data.azurerm_key_vault.kv.id
}

resource "azurerm_api_management_named_value" "pagopa_ecommerce_helpdesk_commands_service_rest_api_key" {
  name                = "ecommerce-helpdesk-commands-service-rest-api-key"
  api_management_name = local.pagopa_apim_name
  resource_group_name = local.pagopa_apim_rg
  display_name        = "ecommerce-helpdesk-commands-service-rest-api-key"
  value               = var.ecommerce_helpdesk_commands_service_api_key_use_primary ? data.azurerm_key_vault_secret.pagopa_ecommerce_helpdesk_commands_service_rest_api_primary_key.value : data.azurerm_key_vault_secret.pagopa_ecommerce_helpdesk_commands_service_rest_api_secondary_key.value
  secret              = true
}
