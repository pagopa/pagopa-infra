# Recovery job requests, lifecycle state and progress summaries.
resource "azurerm_storage_table" "fdr_recovery_jobs" {
  name                 = "fdrrecoveryjobs"
  storage_account_name = module.fdr_conversion_sa.name
}

# Daily discovery checkpoints and individual recovery work items.
resource "azurerm_storage_table" "fdr_recovery_items" {
  name                 = "fdrrecoveryitems"
  storage_account_name = module.fdr_conversion_sa.name
}

# Blob leases used to coordinate recovery workers.
resource "azurerm_storage_container" "fdr_recovery_locks" {
  name                  = "fdr-recovery-locks"
  storage_account_id    = module.fdr_conversion_sa.id
  container_access_type = "private"
}