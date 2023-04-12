##############
## Products ##
##############

module "apim_wallet_product" {
  source = "git::https://github.com/pagopa/terraform-azurerm-v3.git//subnet?ref=v4.1.15"

  product_id   = "wallet"
  display_name = "wallet pagoPA"
  description  = "Product for wallet pagoPA"

  api_management_name = local.pagopa_apim_name
  resource_group_name = local.pagopa_apim_rg

  published             = true
  subscription_required = true
  approval_required     = true
  subscriptions_limit   = 1000

  policy_xml = file("./api_product/_base_policy.xml")
}
