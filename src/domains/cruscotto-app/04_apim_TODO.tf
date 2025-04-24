# locals {
#   apim_<TODO>_pagopa_api = {
#     display_name = "<TODO>"
#     description  = "API for <TODO>"
#   }
# }

# module "apim_<TODO>_product" {
#   source = "./.terraform/modules/__v3__/api_management_product"

#   product_id   = "pagopa_<TODO>"
#   display_name = local.apim_<TODO>_pagopa_api.display_name
#   description  = local.apim_<TODO>_pagopa_api.description

#   api_management_name = local.pagopa_apim_name
#   resource_group_name = local.pagopa_apim_rg

#   published             = false
#   subscription_required = true
#   approval_required     = false
#   subscriptions_limit   = 1000

#   policy_xml = file("./api_product/_base_policy.xml")
# }
