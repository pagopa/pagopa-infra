data "azurerm_container_app_environment" "private_hub_env" {
  name                = local.container_app_dns_forwarder_environment_name
  resource_group_name = data.azurerm_resource_group.rg_vnet_core.name
}

#
# dns
#
resource "azurerm_container_app" "dns_forwarder" {
  name                         = "dns_forwarder"
  container_app_environment_id = data.azurerm_container_app_environment.private_hub_env.id
  resource_group_name          = data.azurerm_resource_group.rg_vnet_core.name
  revision_mode                = "Single"

  template {
    min_replicas = 1
    max_replicas = 1

    container {
      name   = "dns"
      image  = "coredns/coredns:1.10.1@sha256:be7652ce0b43b1339f3d14d9b14af9f588578011092c1f7893bd55432d83a378"
      cpu    = 0.5
      memory = "1Gi"
    }
  }

  ingress {
    external_enabled = false
    target_port      = 3000
    traffic_weight {
      latest_revision = true
      percentage      = 100
    }
  }

  dapr {
    app_id   = "backend"
    app_port = 3000
  }

  depends_on = [
    data.azurerm_container_app_environment.private_hub_env
  ]
}
