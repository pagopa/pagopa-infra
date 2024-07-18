##############
## Products ##
##############

module "apim_donations_product" {
  source = "git::https://github.com/pagopa/azurerm.git//api_management_product?ref=v1.0.90"

  product_id   = "donations-iuv"
  display_name = "Donations"
  description  = "Donations"

  api_management_name = data.azurerm_api_management.apim_migrated[0].name
  resource_group_name = data.azurerm_resource_group.rg_api.name

  published             = true
  subscription_required = false # TO DISABLE DONA
  approval_required     = false
  subscriptions_limit   = 1

  policy_xml = file("./api_product/donations/_base_policy.xml")
}

##############
##    API   ##
##############

resource "azurerm_api_management_api_version_set" "api_donations_api" {

  name                = format("%s-api-donations-api", local.project)
  resource_group_name = data.azurerm_resource_group.rg_api.name
  api_management_name = data.azurerm_api_management.apim_migrated[0].name
  display_name        = "Donations"
  versioning_scheme   = "Segment"
}


module "apim_api_donations_api" {
  source = "git::https://github.com/pagopa/azurerm.git//api_management_api?ref=v2.1.13"

  name                  = format("%s-api-donations-api", local.project)
  api_management_name   = data.azurerm_api_management.apim_migrated[0].name
  resource_group_name   = data.azurerm_resource_group.rg_api.name
  product_ids           = [module.apim_donations_product.product_id]
  subscription_required = false # TO DISABLE DONA
  api_version           = "v1"
  version_set_id        = azurerm_api_management_api_version_set.api_donations_api.id
  service_url           = null // no BE


  description  = "donations"
  display_name = "donations pagoPA"
  path         = "donations/api"
  protocols    = ["https"]


  content_format = "openapi"
  content_value = templatefile("./api/donations/v1/_openapi.json.tpl", {
    host = local.api_domain
  })

  xml_content = file("./api/donations/v1/_base_policy.xml")
}


resource "azurerm_api_management_api_operation_policy" "get_donations" {
  api_name            = format("%s-api-donations-api-v1", local.project)
  api_management_name = data.azurerm_api_management.apim_migrated[0].name
  resource_group_name = data.azurerm_resource_group.rg_api.name
  operation_id        = "getavailabledonations"

  # xml_content = file("./api/donations/v1/donazioni_ucraina.xml")

  xml_content = templatefile("./api/donations/v1/donazioni_ucraina.xml", {
    env_short = var.env_short
    logo_1    = file("./api/donations/v1/logos/logo1")
    logo_2    = file("./api/donations/v1/logos/logo2")
    logo_3    = file("./api/donations/v1/logos/logo3")
    logo_4    = file("./api/donations/v1/logos/logo4")
    logo_5    = file("./api/donations/v1/logos/logo5")
    logo_6    = file("./api/donations/v1/logos/logo6")
  })

}


## Storage Account and related resources

# moved to next-core module
