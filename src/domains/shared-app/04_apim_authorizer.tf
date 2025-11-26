locals {
  apim_authorizer_api = {
    display_name          = "Authorizer Domain Caching - Internal API"
    description           = "Internal API for cache handling of domains for Authorizer"
    path                  = "shared/authorizer"
    subscription_required = false
    service_url           = null
  }
}

##############
## Products ##
##############
module "apim_authorizer_product" {
  source = "./.terraform/modules/__v3__/api_management_product"

  product_id   = "authorizer"
  display_name = "Authorizer Domain Caching - Internal API"
  description  = "Internal API for cache handling of domains for Authorizer"

  api_management_name = local.pagopa_apim_name
  resource_group_name = local.pagopa_apim_rg

  published             = false
  subscription_required = false
  approval_required     = false
  # subscriptions_limit   = 1000

  policy_xml = file("./api_product/_authorizer_policy.xml")
}


resource "azurerm_api_management_api_version_set" "api_authorizer_api" {

  name                = format("%s-authorizer-api", var.env_short)
  resource_group_name = local.pagopa_apim_rg
  api_management_name = local.pagopa_apim_name
  display_name        = local.apim_authorizer_api.display_name
  versioning_scheme   = "Segment"
}

module "apim_api_authorizer_api_v1" {
  source = "./.terraform/modules/__v3__/api_management_api"

  name                  = format("%s-authorizer-api", local.project)
  api_management_name   = local.pagopa_apim_name
  resource_group_name   = local.pagopa_apim_rg
  product_ids           = [module.apim_authorizer_product.product_id]
  subscription_required = local.apim_authorizer_api.subscription_required
  version_set_id        = azurerm_api_management_api_version_set.api_authorizer_api.id
  api_version           = "v1"

  description  = local.apim_authorizer_api.description
  display_name = local.apim_authorizer_api.display_name
  path         = local.apim_authorizer_api.path
  protocols    = ["https"]
  service_url  = local.apim_authorizer_api.service_url

  content_format = "openapi"
  content_value = templatefile("./api/authorizer/v1/_openapi.json.tpl", {
    host = local.apim_hostname
  })

  xml_content = templatefile("./api/authorizer/v1/_base_policy.xml", {
    hostname = local.shared_hostname
  })
}

# fragment
resource "terraform_data" "sha256_authorizer_fragment" {
  input = sha256(file("./api/authorizer/authorizer-check.xml"))
}
resource "azapi_resource" "authorizer_fragment" {
  # provider  = azapi.apim
  type      = "Microsoft.ApiManagement/service/policyFragments@2022-04-01-preview"
  name      = "authorizer"
  parent_id = data.azurerm_api_management.apim.id

  body = jsonencode({
    properties = {
      description = "Component that permits to check the authorization on EC for the client"
      format      = "rawxml"
      value = templatefile("./api/authorizer/authorizer-check.xml", {
        cache_generator_hostname = local.cache_generator_hostname
      })

    }
  })

  lifecycle {
    ignore_changes = [output]
  }
}
