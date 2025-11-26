### EVH
data "azurerm_eventhub_authorization_rule" "notices_evt_authorization_rule" {
  name                = "${var.prefix}-${var.env_short}-${var.location_short}-${var.domain}-notice-evt-rx"
  resource_group_name = "${var.prefix}-${var.env_short}-${var.location_short}-${var.domain}-evh-rg"
  eventhub_name       = "${var.prefix}-${var.domain}-evh"
  namespace_name      = "${var.prefix}-${var.env_short}-${var.location_short}-${var.domain}-evh"
}

data "azurerm_eventhub_authorization_rule" "notices_evt_complete_authorization_rule" {
  name                = "${var.prefix}-${var.env_short}-${var.location_short}-${var.domain}-notice-evt-complete-rx"
  resource_group_name = "${var.prefix}-${var.env_short}-${var.location_short}-${var.domain}-evh-rg"
  eventhub_name       = "${var.prefix}-${var.domain}-complete-evh"
  namespace_name      = "${var.prefix}-${var.env_short}-${var.location_short}-${var.domain}-evh"
}

data "azurerm_eventhub_authorization_rule" "notices_evt_errors_authorization_rule" {
  name                = "${var.prefix}-${var.env_short}-${var.location_short}-${var.domain}-notice-evt-errors-rx"
  resource_group_name = "${var.prefix}-${var.env_short}-${var.location_short}-${var.domain}-evh-rg"
  eventhub_name       = "${var.prefix}-${var.domain}-errors-evh"
  namespace_name      = "${var.prefix}-${var.env_short}-${var.location_short}-${var.domain}-evh"
}

### COSMOS
data "azurerm_cosmosdb_account" "notices_cosmos_account" {
  name                = "pagopa-${var.env_short}-${var.location_short}-${var.domain}-cosmos-account"
  resource_group_name = "pagopa-${var.env_short}-${var.location_short}-${var.domain}-db-rg"
}

data "azurerm_api_management" "apim" {
  name                = "${var.prefix}-${var.env_short}-apim"
  resource_group_name = "${var.prefix}-${var.env_short}-api-rg"
}

#
# STORAGE ACCOUNT
#
data "azurerm_storage_account" "notices_storage_sa" {
  name                = replace("${local.project_short}-notices", "-", "")
  resource_group_name = "pagopa-${var.env_short}-${var.location_short}-${var.domain}-pdf-rg"
}

data "azurerm_storage_account" "templates_storage_sa" {
  name                = replace("${local.project_short}-templates", "-", "")
  resource_group_name = "pagopa-${var.env_short}-${var.location_short}-${var.domain}-pdf-rg"
}

data "azurerm_storage_account" "institutions_storage_sa" {
  name                = replace("${local.project_short}-ci", "-", "")
  resource_group_name = "pagopa-${var.env_short}-${var.location_short}-${var.domain}-pdf-rg"
}


data "azurerm_api_management_product" "apim_api_config_product" {
  product_id          = "product-api-config-auth"
  api_management_name = local.pagopa_apim_name
  resource_group_name = local.pagopa_apim_rg
}

data "azurerm_resource_group" "identity_rg" {
  name = "${local.product}-identity-rg"
}
