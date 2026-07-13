# Azure AD
data "azuread_group" "adgroup_admin" {
  display_name = "${local.product}-adgroup-admin"
}

data "azuread_group" "adgroup_developers" {
  display_name = "${local.product}-adgroup-developers"
}

data "azuread_group" "adgroup_externals" {
  display_name = "${local.product}-adgroup-externals"
}

data "azuread_group" "adgroup_security" {
  display_name = "${local.product}-adgroup-security"
}

data "azuread_group" "adgroup_admin_dev" {
  display_name = "${local.product}-adgroup-admin-dev"
}

data "azuread_group" "adgroup_developer_externals" {
  count        = var.env_short != "p" ? 1 : 0
  display_name = "${local.product}-adgroup-developer-externals"
}
