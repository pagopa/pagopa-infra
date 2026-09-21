#
# Policy
#

data "azurerm_user_assigned_identity" "iac_federated_azdo" {
  for_each            = local.azdo_iac_managed_identities
  name                = each.key
  resource_group_name = local.azdo_managed_identity_rg_name
}



## ad group policy devops ##
module "kv_access_policy_devops" {
  for_each          = local.azdo_iac_managed_identities
  source            = "./.terraform/modules/__v4__/IDH/key_vault_access_policy"
  product_name      = "pagopa"
  idh_resource_tier = "devops"
  env               = var.env
  key_vault_id      = module.key_vault.id
  tenant_id         = data.azurerm_client_config.current.tenant_id
  object_id         = data.azurerm_user_assigned_identity.iac_federated_azdo[each.key].principal_id
}