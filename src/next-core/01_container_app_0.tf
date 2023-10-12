

resource "null_resource" "update_az_cli" {
  triggers = {
    env_name                                   = local.container_app_dns_forwarder_environment_name
    rg                                         = data.azurerm_resource_group.rg_vnet_core.name
    log_analytics_id                           = data.azurerm_log_analytics_workspace.log_analytics.workspace_id
    log_analytics_workspace_primary_shared_key = data.azurerm_log_analytics_workspace.log_analytics.primary_shared_key
  }

  provisioner "local-exec" {
    command = <<EOT
      az extension add --name containerapp --upgrade
      az provider register --namespace Microsoft.App
      az provider register --namespace Microsoft.OperationalInsights
    EOT
  }
}
