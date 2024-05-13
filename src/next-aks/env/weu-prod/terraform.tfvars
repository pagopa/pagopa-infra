# general
prefix          = "pagopa"
env_short       = "p"
env             = "prod"
domain          = "prod"
location        = "westeurope"
location_short  = "weu"
location_string = "West Europe"

tags = {
  CreatedBy   = "Terraform"
  Environment = "Prod"
  Owner       = "pagoPA"
  Source      = "https://github.com/pagopa/pagopa-infra"
  CostCenter  = "TS310 - PAGAMENTI & SERVIZI"
}

enable_velero_backup            = true
velero_sa_backup_enabled        = true
velero_sa_backup_retention_days = 15
