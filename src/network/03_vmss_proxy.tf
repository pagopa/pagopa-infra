resource "azurerm_resource_group" "vmss_rg" {
  name     = format("%s-vmss-rg", local.project)
  location = var.location

  tags = module.tag_config.tags
}

data "azurerm_virtual_network" "vnet_integration" {
  name                = local.vnet_core_name
  resource_group_name = local.vnet_core_resource_group_name
}

module "vmss_snet" {
  source               = "./.terraform/modules/__v4__/IDH/subnet"
  name                 = "${local.project}-vmss-snet"
  resource_group_name  = local.vnet_core_resource_group_name
  virtual_network_name = data.azurerm_virtual_network.vnet_integration.name

  idh_resource_tier = "slash28_privatelink_true"
  product_name      = local.prefix
  env               = var.env

}

module "vmss_pls_snet" {
  source               = "./.terraform/modules/__v4__/IDH/subnet"
  name                 = "${local.project}-pls-snet"
  resource_group_name  = local.vnet_core_resource_group_name
  virtual_network_name = data.azurerm_virtual_network.vnet_integration.name

  idh_resource_tier = "slash28_privatelink_false"
  product_name      = local.prefix
  env               = var.env

}

data "azurerm_key_vault_secret" "vmss_admin_login" {
  name         = "vmss-administrator-login"
  key_vault_id = data.azurerm_key_vault.kv_core.id
}

data "azurerm_key_vault_secret" "vmss_admin_password" {
  name         = "vmss-administrator-password"
  key_vault_id = data.azurerm_key_vault.kv_core.id
}

resource "azurerm_linux_virtual_machine_scale_set" "vmss-egress" {
  name                            = format("%s-vmss", local.project)
  resource_group_name             = azurerm_resource_group.vmss_rg.name
  location                        = azurerm_resource_group.vmss_rg.location
  sku                             = "Standard_D2ds_v5"
  instances                       = 1
  admin_username                  = data.azurerm_key_vault_secret.vmss_admin_login.value
  admin_password                  = data.azurerm_key_vault_secret.vmss_admin_password.value
  disable_password_authentication = false
  zones                           = ["1"]

  source_image_reference {
    publisher = "Canonical"
    offer     = "ubuntu-24_04-lts"
    sku       = "server"
    version   = "latest"
  }

  os_disk {
    storage_account_type = "Standard_LRS"
    caching              = "ReadWrite"
  }

  network_interface {
    name                          = "egress-input"
    primary                       = true
    enable_ip_forwarding          = true
    enable_accelerated_networking = true

    ip_configuration {
      name                                   = "egress-in"
      primary                                = true
      subnet_id                              = module.vmss_snet.id
      load_balancer_backend_address_pool_ids = [module.load_balancer_observ_egress.azurerm_lb_backend_address_pool_id[0]]
    }
  }
  network_interface {
    name                          = "egress-output"
    enable_ip_forwarding          = true
    enable_accelerated_networking = true
    ip_configuration {
      name      = "egress-out"
      primary   = true
      subnet_id = module.vmss_snet.id
    }
  }
}

#
# vmss extension script network-config.sh
# N.B. vmss with private load balancer lost internet connection. script embedded in base64
#
resource "azurerm_virtual_machine_scale_set_extension" "vmss-extension" {
  name                         = "network-rule-forward"
  virtual_machine_scale_set_id = azurerm_linux_virtual_machine_scale_set.vmss-egress.id
  publisher                    = "Microsoft.Azure.Extensions"
  type                         = "CustomScript"
  type_handler_version         = "2.1"
  settings = jsonencode({
    "script" : "${local.base64_script}"
  })
}


#
# create load balancer (NVA) with tcp/0 ports
#
module "load_balancer_observ_egress" {
  source = "./.terraform/modules/__v4__/load_balancer"

  resource_group_name                    = local.vnet_core_resource_group_name
  location                               = var.location
  name                                   = format("%s-egress-lb", local.project)
  frontend_name                          = "frontend_private_ip"
  type                                   = "private"
  frontend_subnet_id                     = module.vmss_snet.id
  frontend_private_ip_address_allocation = "Static"
  frontend_private_ip_address            = module.vmss_snet.last_ip_address
  lb_sku                                 = "Standard"
  pip_sku                                = "Standard"
  lb_port = {
    lb_network = {
      frontend_port     = "0"
      protocol          = "All"
      backend_port      = "0"
      backend_pool_name = "default"
      probe_name        = "probe_ssh"
    }
  }

  lb_probe = {
    probe_ssh = {
      protocol     = "Tcp"
      port         = "22"
      request_path = ""
    }
  }

  tags = module.tag_config.tags

  depends_on = []
}



resource "azurerm_monitor_autoscale_setting" "vmss-scale" {
  count               = var.env_short != "d" ? 1 : 0
  name                = format("%s-vmss-scale", local.project)
  resource_group_name = azurerm_resource_group.vmss_rg.name
  location            = azurerm_resource_group.vmss_rg.location
  target_resource_id  = azurerm_linux_virtual_machine_scale_set.vmss-egress.id

  profile {
    name = format("%s-vmss-scale-rule-cpu", local.project)

    capacity {
      default = 1
      minimum = 1
      maximum = 3
    }

    rule {
      metric_trigger {
        metric_name        = "Percentage CPU"
        metric_resource_id = azurerm_linux_virtual_machine_scale_set.vmss-egress.id
        time_grain         = "PT1M"
        statistic          = "Average"
        time_window        = "PT5M"
        time_aggregation   = "Average"
        operator           = "GreaterThan"
        threshold          = 75
      }

      scale_action {
        direction = "Increase"
        type      = "ChangeCount"
        value     = "1"
        cooldown  = "PT1M"
      }
    }

    rule {
      metric_trigger {
        metric_name        = "Percentage CPU"
        metric_resource_id = azurerm_linux_virtual_machine_scale_set.vmss-egress.id
        time_grain         = "PT1M"
        statistic          = "Average"
        time_window        = "PT5M"
        time_aggregation   = "Average"
        operator           = "LessThan"
        threshold          = 20
      }

      scale_action {
        direction = "Decrease"
        type      = "ChangeCount"
        value     = "1"
        cooldown  = "PT1M"
      }
    }
  }

}


