resource "azurerm_app_configuration" "selfcare_appconf" {
  name                = "${local.product}-${var.domain}-appconfiguration"
  resource_group_name = azurerm_resource_group.bopagopa_rg.name
  location            = azurerm_resource_group.bopagopa_rg.location
  sku                 = "standard"
}

# ⚠️⚠️⚠️ iif on apply receive error 409 already exist a tricky u be ⚠️⚠️⚠️ :
# 1. sh terraform.sh state weu-<ENV> rm azurerm_role_assignment.selfcare_appconf_dataowner_sp
# 2. remove ✋ from portal pagopa-<ENV>-selfcare-appconfiguration > Role assignments > filter for "App Configuration Data Owner" and removed pagopa-<ENB>-seflcare
resource "azurerm_role_assignment" "selfcare_appconf_dataowner" {
  scope                = azurerm_app_configuration.selfcare_appconf.id
  role_definition_name = "App Configuration Data Owner"
  principal_id         = data.azurerm_client_config.current.object_id
}

resource "azurerm_role_assignment" "selfcare_appconf_dataowner_sp" {
  scope                = azurerm_app_configuration.selfcare_appconf.id
  role_definition_name = "App Configuration Data Owner"
  principal_id         = azuread_service_principal.selfcare.object_id
}

resource "azurerm_app_configuration_feature" "maintenance_banner_flag" {
  configuration_store_id = azurerm_app_configuration.selfcare_appconf.id
  description            = "It enables the banner"
  name                   = "maintenance-banner"
  enabled                = false

  lifecycle {
    ignore_changes = [
      enabled,
      targeting_filter,
      timewindow_filter
    ]
  }
}

resource "azurerm_app_configuration_feature" "maintenance_flag" {
  configuration_store_id = azurerm_app_configuration.selfcare_appconf.id
  description            = "It enables the Maintenance Page"
  name                   = "maintenance"
  enabled                = false

  lifecycle {
    ignore_changes = [
      enabled,
      targeting_filter,
      timewindow_filter
    ]
  }
}

resource "azurerm_app_configuration_feature" "is_operation_flag" {
  configuration_store_id = azurerm_app_configuration.selfcare_appconf.id
  description            = "It enables the operation role"
  name                   = "isOperator"
  enabled                = true
  targeting_filter {
    default_rollout_percentage = 0
    groups {
      name               = "@pagopa.it"
      rollout_percentage = 100
    }
  }

  lifecycle {
    ignore_changes = [
      enabled,
      targeting_filter,
      timewindow_filter
    ]
  }
}

resource "azurerm_app_configuration_feature" "commission_bundles_flag" {
  configuration_store_id = azurerm_app_configuration.selfcare_appconf.id
  description            = "It enables the commission bundles"
  name                   = "commission-bundles"
  enabled                = false

  lifecycle {
    ignore_changes = [
      enabled,
      targeting_filter,
      timewindow_filter
    ]
  }
}

resource "azurerm_app_configuration_feature" "commission_bundles_private_flag" {
  configuration_store_id = azurerm_app_configuration.selfcare_appconf.id
  description            = "It enables the commission bundles of type PRIVATE"
  name                   = "commission-bundles-private"
  enabled                = false

  lifecycle {
    ignore_changes = [
      enabled,
      targeting_filter,
      timewindow_filter
    ]
  }
}

resource "azurerm_app_configuration_feature" "commission_bundles_public_flag" {
  configuration_store_id = azurerm_app_configuration.selfcare_appconf.id
  description            = "It enables the commission bundles of type PUBLIC"
  name                   = "commission-bundles-public"
  enabled                = false

  lifecycle {
    ignore_changes = [
      enabled,
      targeting_filter,
      timewindow_filter
    ]
  }
}

resource "azurerm_app_configuration_feature" "delegations_list_flag" {
  configuration_store_id = azurerm_app_configuration.selfcare_appconf.id
  description            = "It enables the credit institution's delegations' page"
  name                   = "delegations-list"
  enabled                = false

  lifecycle {
    ignore_changes = [
      enabled,
      targeting_filter,
      timewindow_filter
    ]
  }
}

resource "azurerm_app_configuration_feature" "payments_receipts_flag" {
  configuration_store_id = azurerm_app_configuration.selfcare_appconf.id
  description            = "It enables the payments receipts' page"
  name                   = "payments-receipts"
  enabled                = false

  lifecycle {
    ignore_changes = [
      enabled,
      targeting_filter,
      timewindow_filter
    ]
  }
}

resource "azurerm_app_configuration_feature" "test_stations_flag" {
  configuration_store_id = azurerm_app_configuration.selfcare_appconf.id
  description            = "It enables the station testing"
  name                   = "test-stations"
  enabled                = false

  lifecycle {
    ignore_changes = [
      enabled,
      targeting_filter,
      timewindow_filter
    ]
  }
}

resource "azurerm_app_configuration_feature" "payment_notices_flag" {
  configuration_store_id = azurerm_app_configuration.selfcare_appconf.id
  description            = "It enables the payment notice section"
  name                   = "payment-notices"
  enabled                = false

  lifecycle {
    ignore_changes = [
      enabled,
      targeting_filter,
      timewindow_filter
    ]
  }
}

resource "azurerm_app_configuration_feature" "station_maintenances_flag" {
  configuration_store_id = azurerm_app_configuration.selfcare_appconf.id
  description            = "It enables the Station Maintenance's page"
  name                   = "station-maintenances"
  enabled                = false

  lifecycle {
    ignore_changes = [
      enabled,
      targeting_filter,
      timewindow_filter
    ]
  }
}

resource "azurerm_app_configuration_feature" "station-rest-section" {
  configuration_store_id = azurerm_app_configuration.selfcare_appconf.id
  description            = "It shows the REST endpoint section for Stations"
  name                   = "station-rest-section"
  enabled                = false

  lifecycle {
    ignore_changes = [
      enabled,
      targeting_filter,
      timewindow_filter
    ]
  }
}

resource "azurerm_app_configuration_feature" "station-odp-service" {
  configuration_store_id = azurerm_app_configuration.selfcare_appconf.id
  description            = "It shows the Payment Options service flag for Stations"
  name                   = "station-odp-service"
  enabled                = false

  lifecycle {
    ignore_changes = [
      enabled,
      targeting_filter,
      timewindow_filter
    ]
  }
}

resource "azurerm_app_configuration_feature" "quicksight_dashboard_flag" {
  configuration_store_id = azurerm_app_configuration.selfcare_appconf.id
  description            = "It enables the quicksight dashboard"
  name                   = "quicksight-dashboard"
  enabled                = false

  lifecycle {
    ignore_changes = [
      enabled,
      targeting_filter,
      timewindow_filter
    ]
  }
}

resource "azurerm_app_configuration_feature" "quicksight_product_free_trial" {
  configuration_store_id = azurerm_app_configuration.selfcare_appconf.id
  description            = "It disable the quicksight dashboard product's subscription check"
  name                   = "quicksight-product-free-trial"
  enabled                = false

  lifecycle {
    ignore_changes = [
      enabled,
      targeting_filter,
      timewindow_filter
    ]
  }
}
