resource "azurerm_resource_group" "tf_audit_rg" {
  location = var.location
  name     = "${local.project}-rg"
}

module "tf_audit_logic_app" {
  source = "./.terraform/modules/__v4__/tf_audit_logic_app"

  location            = var.location
  name              = local.project
  prefix = "${upper(local.prefix)} 💰"
  resource_group_name = azurerm_resource_group.tf_audit_rg.name
  slack_webhook_url   = module.secret_core.values["tf-audit-slack-webhook-url"].value
  storage_account_settings = {
    name       = var.audit_sa.name
    table_name = var.audit_sa.table_name
    access_key = module.secret_core.values["tf-audit-storage-access-key"].value
  }
  tags = module.tag_config.tags
  trigger = {
    interval  = 15
    frequency = "Minute"
  }

}
