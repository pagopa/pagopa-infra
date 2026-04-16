####################
# GPD INTERNAL USE #
####################

## Products ##

module "apim_gpd_product" {
  source       = "./.terraform/modules/__v3__/api_management_product"
  product_id   = "product-gpd"
  display_name = "GPD pagoPA"
  description  = "Prodotto Gestione Posizione Debitorie"

  api_management_name = local.pagopa_apim_name
  resource_group_name = local.pagopa_apim_rg

  published             = false
  subscription_required = false
  approval_required     = false
  subscriptions_limit   = 0

  policy_xml = templatefile("${path.module}/api_product/gpd/_base_policy.xml", {
    env = var.env_short
  })
}

####################
# GPD EXTERNAL USE #
####################

## Products ##

module "apim_debt_positions_product" {
  source = "./.terraform/modules/__v3__/api_management_product"

  product_id   = "debt-positions"
  display_name = "GPD Debt Positions for organizations"
  description  = "GPD Debt Positions for organizations"

  api_management_name = local.pagopa_apim_name
  resource_group_name = local.pagopa_apim_rg

  published             = true
  subscription_required = true
  approval_required     = false
  subscriptions_limit   = 1000

  policy_xml = file("./api_product/gpd/debt-position-services/_base_policy.xml")
}

#####################
## GPD FRAGMENTS ####
#####################

# service type fragment
resource "terraform_data" "sha256_service_type_set_fragment" {
  input = sha256(file("./api/service_type_set_fragment.xml"))
}

resource "azapi_resource" "service_type_set_fragment" {
  type      = "Microsoft.ApiManagement/service/policyFragments@2022-04-01-preview"
  name      = "service-type-set"
  parent_id = data.azurerm_api_management.apim.id

  body = jsonencode({
    properties = {
      description = "Component that is used to set service type in GPD"
      format      = "rawxml"
      value       = templatefile("./api/service_type_set_fragment.xml", {})
    }
  })
}

# segregation codes fragment
resource "terraform_data" "sha256_segregation_codes_fragment" {
  input = sha256(file("./api/segregation_codes_fragment.xml"))
}

resource "azapi_resource" "segregation_codes_fragment" {
  type      = "Microsoft.ApiManagement/service/policyFragments@2022-04-01-preview"
  name      = "segregation-codes-gpd"
  parent_id = data.azurerm_api_management.apim.id

  body = jsonencode({
    properties = {
      description = "Component that is authorize on segregation codes"
      format      = "rawxml"
      value       = templatefile("./api/segregation_codes_fragment.xml", {})
    }
  })
}

