resource "azurerm_resource_group" "rg_vnet" {
  name     = format("%s-vnet-rg", local.project)
  location = var.location

  tags = var.tags
}

# vnet
module "vnet" {
  source              = "git::https://github.com/pagopa/azurerm.git//virtual_network?ref=v1.0.51"
  name                = format("%s-vnet", local.project)
  location            = azurerm_resource_group.rg_vnet.location
  resource_group_name = azurerm_resource_group.rg_vnet.name
  address_space       = var.cidr_vnet

  tags = var.tags
}

# vnet integration
module "vnet_integration" {
  source              = "git::https://github.com/pagopa/azurerm.git//virtual_network?ref=v1.0.51"
  name                = format("%s-vnet-integration", local.project)
  location            = azurerm_resource_group.rg_vnet.location
  resource_group_name = azurerm_resource_group.rg_vnet.name
  address_space       = var.cidr_vnet_integration

  tags = var.tags
}


## Peering between the vnet(main) and integration vnet 
module "vnet_peering" {
  source = "git::https://github.com/pagopa/azurerm.git//virtual_network_peering?ref=v1.0.30"

  location = azurerm_resource_group.rg_vnet.location

  source_resource_group_name       = azurerm_resource_group.rg_vnet.name
  source_virtual_network_name      = module.vnet.name
  source_remote_virtual_network_id = module.vnet.id
  source_allow_gateway_transit     = true # needed by vpn gateway for enabling routing from vnet to vnet_integration
  target_resource_group_name       = azurerm_resource_group.rg_vnet.name
  target_virtual_network_name      = module.vnet_integration.name
  target_remote_virtual_network_id = module.vnet_integration.id
  target_use_remote_gateways       = false # needed by vnet peering with SIA
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

# Subnet to host the application gateway
module "appgateway-snet" {
  source               = "git::https://github.com/pagopa/azurerm.git//subnet?ref=v1.0.7"
  name                 = format("%s-appgateway-snet", local.project)
  address_prefixes     = var.cidr_subnet_appgateway
  resource_group_name  = azurerm_resource_group.rg_vnet.name
  virtual_network_name = module.vnet.name
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

# Application gateway: Multilistener configuraiton
module "app_gw" {
  source = "./modules/app_gw"

  resource_group_name = azurerm_resource_group.rg_vnet.name
  location            = azurerm_resource_group.rg_vnet.location
  name                = format("%s-app-gw", local.project)

  # SKU
  sku_name = "WAF_v2"
  sku_tier = "WAF_v2"

  # Networking
  subnet_id    = module.appgateway-snet.id
  public_ip_id = azurerm_public_ip.apigateway_public_ip.id

  # Configure backends
  backends = {
    apim = {
      protocol     = "Https"
      host         = trim(azurerm_dns_a_record.dns_a_api.fqdn, ".")
      port         = 443
      ip_addresses = module.apim.private_ip_addresses
      probe        = "/status-0123456789abcdef"
      probe_name   = "probe-apim"
    }

    portal = {
      protocol     = "Https"
      host         = trim(azurerm_dns_a_record.dns_a_portal.fqdn, ".")
      port         = 443
      ip_addresses = module.apim.private_ip_addresses
      probe        = "/signin"
      probe_name   = "probe-portal"
    }

    management = {
      protocol = "Https"
      #TODO : once the migration is completed there wouldn't be need of the condition below.
      #       Only the first dns recors is required.
      host         = var.env_short != "p" ? trim(azurerm_dns_a_record.dns-a-management[0].fqdn, ".") : trim(azurerm_dns_a_record.dns-a-management[0].fqdn, ".")
      port         = 443
      ip_addresses = module.apim.private_ip_addresses
      probe        = "/ServiceStatus"
      probe_name   = "probe-management"
    }
  }

