data "azurerm_resource_group" "rg_api" {
  name = format("%s-api-rg", local.product)
}

data "azurerm_api_management" "apim" {
  name                = "${local.product}-apim"
  resource_group_name = data.azurerm_resource_group.rg_api.name
}

data "azurerm_key_vault" "gps_kv" {
  name                = local.gps_kv
  resource_group_name = local.gps_kv_rg
}

data "azurerm_key_vault_secret" "gpd_db_usr" {
  name         = "db-apd-user-name"
  key_vault_id = data.azurerm_key_vault.gps_kv.id
}

data "azurerm_key_vault_secret" "gpd_db_pwd" {
  name         = "db-apd-user-password"
  key_vault_id = data.azurerm_key_vault.gps_kv.id
}

# data "azurerm_postgresql_server" "postgresql" {
#   count               = var.env_short == "d" ? 1 : 0
#   name                = format("%s-gpd-postgresql", local.product)
#   resource_group_name = format("%s-gpd-rg", local.product)
# }

# data "azurerm_postgresql_flexible_server" "postgres_flexible_server_private" {
#   count               = var.env_short == "p" ? 1 : 0 # NEWGPD-DB : DEPRECATED to remove after switch to new WEU gpd  
#   name                = format("%s-gpd-pgflex", local.product)
#   resource_group_name = format("%s-pgres-flex-rg", local.product)
# }

data "azurerm_resource_group" "identity_rg" {
  name = "${local.product}-identity-rg"
}

data "azurerm_api_management_product" "apim_iuv_generator_product" {
  product_id          = "iuvgenerator"
  api_management_name = local.pagopa_apim_name
  resource_group_name = local.pagopa_apim_rg
}

data "azurerm_api_management_product" "apim_gps_spontaneous_payments_services_product" {
  product_id          = "gps-spontaneous-payments-services"
  api_management_name = local.pagopa_apim_name
  resource_group_name = local.pagopa_apim_rg
}

data "azurerm_api_management_product" "apim_gpd_integration_product" {
  product_id          = "debt-positions-integration"
  api_management_name = local.pagopa_apim_name
  resource_group_name = local.pagopa_apim_rg
}

# fetch the apim qa user resource
data "azurerm_api_management_user" "apim_qa_user" {
  count = var.env_short != "p" ? 1 : 0

  api_management_name = data.azurerm_api_management.apim.name
  resource_group_name = data.azurerm_api_management.apim.resource_group_name
  user_id             = "pagopa-qa-pagopa-it"
}

data "azurerm_api_management_product" "apim_fdr_orgs" {
  product_id          = "fdr-org"
  api_management_name = local.pagopa_apim_name
  resource_group_name = local.pagopa_apim_rg
}

data "azurerm_api_management_product" "apim_fdr_internal" {
  product_id          = "fdr_internal"
  api_management_name = local.pagopa_apim_name
  resource_group_name = local.pagopa_apim_rg
}