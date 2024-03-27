# general
prefix         = "pagopa"
env_short      = "p"
env            = "prod"
location       = "westeurope"
location_short = "weu"
domain         = "packer"

tags = {
  CreatedBy   = "Terraform"
  Environment = "Prod"
  Owner       = "pagopa"
  Source      = "https://github.com/pagopa/pagopa-infra"
  CostCenter  = "TS310 - PAGAMENTI & SERVIZI"
}

dns_forwarder_backup_image_version = "v1"
