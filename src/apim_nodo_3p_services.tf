############################
## Nodo on PPT LMI        ##
############################


module "apim_nodo_ppt_lmi_product" {
  count  = var.env_short == "d" ? 1 : 0
  source = "git::https://github.com/pagopa/azurerm.git//api_management_product?ref=v1.0.16"

  product_id   = "product-nodo-ppt-lmi"
  display_name = "product-nodo-ppt-lmi"
  description  = "product-nodo-ppt-lmi"

  api_management_name = module.apim.name
  resource_group_name = azurerm_resource_group.rg_api.name

  published             = true
  subscription_required = false
  approval_required     = false

  policy_xml = file("./api_product/nodo_pagamenti_api/_base_policy.xml")
}

resource "azurerm_api_management_api_version_set" "nodo_ppt_lmi_api" {
  count = var.env_short == "d" ? 1 : 0

  name                = format("%s-nodo-ppt-lmi-api", var.env_short)
  resource_group_name = azurerm_resource_group.rg_api.name
  api_management_name = module.apim.name
  display_name        = "Nodo OnCloud PPT LMI"
  versioning_scheme   = "Segment"
}

module "apim_nodo_ppt_lmi_api" {
  count  = var.env_short == "d" ? 1 : 0
  source = "git::https://github.com/pagopa/azurerm.git//api_management_api?ref=v1.0.16"

  name                  = format("%s-nodo-ppt-lmi-api", var.env_short)
  api_management_name   = module.apim.name
  resource_group_name   = azurerm_resource_group.rg_api.name
  product_ids           = [module.apim_nodo_ppt_lmi_product[0].product_id]
  subscription_required = false

  version_set_id = azurerm_api_management_api_version_set.nodo_ppt_lmi_api[0].id
  api_version    = "v1"

  description  = "NodeDeiPagamenti (ppt-lmi)"
  display_name = "NodeDeiPagamenti (ppt-lmi)"
  path         = "ppt-lmi/api"
  protocols    = ["https"]

  service_url = null

  content_format = "openapi"
  content_value = templatefile("./api/nodopagamenti_api/nodoServices/ppt-lmi/v1/_NodoDeiPagamenti.openapi.json.tpl", {
    host = azurerm_api_management_custom_domain.api_custom_domain.proxy[0].host_name
  })

  xml_content = templatefile("./api/nodopagamenti_api/nodoServices/ppt-lmi/v1/_base_policy.xml", {
    dns_pagopa_platform = format("api.%s.%s", var.dns_zone_prefix, var.external_domain),
    apim_base_path      = "/ppt-lmi/api/v1"
  })

}
