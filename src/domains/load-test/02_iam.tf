data "azuread_group" "adgroup_developers" {
  display_name = "${local.product}-adgroup-developers"
}
data "azuread_group" "adgroup_externals" {
  display_name = "${local.product}-adgroup-externals"
}
data "azuread_group" "adgroup_operations" {
  display_name = "${local.product}-adgroup-operations"
}
data "azuread_group" "adgroup_technical_project_managers" {
  display_name = "${local.product}-adgroup-technical-project-managers"
}

locals {
  # How to share an Azure Managed Grafana instance
  # https://learn.microsoft.com/en-us/azure/managed-grafana/how-to-share-grafana-workspace#assign-an-admin-viewer-or-editor-role-to-a-user

  grafana_admins = [
    data.azuread_group.adgroup_developers.id,
  ]

  grafana_editors = [
    data.azuread_group.adgroup_technical_project_managers.id,
  ]

  grafana_viewers = [
    data.azuread_group.adgroup_operations.id,
    data.azuread_group.adgroup_externals.id,
  ]
}

resource "azurerm_role_assignment" "adgroup_devevelopers_to_grafana_admin" {
  for_each = toset(local.grafana_admins)

  scope                = data.azurerm_subscription.current.id
  role_definition_name = "Grafana Admin"
  principal_id         = each.key
}

resource "azurerm_role_assignment" "adgroup_devevelopers_to_grafana_editor" {
  for_each = toset(local.grafana_editors)

  scope                = data.azurerm_subscription.current.id
  role_definition_name = "Grafana Editor"
  principal_id         = each.key
}

resource "azurerm_role_assignment" "adgroup_devevelopers_to_grafana_viewer" {
  for_each = toset(local.grafana_viewers)

  scope                = data.azurerm_subscription.current.id
  role_definition_name = "Grafana Viewer"
  principal_id         = each.key
}
