resource "azurerm_resource_group" "sec_rg" {
  name     = "${local.product}-${var.location_short}-${local.domain}-sec-rg"
  location = var.location

  tags = module.tag_config.tags
}

module "key_vault" {
  source = "./.terraform/modules/__v4__/key_vault"

  name                       = "${local.product}-${var.location_short}-${local.domain}-kv"
  location                   = azurerm_resource_group.sec_rg.location
  resource_group_name        = azurerm_resource_group.sec_rg.name
  tenant_id                  = data.azurerm_client_config.current.tenant_id
  soft_delete_retention_days = 90

  tags = module.tag_config.tags
}

## ad group policy admins ##
module "kv_access_policy_admins" {
  source            = "./.terraform/modules/__v4__/IDH/key_vault_access_policy"
  product_name      = "pagopa"
  idh_resource_tier = "admin"
  env               = var.env
  key_vault_id      = module.key_vault.id
  tenant_id         = data.azurerm_client_config.current.tenant_id
  object_id         = data.azuread_group.adgroup_admin.object_id
}

## ad group policy admin dev ##
module "kv_access_policy_admin_dev" {
  source            = "./.terraform/modules/__v4__/IDH/key_vault_access_policy"
  product_name      = "pagopa"
  idh_resource_tier = "admin_dev"
  env               = var.env
  key_vault_id      = module.key_vault.id
  tenant_id         = data.azurerm_client_config.current.tenant_id
  object_id         = data.azuread_group.adgroup_admin_dev.object_id
}

## ad group policy developers ##
module "kv_access_policy_developers" {
  count             = var.env_short != "p" ? 1 : 0
  source            = "./.terraform/modules/__v4__/IDH/key_vault_access_policy"
  product_name      = "pagopa"
  idh_resource_tier = "developer"
  env               = var.env
  key_vault_id      = module.key_vault.id
  tenant_id         = data.azurerm_client_config.current.tenant_id
  object_id         = data.azuread_group.adgroup_developers.object_id
}

## ad group policy externals ##
module "kv_access_policy_externals" {
  count             = var.env_short != "p" ? 1 : 0
  source            = "./.terraform/modules/__v4__/IDH/key_vault_access_policy"
  product_name      = "pagopa"
  idh_resource_tier = "external"
  env               = var.env
  key_vault_id      = module.key_vault.id
  tenant_id         = data.azurerm_client_config.current.tenant_id
  object_id         = data.azuread_group.adgroup_externals.object_id
}



################
##   Secrets  ##
################

# create json letsencrypt inside kv
# requierd: Docker
module "letsencrypt_pos_gateway" {
  source = "./.terraform/modules/__v4__/letsencrypt_credential"

  prefix            = local.prefix
  env               = var.env_short
  key_vault_name    = module.key_vault.name
  subscription_name = data.azurerm_subscription.current.display_name
}
