#
# Policy
#

data "azurerm_user_assigned_identity" "iac_federated_azdo" {
  for_each            = local.azdo_iac_managed_identities
  name                = each.key
  resource_group_name = local.azdo_managed_identity_rg_name
}

resource "azurerm_key_vault_access_policy" "azdevops_iac_managed_identities" {
  for_each = local.azdo_iac_managed_identities

  key_vault_id = module.key_vault.id
  tenant_id    = data.azurerm_client_config.current.tenant_id
  object_id    = data.azurerm_user_assigned_identity.iac_federated_azdo[each.key].principal_id

  secret_permissions      = ["Get", "List", "Set", ]
  key_permissions         = ["Get", "GetRotationPolicy", "Decrypt"]
  certificate_permissions = ["SetIssuers", "DeleteIssuers", "Purge", "List", "Get"]

  storage_permissions = []
}


#
# Legacy
#

# azure devops policy
data "azuread_service_principal" "iac_deploy_legacy" {
  display_name = "pagopaspa-pagoPA-iac-${data.azurerm_subscription.current.subscription_id}"
}

data "azuread_service_principal" "iac_plan_legacy" {
  display_name = "azdo-sp-plan-PAGOPA-IAC-LEGACY-${var.env}"
}

resource "azurerm_key_vault_access_policy" "azdevops_iac_legacy_policies" {
  for_each = toset([
    data.azuread_service_principal.iac_plan_legacy.object_id,
    data.azuread_service_principal.iac_deploy_legacy.object_id
  ])
  key_vault_id = module.key_vault.id
  tenant_id    = data.azurerm_client_config.current.tenant_id
  object_id    = each.key

  secret_permissions = ["Get", "List", "Set", ]

  certificate_permissions = ["SetIssuers", "DeleteIssuers", "Purge", "List", "Get"]

  storage_permissions = []
}
