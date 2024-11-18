# # ########################################################################################################################
# # ########################################### POSTGRES DEV ###############################################################
# # ########################################################################################################################
# # # ⚠️⚠️ Azure Database for PostgreSQL Single Server retires in March 2025. 
# # # ⚠️⚠️ This server will automatically migrate to Azure Database for PostgreSQL Flexible Server in 2 days. Learn More

# module "postgresql_snet" {
#   count  = var.env_short == "d" ? 1 : 0
#   source = "./.terraform/modules/__v3__/subnet"

#   name                                      = format("%s-gpd-postgresql-snet", local.product)
#   address_prefixes                          = var.cidr_subnet_pg_singleser
#   resource_group_name                       = local.vnet_resource_group_name
#   virtual_network_name                      = local.vnet_name
#   service_endpoints                         = ["Microsoft.Sql"]
#   private_endpoint_network_policies_enabled = false

#   delegation = {
#     name = "delegation"
#     service_delegation = {
#       name    = "Microsoft.ContainerInstance/containerGroups"
#       actions = ["Microsoft.Network/virtualNetworks/subnets/action"]
#     }
#   }
# }

# #tfsec:ignore:azure-database-no-public-access
# module "postgresql" {
#   count  = var.env_short == "d" ? 1 : 0
#   source = "./.terraform/modules/__v3__/postgresql_server"

#   name                = format("%s-gpd-postgresql", local.product)
#   location            = azurerm_resource_group.gpd_rg.location
#   resource_group_name = azurerm_resource_group.gpd_rg.name

#   administrator_login          = data.azurerm_key_vault_secret.pgres_admin_login.value
#   administrator_login_password = data.azurerm_key_vault_secret.pgres_admin_pwd.value

#   sku_name                     = "B_Gen5_1"
#   db_version                   = 11
#   geo_redundant_backup_enabled = false

#   public_network_access_enabled = false
#   network_rules                 = var.postgresql_network_rules

#   private_endpoint = {
#     enabled              = false
#     virtual_network_id   = data.azurerm_virtual_network.vnet.id
#     subnet_id            = module.postgresql_snet[0].id
#     private_dns_zone_ids = []
#   }

#   enable_replica = false
#   alerts_enabled = false
#   lock_enable    = false

#   tags = var.tags
# }

# resource "azurerm_postgresql_database" "apd_db" {
#   count               = var.env_short == "d" ? 1 : 0
#   name                = var.gpd_db_name
#   resource_group_name = azurerm_resource_group.gpd_rg.name
#   server_name         = module.postgresql[0].name
#   charset             = "UTF8"
#   collation           = "it_IT" # "Italian_Italy.1252"

#   lifecycle {
#     ignore_changes = [
#       collation,
#     ]
#   }  
# }
