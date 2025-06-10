resource "azurerm_resource_group" "azdo_rg" {
  count    = var.is_feature_enabled.azdoa ? 1 : 0
  name     = "${local.product}-azdoa-rg"
  location = var.location

  tags = module.tag_config.tags
}

module "azdoa_snet" {
  source                                    = "git::https://github.com/pagopa/terraform-azurerm-v3.git//subnet?ref=v8.13.0"
  count                                     = var.is_feature_enabled.azdoa ? 1 : 0
  name                                      = "${local.product}-azdoa-snet"
  address_prefixes                          = var.cidr_subnet_azdoa
  resource_group_name                       = azurerm_resource_group.rg_vnet.name
  virtual_network_name                      = module.vnet.name
  private_endpoint_network_policies_enabled = false

  service_endpoints = [
    "Microsoft.Storage",
  ]
}

module "azdoa_li_app" {
  source              = "git::https://github.com/pagopa/terraform-azurerm-v3.git//azure_devops_agent?ref=v8.13.0"
  count               = var.is_feature_enabled.azdoa ? 1 : 0
  name                = "${local.product}-azdoa-vmss-ubuntu-app"
  resource_group_name = azurerm_resource_group.azdo_rg[0].name
  subnet_id           = module.azdoa_snet[0].id
  subscription_id     = data.azurerm_subscription.current.subscription_id
  location            = var.location
  image_type          = "custom" # enables usage of "source_image_name"
  source_image_name   = var.azdo_agent_vm_image_name
  vm_sku              = "Standard_B2ms"

  zones        = var.devops_agent_zones
  zone_balance = var.devops_agent_balance_zones

  tags = module.tag_config.tags
}

module "azdoa_li_infra" {
  source              = "git::https://github.com/pagopa/terraform-azurerm-v3.git//azure_devops_agent?ref=v8.13.0"
  count               = var.is_feature_enabled.azdoa ? 1 : 0
  name                = "${local.product}-azdoa-vmss-ubuntu-infra"
  resource_group_name = azurerm_resource_group.azdo_rg[0].name
  subnet_id           = module.azdoa_snet[0].id
  subscription_id     = data.azurerm_subscription.current.subscription_id
  location            = var.location
  image_type          = "custom" # enables usage of "source_image_name"
  source_image_name   = var.azdo_agent_vm_image_name
  vm_sku              = "Standard_B2ms"

  zones        = var.devops_agent_zones
  zone_balance = var.devops_agent_balance_zones

  tags = module.tag_config.tags
}

resource "azurerm_virtual_machine_scale_set_extension" "custom_script_extension_infra" {
  count                        = var.is_feature_enabled.azdoa && var.is_feature_enabled.azdoa_extension ? 1 : 0
  name                         = "CustomScript"
  virtual_machine_scale_set_id = module.azdoa_li_infra[0].scale_set_id
  publisher                    = "Microsoft.Azure.Extensions"
  type                         = "CustomScript"
  type_handler_version         = "2.1"
  settings = jsonencode({
    "commandToExecute" = <<EOL
    echo "nothing to do"
    EOL
  })
}


resource "azurerm_virtual_machine_scale_set_extension" "custom_script_extension_app" {
  count                        = var.is_feature_enabled.azdoa && var.is_feature_enabled.azdoa_extension ? 1 : 0
  name                         = "CustomScript"
  virtual_machine_scale_set_id = module.azdoa_li_app[0].scale_set_id
  publisher                    = "Microsoft.Azure.Extensions"
  type                         = "CustomScript"
  type_handler_version         = "2.1"
  settings = jsonencode({
    "commandToExecute" = <<EOL
    echo "nothing to do"
    EOL
  })
}


#
# Load Tests
#

module "loadtest_agent_snet" {
  count                                     = var.env_short != "p" ? 1 : 0
  source                                    = "git::https://github.com/pagopa/terraform-azurerm-v3.git//subnet?ref=v8.13.0"
  name                                      = "${local.product}-loadtest-agent-snet"
  address_prefixes                          = var.cidr_subnet_loadtest_agent
  resource_group_name                       = azurerm_resource_group.rg_vnet.name
  virtual_network_name                      = module.vnet.name
  private_endpoint_network_policies_enabled = true

  service_endpoints = [
    "Microsoft.Web",
    "Microsoft.AzureCosmosDB",
    "Microsoft.Storage",
  ]
}


module "azdoa_loadtest_li" {
  source              = "git::https://github.com/pagopa/terraform-azurerm-v3.git//azure_devops_agent?ref=v8.13.0"
  count               = var.env_short != "p" ? 1 : 0
  name                = "${local.product}-azdoa-vmss-loadtest-li"
  resource_group_name = azurerm_resource_group.azdo_rg[0].name
  subnet_id           = module.azdoa_snet[0].id
  subscription_id     = data.azurerm_subscription.current.subscription_id
  location            = var.location
  image_type          = "custom" # enables usage of "source_image_name"
  source_image_name   = "pagopa-${var.env_short}-azdo-agent-ubuntu2204-image-v2"

  zones        = var.devops_agent_zones
  zone_balance = var.devops_agent_balance_zones

  vm_sku = "Standard_D8ds_v5"

  tags = module.tag_config.tags
}


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

  key_permissions    = ["Get", "List", "Decrypt", "Verify", "GetRotationPolicy"]
  secret_permissions = ["Get", "List", "Set", ]

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

