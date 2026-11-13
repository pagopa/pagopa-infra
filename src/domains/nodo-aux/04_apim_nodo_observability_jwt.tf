##############
## Products ##
##############

module "apim__product" {
  source = "./.terraform/modules/__v4__/api_management_product"

  product_id   = "product-nodo-observability"
  display_name = "Nodo Observability"
  description  = "Product for API Nodo Observability"

  api_management_name = data.azurerm_api_management.apim.name
  resource_group_name = data.azurerm_api_management.apim.resource_group_name

  published             = true
  subscription_required = false
  approval_required     = false

  policy_xml = file("./api_product/nodo_observability/base_policy.xml")
}

##########################################################
## API defined in repository node-technical-support-worker
##########################################################
