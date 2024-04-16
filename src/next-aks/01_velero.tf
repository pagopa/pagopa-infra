resource "azurerm_resource_group" "rg_velero_backup" {
  count    = var.enable_velero_backup ? 1 : 0
  name     = "${local.product}-aks-velero"
  location = var.location
  tags     = var.tags
}



module "velero" {
  source = "git::https://github.com/pagopa/terraform-azurerm-v3.git//kubernetes_cluster_velero?ref=v7.31.0"

  count = var.enable_velero_backup ? 1 : 0

  # required
  backup_storage_container_name = "velero-backup"
  resource_group_name           = azurerm_resource_group.rg_velero_backup[0].name
  subscription_id               = data.azurerm_subscription.current.subscription_id
  tenant_id                     = data.azurerm_subscription.current.tenant_id
  prefix                        = var.prefix
  location                      = var.location
  aks_cluster_name              = local.aks_name
  aks_cluster_rg                = data.azurerm_resource_group.aks_rg.name

  storage_account_replication_type = var.velero_backup_sa_replication_type

  use_storage_private_endpoint = true

  # required if use_storage_private_endpoint = true
  storage_account_private_dns_zone_id = data.azurerm_private_dns_zone.storage_account_private_dns_zone.id
  private_endpoint_subnet_id          = data.azurerm_subnet.private_endpoint_subnet.id

  enable_sa_backup         = var.velero_sa_backup_enabled
  sa_backup_retention_days = var.velero_sa_backup_retention_days


  tags = var.tags
}


module "aks_namespace_backup" {
  count = var.enable_velero_backup ? 1 : 0

  source = "git::https://github.com/pagopa/terraform-azurerm-v3.git//kubernetes_velero_backup?ref=v7.68.0"

  cluster_id = data.azurerm_kubernetes_cluster.weu_aks.id
  location   = var.location
  prefix     = var.prefix
  rg_name    = azurerm_resource_group.rg_velero_backup[0].name

  aks_cluster_name = local.aks_name
  backup_name      = "daily-backup"
  namespaces       = ["ALL"]
  action_group_ids = [data.azurerm_monitor_action_group.slack.id, data.azurerm_monitor_action_group.email.id]
  alert_severity   = 2

  ttl             = var.velero_backup_ttl
  schedule        = var.velero_backup_schedule
  volume_snapshot = false

  tags = var.tags

  depends_on = [module.velero]
}


module "aks_single_namespace_backup" {
  count = var.enable_velero_backup ? 1 : 0

  source = "git::https://github.com/pagopa/terraform-azurerm-v3.git//kubernetes_velero_backup?ref=v7.68.0"

  cluster_id = data.azurerm_kubernetes_cluster.weu_aks.id
  location   = var.location
  prefix     = var.prefix
  rg_name    = azurerm_resource_group.rg_velero_backup[0].name

  aks_cluster_name = local.aks_name
  backup_name      = "daily-backup"
  namespaces       = data.kubernetes_all_namespaces.all_ns.namespaces
  action_group_ids = [data.azurerm_monitor_action_group.slack.id, data.azurerm_monitor_action_group.email.id]
  alert_severity   = 2

  ttl             = var.velero_backup_ttl
  schedule        = var.velero_backup_schedule
  volume_snapshot = false

  tags = var.tags

  depends_on = [module.velero]
}
