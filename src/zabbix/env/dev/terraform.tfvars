# general
prefix         = "cstar"
env_short      = "d"
env            = "dev"
location       = "westeurope"
location_short = "weu"
domain         = "zabbix"

tags = {
  CreatedBy   = "Terraform"
  Environment = "Dev"
  Owner       = "cstar"
  Source      = "https://github.com/pagopa/cstar-infrastructure"
  CostCenter  = "TS310 - PAGAMENTI & SERVIZI"
}

cidr_subnet_pg_flex_zabbix = ["10.1.249.0/24"]
cidr_subnet_zabbix_server  = ["10.1.250.0/24"]


image_rg_name = "cstar-d-azdoa-rg"
image_name    = "cstar-d-azdo-agent-ubuntu2204-image-v2"

#
# Feature Flag
#
is_resource = {
  zabbix_pgflexi_enabled = true
}

aks_name                = "cstar-d-weu-dev01-aks"
aks_resource_group_name = "cstar-d-weu-dev01-aks-rg"
