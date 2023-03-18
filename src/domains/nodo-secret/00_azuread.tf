# Azure AD
data "azuread_group" "adgroup_admin" {
  display_name = "${local.product_noenv}-adgroup-admin"
}

data "azuread_group" "adgroup_developers" {
  display_name = "${local.product_noenv}-adgroup-developers"
}

data "azuread_group" "adgroup_externals" {
  display_name = "${local.product_noenv}-adgroup-externals"
}

data "azuread_group" "adgroup_security" {
  display_name = "${local.product_noenv}-adgroup-security"
}