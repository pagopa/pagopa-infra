resource "azurerm_application_gateway" "this" {
  name                = var.name
  resource_group_name = var.resource_group_name
  location            = var.location

  sku {
    name = var.sku_name
    tier = var.sku_tier
  }

  gateway_ip_configuration {
    name      = format("%s-snet-conf", var.name)
    subnet_id = var.subnet_id
  }

  frontend_ip_configuration {
    name                 = format("%s-ip-conf", var.name)
    public_ip_address_id = var.public_ip_id
  }


  dynamic "backend_address_pool" {
    for_each = var.backends
    iterator = backend
    content {
      name         = format("%s-address-pool", backend.key)
      fqdns        = backend.value.ip_addresses == null ? [backend.value.host] : null
      ip_addresses = backend.value.ip_addresses
    }
  }

  dynamic "backend_http_settings" {
    for_each = var.backends
    iterator = backend

    content {
      name                  = format("%s-http-settings", backend.key)
      host_name             = backend.value.host
      cookie_based_affinity = "Disabled"
      path                  = ""
      port                  = backend.value.port
      protocol              = backend.value.protocol
      request_timeout       = 60
      probe_name            = backend.value.probe_name
    }
  }

  dynamic "probe" {
    for_each = var.backends
    iterator = backend

    content {
      host                                      = backend.value.host
      minimum_servers                           = 0
      name                                      = format("probe-%s", backend.key)
      path                                      = backend.value.probe
      pick_host_name_from_backend_http_settings = false
      protocol                                  = backend.value.protocol
      timeout                                   = 30
      interval                                  = 30
      unhealthy_threshold                       = 3

      match {
        status_code = ["200-399"]
      }
    }
  }

  dynamic "frontend_port" {
    for_each = distinct([for listener in values(var.listeners) : listener.port])

    content {
      name = format("%s-%d-port", var.name, frontend_port.value)
      port = frontend_port.value
    }
  }

  dynamic "ssl_certificate" {
    for_each = var.listeners
    iterator = listener

    content {
      name                = listener.value.certificate.name
      key_vault_secret_id = listener.value.certificate.id
    }
  }

  dynamic "http_listener" {
    for_each = var.listeners
    iterator = listener

    content {
      name                           = format("%s-listener", listener.key)
      frontend_ip_configuration_name = format("%s-ip-conf", var.name)
      frontend_port_name             = format("%s-%d-port", var.name, listener.value.port)
      protocol                       = "Https"
      ssl_certificate_name           = listener.value.certificate.name
      require_sni                    = true
      host_name                      = listener.value.host
    }
  }

  dynamic "request_routing_rule" {
    for_each = var.routes
    iterator = route

    content {
      name                       = format("%s-reqs-routing-rule", route.key)
      rule_type                  = "Basic"
      http_listener_name         = format("%s-listener", route.value.listener)
      backend_address_pool_name  = format("%s-address-pool", route.value.backend)
      backend_http_settings_name = format("%s-http-settings", route.value.backend)
    }
  }


  identity {
    type         = "UserAssigned"
    identity_ids = var.identity_ids
  }

  ssl_policy {
    policy_type = "Predefined"
    policy_name = "AppGwSslPolicy20170401S"
  }

  waf_configuration {
    enabled                  = true
    firewall_mode            = "Detection"
    rule_set_type            = "OWASP"
    rule_set_version         = "3.1"
    request_body_check       = true
    file_upload_limit_mb     = 100
    max_request_body_size_kb = 128
  }

  autoscale_configuration {
    min_capacity = var.app_gateway_min_capacity
    max_capacity = var.app_gateway_max_capacity
  }

  tags = var.tags
}
