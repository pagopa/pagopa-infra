resource "azurerm_resource_group" "certification_authority" {
  name     = "${local.project}-ca-rg"
  location = var.location

  tags = module.tag_config.tags
}

module "certification_authority" {
  source = "./.terraform/modules/__v4__/keyvault_private_ca"

  key_vault_prefix = local.project
  keyvault_administrator_principal_ids = [
    data.azuread_group.adgroup_admin.object_id
  ]
  location            = azurerm_resource_group.certification_authority.location
  resource_group_name = azurerm_resource_group.certification_authority.name
  root_subject        = "CN=PagoPA Pagamenti Root CA${var.env == "prod" ? "" : " - ${var.env}"}, OU=Pagamenti, O=PagoPA S.p.A., C=IT"
  tenant_id           = data.azurerm_client_config.current.tenant_id

  tags = module.tag_config.tags
}