data "azuread_group" "adgroup_developers" {
  display_name = "${local.product}-adgroup-developers"
}

resource "azurerm_role_assignment" "adgroup_devevelopers_to_grafana_admin" {
  scope                = data.azurerm_subscription.current.id
  role_definition_name = "Grafana Admin"
  principal_id         = data.azuread_group.adgroup_developers.id
}