resource "azurerm_private_link_service" "vmss_pls" {
  name                = "${local.project}-privatelink"
  resource_group_name = azurerm_resource_group.vmss_rg.name
  location            = azurerm_resource_group.vmss_rg.location

  auto_approval_subscription_ids              = [data.azurerm_client_config.current.subscription_id]
  visibility_subscription_ids                 = [data.azurerm_client_config.current.subscription_id]
  load_balancer_frontend_ip_configuration_ids = [module.load_balancer_observ_egress.azurerm_lb_frontend_ip_configuration[0].id]

  nat_ip_configuration {
    name                       = "primary"
    private_ip_address         = module.vmss_pls_snet.last_ip_address
    private_ip_address_version = "IPv4"
    subnet_id                  = module.vmss_pls_snet.id
    primary                    = true
  }
}

resource "azurerm_key_vault_secret" "database_map_secret" {
  name         = "${local.project}-database-map"
  value        = join(",", local.postgres_fqdn_map[*].db_fqdn)
  content_type = "text/plain"

  key_vault_id = data.azurerm_key_vault.kv_core.id
}

data "azurerm_cosmosdb_account" "cosmos_account" {
  for_each = local.mongodb_trino_map
  name                = each.key
  resource_group_name = each.value
}

locals {

## Only MongoDb version 4.2 or higher is supported in Trino
  mongodb_adf_trino_mapping = [
    {
      fqdn             = "pagopa-${var.env_short}-itn-pay-wallet-cosmos-account"
      mongodb_rg       = "pagopa-${var.env_short}-itn-pay-wallet-cosmosdb-rg"
    },
    {
      fqdn             = "pagopa-${var.env_short}-weu-ecommerce-cosmos-account"
      mongodb_rg       = "pagopa-${var.env_short}-weu-ecommerce-cosmosdb-rg"
    }
  ]

## Mongodb FQDN to Resource Group mapping for Trino connection with fqdn key and resource group value
  mongodb_trino_map = { for mongodb in local.mongodb_adf_trino_mapping : mongodb.fqdn => mongodb.mongodb_rg }

## Mongodb FQDN to Connection String mapping for Trino connection
  mongodb_fqdn_url_map = [
    for mongo in data.azurerm_cosmosdb_account.cosmos_account : {
      db_fqdn_connection       = "${mongo.name}|${mongo.secondary_mongodb_connection_string}"
    }
  ]

## Generate script for mongodb trino connection
  mongodb_script = templatefile("${path.module}/mongodb_trino_connection.sh.tpl", {
    mongodb_map = join(",", local.mongodb_fqdn_url_map[*].db_fqdn_connection) 
  })

## Database Postgres Flexible mapping for ADF proxy
## Each DB has a different external port to be mapped to the same destination port 5432
  database_adf_proxy_mapping = [
    {
      fqdn             = "crusc8-db.${var.env_short}.internal.postgresql.pagopa.it"
      external_port    = 5432
      destination_port = 5432
    },
    {
      fqdn             = "gpd-db.${var.env_short}.internal.postgresql.pagopa.it"
      external_port    = 5433
      destination_port = 5432
    },
    {
      fqdn             = "nodo-db.${var.env_short}.internal.postgresql.pagopa.it"
      external_port    = 5434
      destination_port = 5432
    },
    {
      fqdn             = "fdr-db.${var.env_short}.internal.postgresql.pagopa.it"
      external_port    = 5435
      destination_port = 5432
    }

  ]

## Postgres FQDN to Port mapping for ADF proxy
  postgres_fqdn_port_map = flatten([
    for db in local.database_adf_proxy_mapping : {
      db_map = "${db.fqdn};${db.external_port};${db.destination_port}"
    }
  ])

## Postgres FQDN list for Key Vault secret
  postgres_fqdn_map = flatten([
    for db in local.database_adf_proxy_mapping : {
      db_fqdn = "${db.fqdn}"
    }
  ])

## Generate script for port forwarding
  postgres_forward_port_script = templatefile("${path.module}/network_proxy_forward.sh.tpl", {
    env = var.env_short
    db_map = join(",", local.postgres_fqdn_port_map[*].db_map) }
  )

## Script to enable IP Forwarding on VMSS
  ipfwd_script = file("${path.module}/create_ip_fwd.sh")
## Script to install and configure Trino
  trino_installation_script = file("${path.module}/trino_installation.sh")

  trino_configuration_script = templatefile("${path.module}/trino_configuration.sh.tpl", {
    env      = var.env
    trino_xmx = var.trino_xmx
  })
## Merge all scripts
  script_merge = "${local.ipfwd_script}${local.postgres_forward_port_script}${local.trino_installation_script}${local.mongodb_script}${local.trino_configuration_script}"
## Base64 encode the merged script
  base64_script       = base64encode(local.script_merge)

}