  ssl_profiles = [{
    name                             = format("%s-issuer-mauth-profile", local.project)
    trusted_client_certificate_names = null # [format("%s-issuer-chain", local.project)]
    verify_client_cert_issuer_dn     = true
    ssl_policy = {
      disabled_protocols = []
      policy_type        = "Predefined"
      policy_name        = "AppGwSslPolicy20170401"
      cipher_suites = [
        "TLS_ECDHE_ECDSA_WITH_AES_128_GCM_SHA256",
        "TLS_ECDHE_ECDSA_WITH_AES_256_GCM_SHA384",
        "TLS_ECDHE_ECDSA_WITH_AES_128_CBC_SHA",
        "TLS_ECDHE_ECDSA_WITH_AES_256_CBC_SHA",
        "TLS_ECDHE_ECDSA_WITH_AES_128_CBC_SHA256",
        "TLS_ECDHE_ECDSA_WITH_AES_256_CBC_SHA384",
        "TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384",
        "TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256",
        "TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA",
        "TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA",
        "TLS_RSA_WITH_AES_256_GCM_SHA384",
        "TLS_RSA_WITH_AES_128_GCM_SHA256",
        "TLS_RSA_WITH_AES_256_CBC_SHA256",
        "TLS_RSA_WITH_AES_128_CBC_SHA256",
        "TLS_RSA_WITH_AES_256_CBC_SHA",
        "TLS_RSA_WITH_AES_128_CBC_SHA",
      ]
      min_protocol_version = "TLSv1_1"
    }
  }]

  trusted_client_certificates = [
    {
      secret_name  = format("platform-%s-issuer-chain", var.env_short)
      key_vault_id = module.key_vault.id
    }
  ]

  # Configure listeners
  listeners = {

    api = {
      protocol         = "Https"
      host             = var.env_short == "p" ? "api.platform.pagopa.it" : format("api.%s.platform.pagopa.it", lower(var.tags["Environment"]))
      port             = 443
      ssl_profile_name = format("%s-issuer-mauth-profile", local.project)
      certificate = {
        name = var.app_gateway_api_certificate_name
        id = trimsuffix(
          data.azurerm_key_vault_certificate.app_gw_platform.secret_id,
          data.azurerm_key_vault_certificate.app_gw_platform.version
        )
      }
    }

    portal = {
      protocol         = "Https"
      host             = var.env_short == "p" ? "portal.platform.pagopa.it" : format("portal.%s.platform.pagopa.it", lower(var.tags["Environment"]))
      port             = 443
      ssl_profile_name = null
      certificate = {
        name = var.app_gateway_portal_certificate_name
        id = trimsuffix(
          data.azurerm_key_vault_certificate.portal_platform.secret_id,
          data.azurerm_key_vault_certificate.portal_platform.version
        )
      }
    }

    management = {
      protocol         = "Https"
      host             = var.env_short == "p" ? "management.platform.pagopa.it" : format("management.%s.platform.pagopa.it", lower(var.tags["Environment"]))
      port             = 443
      ssl_profile_name = null

      certificate = {
        name = var.app_gateway_management_certificate_name
        id = trimsuffix(
          data.azurerm_key_vault_certificate.management_platform.secret_id,
          data.azurerm_key_vault_certificate.management_platform.version
        )
      }
    }
  }

  # maps listener to backend
  routes = {
    api = {
      listener = "api"
      backend  = "apim"
    }

    portal = {
      listener = "portal"
      backend  = "portal"
    }

    mangement = {
      listener = "management"
      backend  = "management"
    }
  }


  # TLS
  identity_ids = [azurerm_user_assigned_identity.appgateway.id]

  # Scaling
  app_gateway_min_capacity = var.app_gateway_min_capacity
  app_gateway_max_capacity = var.app_gateway_max_capacity

  # Logs
  sec_log_analytics_workspace_id = var.env_short == "p" ? data.azurerm_key_vault_secret.sec_workspace_id[0].value : null
  sec_storage_id = var.env_short == "p" ? data.azurerm_key_vault_secret.sec_storage_id[0].value : null

  tags = var.tags
}
