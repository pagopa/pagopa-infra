# general
env_short = "d"
env       = "dev"
enabled_features = {
  vnet_ita = true

}


# networking
# main vnet

# common
cidr_subnet_postgresql = ["10.1.129.0/24"]


# specific
# zabbix
external_domain = "pagopa.it"
dns_zone_prefix = "dev.platform"

# postgresql
postgres_private_endpoint_enabled = false


# apim x nodo pagamenti
ecommerce_ingress_hostname = "weudev.ecommerce.internal.dev.platform.pagopa.it"


# WISP-dismantling-cfg
create_wisp_converter = true
