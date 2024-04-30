
data "azurerm_eventhub_authorization_rule" "notices_evt_authorization_rule" {
  name                = "${var.prefix}-${var.env_short}-${var.location_short}-${var.domain}-notice-evt-rx"
  resource_group_name = "${var.prefix}-${var.env_short}-${var.location_short}-evenhub-rg"
  eventhub_name       = "${var.prefix}-${var.domain}-evh"
  namespace_name      = "${var.prefix}-${var.env_short}-${var.location_short}-core-evh-meucci"
}

data "azurerm_eventhub_authorization_rule" "notices_complete_evt_authorization_rule" {
  name                = "pagopa-${var.env_short}-${var.location_short}-${var.domain}-notice-complete-evt-tx"
  resource_group_name = "${var.prefix}-${var.env_short}-${var.location_short}-evenhub-rg"
  eventhub_name       = "${var.prefix}-${var.domain}-evh"
  namespace_name      = "${var.prefix}-${var.env_short}-${var.location_short}-core-evh-meucci"
}

data "azurerm_eventhub_authorization_rule" "notices_error_evt_authorization_rule" {
  name                = "pagopa-${var.env_short}-${var.location_short}-${var.domain}-notice-error-evt-tx"
  resource_group_name = "${var.prefix}-${var.env_short}-${var.location_short}-evenhub-rg"
  eventhub_name       = "${var.prefix}-${var.domain}-evh"
  namespace_name      = "${var.prefix}-${var.env_short}-${var.location_short}-core-evh-meucci"
}

data "azurerm_cosmosdb_account" "notices_cosmos_account" {
  name                = "pagopa-${var.env_short}-${var.location_short}-${var.domain}-cosmos-account"
  resource_group_name = "pagopa-${var.env_short}-${var.location_short}-${var.domain}-db-rg"
}

data "azurerm_storage_account" "notices_storage_sa" {
  name                = replace("${var.domain}-notices", "-", "")
  resource_group_name = "pagopa-${var.env_short}-${var.location_short}-${var.domain}-rg"
}

data "azurerm_storage_account" "templates_storage_sa" {
  name                = replace("${var.domain}-templates", "-", "")
  resource_group_name = "pagopa-${var.env_short}-${var.location_short}-${var.domain}-rg"
}

data "azurerm_storage_account" "institutions_storage_sa" {
  name                = replace("${var.domain}-institutions", "-", "")
  resource_group_name = "pagopa-${var.env_short}-${var.location_short}-${var.domain}-rg"
}

data "azurerm_api_management" "apim" {
  name                = "${var.prefix}-${var.env_short}-apim"
  resource_group_name = "${var.prefix}-${var.env_short}-api-rg"
}

data "azurerm_api_management_product" "pdf_engine_product" {
  product_id          = "pdf-engine-printit"
  api_management_name = "${local.product}-apim"
  resource_group_name = "${local.product}-api-rg"
}
