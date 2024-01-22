resource "azurerm_resource_group" "azdo_rg" {
  count    = var.enable_azdoa ? 1 : 0
  name     = "${local.project}-azdoa-rg"
  location = var.location

  tags = var.tags
}

module "azdoa_snet" {
  source                                         = "git::https://github.com/pagopa/azurerm.git//subnet?ref=v3.5.0"
  count                                          = var.enable_azdoa ? 1 : 0
  name                                           = format("%s-azdoa-snet", local.project)
  address_prefixes                               = var.cidr_subnet_azdoa
  resource_group_name                            = azurerm_resource_group.rg_vnet.name
  virtual_network_name                           = module.vnet.name
  enforce_private_link_endpoint_network_policies = true
}


module "azdoa_li_app" {
  source              = "git::https://github.com/pagopa/azurerm.git//azure_devops_agent?ref=v4.20.0"
  count               = var.enable_azdoa ? 1 : 0
  name                = "${local.project}-azdoa-vmss-ubuntu-app"
  resource_group_name = azurerm_resource_group.azdo_rg[0].name
  subnet_id           = module.azdoa_snet[0].id
  subscription_name   = data.azurerm_subscription.current.display_name
  subscription_id     = data.azurerm_subscription.current.subscription_id
  location            = var.location
  image_type          = "custom" # enables usage of "source_image_name"
  source_image_name   = "pagopa-${var.env_short}-azdo-agent-ubuntu2204-image-v2"

  zones        = var.devops_agent_zones
  zone_balance = var.devops_agent_balance_zones

  tags = var.tags
}

module "azdoa_li_infra" {
  source              = "git::https://github.com/pagopa/azurerm.git//azure_devops_agent?ref=v4.20.0"
  count               = var.enable_azdoa ? 1 : 0
  name                = "${local.project}-azdoa-vmss-ubuntu-infra"
  resource_group_name = azurerm_resource_group.azdo_rg[0].name
  subnet_id           = module.azdoa_snet[0].id
  subscription_name   = data.azurerm_subscription.current.display_name
  subscription_id     = data.azurerm_subscription.current.subscription_id
  location            = var.location
  image_type          = "custom" # enables usage of "source_image_name"
  source_image_name   = "pagopa-${var.env_short}-azdo-agent-ubuntu2204-image-v2"

  zones        = var.devops_agent_zones
  zone_balance = var.devops_agent_balance_zones

  tags = var.tags
}

# azure devops policy
data "azuread_service_principal" "iac_principal" {
  count        = var.enable_iac_pipeline ? 1 : 0
  display_name = format("pagopaspa-pagoPA-iac-%s", data.azurerm_subscription.current.subscription_id)
}

data "azurerm_user_assigned_identity" "iac_plan_azdo" {
  name                = local.azdo_iac_plan_managed_identity_name
  resource_group_name = local.managed_identity_rg_name
}

resource "azurerm_key_vault_access_policy" "azdevops_iac_plan_policy" {
  count        = var.enable_iac_pipeline ? 1 : 0
  key_vault_id = module.key_vault.id
  tenant_id    = data.azurerm_client_config.current.tenant_id
  object_id    = data.azurerm_user_assigned_identity.iac_plan_azdo.principal_id

  secret_permissions = ["Get", "List", "Set", ]

  certificate_permissions = ["SetIssuers", "DeleteIssuers", "Purge", "List", "Get"]

  storage_permissions = []
}
