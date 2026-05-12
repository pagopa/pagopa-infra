resource "azurerm_resource_group" "rg_velero_backup" {
  count    = var.enable_velero ? 1 : 0
  name     = "${local.product}-aks-velero"
  location = var.location
  tags     = module.tag_config.tags
}


# Workload identity init
module "velero_workload_identity_init" {
  source                                = "./.terraform/modules/__v4__/kubernetes_workload_identity_init"
  count                                 = var.enable_velero ? 1 : 0
  workload_identity_location            = var.location
  workload_identity_name_prefix         = "velero"
  workload_identity_resource_group_name = azurerm_resource_group.rg_velero_backup[0].name
}

resource "kubernetes_namespace" "velero_namespace" {
  count = var.enable_velero ? 1 : 0
  metadata {
    name = "velero"
  }
}

module "velero" {
  source     = "./.terraform/modules/__v4__/kubernetes_cluster_velero"
  depends_on = [kubernetes_namespace.velero_namespace]
  count      = var.enable_velero ? 1 : 0

  # required
  subscription_id                  = data.azurerm_subscription.current.subscription_id
  prefix                           = var.env_short == "p" ? var.prefix : "${var.prefix}-${var.env_short}"
  location                         = var.location
  aks_cluster_name                 = local.aks_name
  aks_cluster_rg                   = data.azurerm_resource_group.aks_rg.name
  namespace_name                   = kubernetes_namespace.velero_namespace[0].metadata[0].name
  storage_account_replication_type = var.velero_backup_sa_replication_type

  use_storage_private_endpoint = true

  # required if use_storage_private_endpoint = true
  storage_account_private_dns_zone_id = data.azurerm_private_dns_zone.storage_account_private_dns_zone.id
  private_endpoint_subnet_id          = data.azurerm_subnet.private_endpoint_subnet.id

  enable_sa_backup         = var.velero_sa_backup_enabled
  sa_backup_retention_days = var.velero_sa_backup_retention_days

  key_vault_id                          = data.azurerm_key_vault.kv.id
  storage_account_resource_group_name   = azurerm_resource_group.rg_velero_backup[0].name
  workload_identity_name                = module.velero_workload_identity_init[0].user_assigned_identity_name
  workload_identity_resource_group_name = azurerm_resource_group.rg_velero_backup[0].name

  tags = module.tag_config.tags
}


module "aks_namespace_backup" {
  count = var.enable_velero_backup ? 1 : 0

  source = "./.terraform/modules/__v4__/kubernetes_velero_backup"

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

  tags = module.tag_config.tags

  depends_on = [module.velero]
}


module "aks_single_namespace_backup" {
  count = var.enable_velero_backup ? 1 : 0

  source = "./.terraform/modules/__v4__/kubernetes_velero_backup"

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
  schedule        = var.velero_backup_single_namespace_schedule
  volume_snapshot = false

  tags = module.tag_config.tags

  depends_on = [module.velero]
}
