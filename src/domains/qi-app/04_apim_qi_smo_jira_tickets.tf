##############
## Products ##
##############

module "apim_qi_smo_jira_tickets_product" {
  source = "./.terraform/modules/__v3__/api_management_product"

  product_id   = "qi-smo-jira-tickets"
  display_name = "QI SMO JIRA TICKETS pagoPA"
  description  = "Product for QI SMO JIRA TICKETS pagoPA"

  api_management_name = local.pagopa_apim_name
  resource_group_name = local.pagopa_apim_rg

  published             = true
  subscription_required = true
  approval_required     = true
  subscriptions_limit   = 100

  policy_xml = file("./api_product/_base_policy.xml")
}

############################
## API qi fdr kpi service ##
############################
locals {
  apim_pagopa_qi_smo_jira_tickets_service_api = {
    display_name          = "pagoPA QI SMO JIRA TICKETS pagoPA"
    description           = "API for QI SMO JIRA TICKETS pagoPA."
    path                  = "qi/smo/jiraticket"
    subscription_required = true
    service_url           = null
  }
}

# qi fdr kpi service APIs
resource "azurerm_api_management_api_version_set" "pagopa_qi_smo_jira_tickets_service_api" {
  name                = "${local.project}-smo-jira-tickets-api"
  resource_group_name = local.pagopa_apim_rg
  api_management_name = local.pagopa_apim_name
  display_name        = local.apim_pagopa_qi_smo_jira_tickets_service_api.display_name
  versioning_scheme   = "Segment"
}

module "apim_pagopa_qi_smo_jira_tickets_service_api" {
  source = "./.terraform/modules/__v3__/api_management_api"

  name                  = "${local.project}-smo-jira-tickets-api"
  api_management_name   = local.pagopa_apim_name
  resource_group_name   = local.pagopa_apim_rg
  product_ids           = [module.apim_qi_smo_jira_tickets_product.product_id]
  subscription_required = local.apim_pagopa_qi_smo_jira_tickets_service_api.subscription_required
  version_set_id        = azurerm_api_management_api_version_set.pagopa_qi_smo_jira_tickets_service_api.id
  api_version           = "v1"

  description  = local.apim_pagopa_qi_smo_jira_tickets_service_api.description
  display_name = local.apim_pagopa_qi_smo_jira_tickets_service_api.display_name
  path         = local.apim_pagopa_qi_smo_jira_tickets_service_api.path
  protocols    = ["https"]
  service_url  = local.apim_pagopa_qi_smo_jira_tickets_service_api.service_url

  content_format = "openapi"
  content_value = templatefile("./api/qi-smo-jira-tickets-api/v1/_openapi.json.tpl", {
    hostname = local.apim_hostname
  })

  xml_content = templatefile("./api/qi-smo-jira-tickets-api/v1/_base_policy.xml.tpl", {
    hostname = local.qi_hostname
  })
}
