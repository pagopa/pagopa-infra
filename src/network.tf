resource "azurerm_resource_group" "rg_vnet" {
  name     = format("%s-vnet-rg", local.project)
  location = var.location

  tags = var.tags
}

# vnet integration
module "vnet_integration" {
  source              = "git::https://github.com/pagopa/azurerm.git//virtual_network?ref=v1.0.26"
  name                = format("%s-integration-vnet", local.project)
  location            = azurerm_resource_group.rg_vnet.location
  resource_group_name = azurerm_resource_group.rg_vnet.name
  address_space       = var.cidr_integration_vnet

  tags = var.tags
}

module "vnet" {
  source              = "git::https://github.com/pagopa/azurerm.git//virtual_network?ref=v1.0.7"
  name                = format("%s-vnet", local.project)
  location            = azurerm_resource_group.rg_vnet.location
  resource_group_name = azurerm_resource_group.rg_vnet.name
  address_space       = var.cidr_vnet

  tags = var.tags

}

module "vnet_app" {
  source              = "git::https://github.com/pagopa/azurerm.git//virtual_network?ref=v1.0.7"
  name                = format("%s-vnetapi", local.project)
  location            = azurerm_resource_group.rg_vnet.location
  resource_group_name = azurerm_resource_group.rg_vnet.name
  address_space       = var.cidr_vnet_app

  tags = var.tags

}

# APIM subnet
module "apim_snet" {
  source               = "git::https://github.com/pagopa/azurerm.git//subnet?ref=v1.0.7"
  name                 = format("%s-apim-snet", local.project)
  resource_group_name  = azurerm_resource_group.rg_vnet.name
  virtual_network_name = module.vnet_integration.name
  address_prefixes     = var.cidr_subnet_apim

  service_endpoints = ["Microsoft.Web"]

  enforce_private_link_endpoint_network_policies = true
}

## Database subnet
module "redis_snet" {
  source               = "git::https://github.com/pagopa/azurerm.git//subnet?ref=v1.0.7"
  count                = var.redis_sku_name == "Premium" && length(var.cidr_subnet_redis) > 0 ? 1 : 0
  name                 = format("%s-redis-snet", local.project)
  address_prefixes     = var.cidr_subnet_redis
  resource_group_name  = azurerm_resource_group.rg_vnet.name
  virtual_network_name = module.vnet.name
}


# appservice_snet subnet 
module "appservice_snet" {
  source                                         = "git::https://github.com/pagopa/azurerm.git//subnet?ref=v1.0.7"
  name                                           = format("%s-appservice-snet", local.project)
  address_prefixes                               = var.cidr_subnet_appservice
  resource_group_name                            = azurerm_resource_group.rg_vnet.name

  virtual_network_name                           = module.vnet.name
  enforce_private_link_endpoint_network_policies = true
#   delegation = {
#     name = "delegation"
#     service_delegation = {
#       name    = "Microsoft.ContainerInstance/containerGroups"
#       actions = ["Microsoft.Network/virtualNetworks/subnets/action"]
#     }
#   }

  delegation = {
    name = "default"
    service_delegation = {
      name    = "Microsoft.Web/serverFarms"
      actions = ["Microsoft.Network/virtualNetworks/subnets/action"]
    }
  }  

}


# Subnet to host the application gateway
module "appgateway-snet" {
  source               = "git::https://github.com/pagopa/azurerm.git//subnet?ref=v1.0.7"
  name                 = format("%s-appgateway-snet", local.project)
  address_prefixes     = var.cidr_subnet_appgateway
  resource_group_name  = azurerm_resource_group.rg_vnet.name
  virtual_network_name = module.vnet.name
}

## Application gateway public ip ##
resource "azurerm_public_ip" "apigateway_public_ip" {
  name                = format("%s-appgateway-pip", local.project)
  resource_group_name = azurerm_resource_group.rg_vnet.name
  location            = azurerm_resource_group.rg_vnet.location
  sku                 = "Standard"
  allocation_method   = "Static"

  tags = var.tags
}

## Application gateway ## 
# Since these variables are re-used - a locals block makes this more maintainable
locals {
  backend_address_pool_name       = format("%s-appgw-be-address-pool", local.project)
  frontend_http_port_name         = format("%s-appgw-fe-http-port", local.project)
  frontend_https_port_name        = format("%s-appgw-fe-https-port", local.project)
  frontend_ip_configuration_name  = format("%s-appgw-fe-ip-configuration", local.project)
  http_setting_name               = format("%s-appgw-be-http-settings", local.project)
  http_listener_name              = format("%s-appgw-fe-http-settings", local.project)
  https_listener_name             = format("%s-appgw-fe-https-settings", local.project)
  http_request_routing_rule_name  = format("%s-appgw-http-reqs-routing-rule", local.project)
  https_request_routing_rule_name = format("%s-appgw-https-reqs-routing-rule", local.project)
  acme_le_ssl_cert_name           = format("%s-appgw-acme-le-ssl-cert", local.project)
  http_to_https_redirect_rule     = format("%s-appgw-http-to-https-redirect-rule", local.project)
}

