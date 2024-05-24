# general
prefix         = "pagopa"
env_short      = "d"
env            = "dev"
location       = "westeurope"
location_short = "weu"
domain         = "packer"

tags = {
  CreatedBy   = "Terraform"
  Environment = "Dev"
  Owner       = "pagopa"
  Source      = "https://github.com/pagopa/pagopa-infra"
  CostCenter  = "TS310 - PAGAMENTI & SERVIZI"
}

dns_forwarder_backup_image_version = "v5"
azdo_agent_image_version           = "v3"
