prefix         = "pagopa"
env_short      = "d"
env            = "dev"
domain         = "afm"
location       = "westeurope"
location_short = "weu"
instance       = "dev"

tags = {
  CreatedBy   = "Terraform"
  Environment = "Prod"
  Owner       = "IO"
  Source      = "https://github.com/pagopa/pagopa-infra/tree/main/src/afm"
  CostCenter  = "TS310 - PAGAMENTI & SERVIZI"
}

lock_enable = true

terraform_remote_state_core = {
  resource_group_name  = "io-infra-rg"
  storage_account_name = "pagopainfraterraformdev"
  container_name       = "azurermstate"
  key                  = "dev.terraform.tfstate"
}

### External resources

monitor_resource_group_name                 = "pagopa-d-monitor-rg"
log_analytics_workspace_name                = "pagopa-d-law"
log_analytics_workspace_resource_group_name = "pagopa-d-monitor-rg"

external_domain          = "pagopa.it"
dns_zone_internal_prefix = "internal.dev.platform"
apim_dns_zone_prefix     = "dev.platform"
