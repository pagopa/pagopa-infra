# general
env_short = "u"
env       = "uat"
enabled_features = {
  vnet_ita = false
}


# networking

# common
cidr_subnet_postgresql = ["10.1.129.0/24"]
external_domain        = "pagopa.it"
dns_zone_prefix        = "uat.platform"
dns_zone_prefix_prf    = "prf.platform"


# postgresql
postgres_private_endpoint_enabled = false

# ecommerce ingress hostname
ecommerce_ingress_hostname = "weuuat.ecommerce.internal.uat.platform.pagopa.it"


# WISP-dismantling-cfg
create_wisp_converter = true
