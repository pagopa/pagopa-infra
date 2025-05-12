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
  domain      = "core"
}

dns_forwarder_backup_image_version = "v5"
azdo_agent_image_version           = "v4"
