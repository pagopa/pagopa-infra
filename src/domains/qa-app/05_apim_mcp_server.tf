##############
## Products ##
##############

module "apim_mcp_server_product" {
  source = "./.terraform/modules/__v4__/api_management_product"

  product_id   = "pagopa-mcp-server"
  display_name = "PAGOPA MCP SERVER"
  description  = "API Product for PagoPA MCP Server"

  api_management_name = local.pagopa_apim_name
  resource_group_name = local.pagopa_apim_rg

  published             = true
  subscription_required = false
  approval_required     = false

  policy_xml = file("./api_product/_base_policy.xml")
}

#######################################
## API pagopa mcp server ##
#######################################
locals {
  apim_mcp_server_api = {
    display_name          = "PagoPA MCP Server"
    description           = "API for PagoPA MCP Server"
    path                  = "qa/mcp-server"
    subscription_required = false
    service_url           = null
  }
}

resource "azurerm_api_management_api_version_set" "mcp_server_api" {
  name                = "${local.project}-mcp-server-api"
  resource_group_name = local.apim_rg_name
  api_management_name = local.apim_name
  display_name        = local.apim_mcp_server_api.display_name
  versioning_scheme   = "Segment"
}

module "apim_mcp_server_api" {
  source = "./.terraform/modules/__v4__/api_management_api"

  name                  = "${local.project}-mcp-server-api"
  api_management_name   = local.apim_name
  resource_group_name   = local.apim_rg_name
  product_ids           = [module.apim_mcp_server_product.product_id]
  subscription_required = local.apim_mcp_server_api.subscription_required
  version_set_id        = azurerm_api_management_api_version_set.mcp_server_api.id
  api_version           = "v1"

  description  = local.apim_mcp_server_api.description
  display_name = local.apim_mcp_server_api.display_name
  path         = local.apim_mcp_server_api.path
  protocols    = ["https"]
  service_url  = local.apim_mcp_server_api.service_url

  content_format = "openapi"
  content_value = templatefile("./api/pagopa-mcp-server-api/v1/_openapi.json.tpl", {
    hostname = local.apim_hostname
  })

  xml_content = templatefile("./api/pagopa-mcp-server-api/v1/_base_policy.xml.tpl", {
    hostname   = local.mcp_server_hostname
    backend_id = azurerm_api_management_backend.mcp_server.name
  })
}

resource "azurerm_api_management_backend" "mcp_server" {
  name                = "${local.project}-mcp-server-backend"
  resource_group_name = local.apim_rg_name
  api_management_name = local.apim_name
  protocol            = "http"
  # @TODO: remove the hardcoded "/v1" at the end of the URL when the backend service is updated to support multiple versions.
  # we want to manage the versioning at the API Management level, not at the backend service level.
  url = "https://${local.mcp_server_hostname}/pagopa-mcp-server/v1"

  tls {
    validate_certificate_chain = false
    validate_certificate_name  = false
  }
}
