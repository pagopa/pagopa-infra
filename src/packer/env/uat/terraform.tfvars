# general
prefix         = "pagopa"
env_short      = "u"
env            = "uat"
location       = "westeurope"
location_short = "weu"
domain         = "packer"

tags = {
  CreatedBy   = "Terraform"
  Environment = "Uat"
  Owner       = "pagopa"
  Source      = "https://github.com/pagopa/pagopa-infra"
  CostCenter  = "TS310 - PAGAMENTI & SERVIZI"
}

dns_forwarder_backup_image_version = "v5"
azdo_agent_image_version           = "v3"