# fixme
# Application gateway: Multilistener configuraiton
# module "app_gw" {
#   source = "./modules/app_gw"

#   resource_group_name = azurerm_resource_group.rg_vnet.name
#   location            = azurerm_resource_group.rg_vnet.location
#   name                = format("%s-app-gw", local.project)

#   # SKU
#   sku_name = "WAF_v2"
#   sku_tier = "WAF_v2"

#   # Networking
#   subnet_id    = module.appgateway-snet.id
#   public_ip_id = azurerm_public_ip.apigateway_public_ip.id

#   # Configure backends
#   backends = {
#     apim = {
#       protocol     = "Https"
#       host         = trim(azurerm_dns_a_record.dns_a_appgw_api.fqdn, ".")
#       port         = 443
#       ip_addresses = module.apim.private_ip_addresses
#       probe        = "/status-0123456789abcdef"
#       probe_name   = "probe-apim"
#     }

#     # fixme
#     # portal = {
#     #   protocol     = "Https"
#     #   host         = trim(azurerm_dns_a_record.dns_a_apim_dev_portal.fqdn, ".")
#     #   port         = 443
#     #   ip_addresses = module.apim.private_ip_addresses
#     #   probe        = "/signin"
#     #   probe_name   = "probe-portal"
#     # }

#     # fixme
#     # management = {
#     #   protocol = "Https"
#     #   #TODO : once the migration is completed there wouldn't be need of the condition below.
#     #   #       Only the first dns recors is required.
#     #   host         = var.env_short != "p" ? trim(azurerm_dns_a_record.dns-a-managementcstar[0].fqdn, ".") : trim(azurerm_dns_a_record.dns-a-management-production-cstar[0].fqdn, ".")
#     #   port         = 443
#     #   ip_addresses = module.apim.private_ip_addresses
#     #   probe        = "/ServiceStatus"
#     #   probe_name   = "probe-management"
#     # }
#   }

#   # Configure listeners
#   listeners = {
#     mockec = {
#       protocol = "Https"
#       host     = var.env_short == "p" ? "api.services.pagopa.it" : format("api.%s.services.pagopa.it", lower(var.tags["Environment"]))
#       port     = 443

#     # fixme
#     #   certificate = {
#     #     name = var.app_gateway_api_certificate_name
#     #     id = trimsuffix(
#     #       data.azurerm_key_vault_certificate.app_gw_mockec.secret_id,
#     #       data.azurerm_key_vault_certificate.app_gw_mockec.version
#     #     )
#     #   }
#     }

#     portal = {
#       protocol = "Https"
#       host     = var.env_short == "p" ? "portal.services.pagopa.it" : format("portal.%s.services.pagopa.it", lower(var.tags["Environment"]))
#       port     = 443

#     # fixme
#     #   certificate = {
#     #     name = var.app_gateway_portal_certificate_name
#     #     id = trimsuffix(
#     #       data.azurerm_key_vault_certificate.portal_cstar.secret_id,
#     #       data.azurerm_key_vault_certificate.portal_cstar.version
#     #     )
#     #   }
#     }

#     management = {
#       protocol = "Https"
#       host     = var.env_short == "p" ? "management.services.pagopa.it" : format("management.%s.services.pagopa.it", lower(var.tags["Environment"]))
#       port     = 443

#     # fixme
#     #   #TODO: add self signed cert support as above.
#     #   certificate = {
#     #     name = var.app_gateway_management_certificate_name
#     #     id = trimsuffix(
#     #       data.azurerm_key_vault_certificate.management_cstar.secret_id,
#     #       data.azurerm_key_vault_certificate.management_cstar.version
#     #     )
#     #   }
#     }
#   }

#   # maps listener to backend
#   routes = {

#     broker = {
#       listener = "mockec"
#       backend  = "apim"
#     }

#     portal = {
#       listener = "portal"
#       backend  = "portal"
#     }

#     mangement = {
#       listener = "management"
#       backend  = "management"
#     }
#   }


#   # TLS
#   identity_ids = [azurerm_user_assigned_identity.appgateway.id]

#   # Scaling
#   app_gateway_min_capacity = "1"
#   app_gateway_max_capacity = "2"


#   tags = var.tags
# }
