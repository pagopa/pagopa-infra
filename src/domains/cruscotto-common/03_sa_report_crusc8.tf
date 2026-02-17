# resource "azurerm_resource_group" "cruscotto_rg" {
#   name     = "${local.project}-sa-rg"
#   location = var.location

#   tags = module.tag_config.tags
# }

module "crusc8_sa_report" {
  count = var.crusc8_sa_report.enabled

  source            = "./.terraform/modules/__v4__/IDH/storage_account"
  env               = var.env
  idh_resource_tier = "basic"
  product_name      = local.prefix

  domain              = local.domain
  name                = replace("${local.product}-report-sa", "-", "")
  resource_group_name = azurerm_resource_group.cruscotto_rg.name
  location            = azurerm_resource_group.cruscotto_rg.location
  embedded_subnets = {
    enabled      = true
    vnet_name    = null
    vnet_rg_name = null
  }

  tags = module.tag_config.tags
}
