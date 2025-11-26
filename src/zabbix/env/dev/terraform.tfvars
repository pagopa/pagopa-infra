# general
prefix         = "pagopa"
env_short      = "d"
env            = "dev"
location       = "westeurope"
location_short = "weu"
domain         = "zabbix"

tags = {
  CreatedBy   = "Terraform"
  Environment = "Dev"
  Owner       = "pagoPA"
  Source      = "https://github.com/pagopa/cstar-infrastructure"
  CostCenter  = "TS310 - PAGAMENTI & SERVIZI"
}

# zabbix
cidr_subnet_pg_flex_zabbix = ["10.1.254.0/24"]

#
# Feature Flag
#
is_resource = {
  zabbix_pgflexi_enabled = true
  zabbix_kv_enabled      = true
}

force = "v1"

