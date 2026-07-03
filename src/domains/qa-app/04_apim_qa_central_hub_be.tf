##############
## Products ##
##############

module "apim_qa_central_hub_product" {
  source = "./.terraform/modules/__v4__/api_management_product"

  product_id   = "qa-central-hub"
  display_name = "QA CENTRAL HUB"
  description  = "API Product for QA Central Hub"

  api_management_name = local.pagopa_apim_name
  resource_group_name = local.pagopa_apim_rg

  published             = true
  subscription_required = true
  approval_required     = true
  subscriptions_limit   = 1000

  policy_xml = file("./api_product/_base_policy.xml")
}

#######################################
## API qa central hub ##
#######################################
locals {
  apim_qa_central_hub_api = {
    display_name          = "QA Central Hub"
    description           = "API for QA Central Hub"
    path                  = "qa/central-hub"
    subscription_required = true
    service_url           = null
  }
}

# qa central hub APIs
resource "azurerm_api_management_api_version_set" "qa_central_hub_api" {
  name                = "${local.project}-qa-central-hub-api"
  resource_group_name = local.apim_rg_name
  api_management_name = local.apim_name
  display_name        = local.apim_qa_central_hub_api.display_name
  versioning_scheme   = "Segment"
}

module "apim_qa_central_hub_api" {
  source = "./.terraform/modules/__v4__/api_management_api"

  name                  = "${local.project}-qa-central-hub-api"
  api_management_name   = local.apim_name
  resource_group_name   = local.apim_rg_name
  product_ids           = [module.apim_qa_central_hub_product.product_id]
  subscription_required = local.apim_qa_central_hub_api.subscription_required
  version_set_id        = azurerm_api_management_api_version_set.qa_central_hub_api.id
  api_version           = "v1"

  description  = local.apim_qa_central_hub_api.description
  display_name = local.apim_qa_central_hub_api.display_name
  path         = local.apim_qa_central_hub_api.path
  protocols    = ["https"]
  service_url  = local.apim_qa_central_hub_api.service_url

  content_format = "openapi"
  content_value = templatefile("./api/qa-central-hub-api/v1/_openapi.json.tpl", {
    hostname = local.apim_hostname
  })

  xml_content = templatefile("./api/qa-central-hub-api/v1/_base_policy.xml.tpl", {
    hostname   = local.qa_hostname
    backend_id = azurerm_api_management_backend.qa_central_hub.name
  })
}

resource "azurerm_api_management_backend" "qa_central_hub" {
  name                = "${local.project}-qa-central-hub-backend"
  resource_group_name = local.apim_rg_name
  api_management_name = local.apim_name
  protocol            = "http"
  url                 = "https://${local.qa_hostname}/pagopa-qa-central-hub-backend-service"

  tls {
    validate_certificate_chain = false
    validate_certificate_name  = false
  }
}
