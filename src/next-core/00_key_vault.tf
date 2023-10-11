# data "azurerm_key_vault" "kv_domain" {
#   name                = "${local.product}-${var.domain}-kv"
#   resource_group_name = "${local.product}-${var.domain}-sec-rg"
# }

# module "domain_key_vault_secrets_query" {
#   source = "git::https://github.com/pagopa/terraform-azurerm-v3.git//key_vault_secrets_query?ref=v5.3.0"

#   key_vault_name = local.key_vault_domain_name
#   resource_group = local.key_vault_domain_resource_group

#   secrets = [
#     "dvopla-d-appinsights-connection-string"
#   ]
# }
