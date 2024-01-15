data "azurerm_resource_group" "identity_rg" {
  name = "${local.product}-identity-rg"
}

module "identity_cd" {
  source = "github.com/pagopa/terraform-azurerm-v3//github_federated_identity?ref=v7.28.0"

  prefix    = var.prefix
  env_short = var.env_short

  identity_role = "cd"

  github_federations = var.cd_github_federations

  cd_rbac_roles = {
    subscription_roles = var.environment_cd_roles.subscription
    resource_groups    = var.environment_cd_roles.resource_groups
  }

  tags = var.tags

  depends_on = [
    data.azurerm_resource_group.identity_rg
  ]
}
