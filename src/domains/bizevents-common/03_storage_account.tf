module "bizevents_sa" {
  source = "./.terraform/modules/__v4__/IDH/storage_account"

  name = replace(format("%s-sa", local.project), "-", "")

  product_name        = var.prefix
  env                 = var.env
  idh_resource_tier   = var.bizevents_sa_idh_resource_tier
  domain              = var.domain
  location            = var.location
  resource_group_name = azurerm_resource_group.bizevents_rg.name
  tags                = module.tag_config.tags
}

resource "azurerm_storage_container" "send_dead_letter_events" {
  name               = "send-dead-letter-events"
  storage_account_id = module.bizevents_sa.id
}

