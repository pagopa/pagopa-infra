# general
prefix                            = "pagopa"
env_short                         = "u"
env                               = "uat"
domain                            = "uat"
location                          = "westeurope"
location_short                    = "weu"
location_string                   = "West Europe"
enable_velero_backup              = false
enable_velero                     = true
velero_backup_sa_replication_type = "ZRS"

tags = {
  CreatedBy   = "Terraform"
  Environment = "Uat"
  Owner       = "pagoPA"
  Source      = "https://github.com/pagopa/pagopa-infra"
  CostCenter  = "TS310 - PAGAMENTI & SERVIZI"
}

