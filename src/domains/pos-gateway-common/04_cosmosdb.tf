resource "azurerm_resource_group" "cosmos_rg" {
  name     = "${local.project}-cosmos-rg"
  location = var.location

  tags = module.tag_config.tags
}




module "cosmos" {
  source = "./.terraform/modules/__v4__/IDH/cosmosdb_account"

  env               = var.env
  idh_resource_tier = var.cosmos_idh_resource_tier
  product_name      = local.prefix

  domain                  = local.domain
  name                    = "${local.project}-cosmos-account"
  resource_group_name     = azurerm_resource_group.cosmos_rg.name
  location                = var.location
  capabilities_additional = var.cosmos_mongo_db_params.capabilities


  main_geo_location_location = var.location

  additional_geo_locations = []


  embedded_subnet = {
    enabled      = true
    vnet_name    = local.spoke_data_vnet_name
    vnet_rg_name = local.spoke_data_vnet_resource_group_name
  }

  # fixme configure the cidr list and service name allowed on this cosmosdb
  embedded_nsg_configuration = {
    source_address_prefixes      = ["*"]
    source_address_prefixes_name = "All"
  }

  private_endpoint_config = {
    enabled                       = true
    private_dns_zone_mongo_ids    = [data.azurerm_private_dns_zone.privatelink_mongo_cosmos_azure_com.id]
    service_connection_name_mongo = "${local.project}-${local.domain}-cosmos-mongo-endpoint"
    name_mongo                    = "${local.project}-${local.domain}-cosmos-mongo-endpoint"


  }


  tags = module.tag_config.tags
}


resource "azurerm_key_vault_secret" "cosmos_pos_gateway_pkey" {
  name         = "${local.domain}-${var.env_short}-cosmos-pkey"
  value        = module.cosmos.primary_key
  content_type = "text/plain"

  key_vault_id = data.azurerm_key_vault.domain_kv.id
}

resource "azurerm_cosmosdb_mongo_database" "pos_gateway" {
  name                = "pos-gateway"
  resource_group_name = azurerm_resource_group.cosmos_rg.name
  account_name        = "${local.project}-cosmos-account"

  throughput = var.cosmos_mongo_db_pos_gateway_params.enable_autoscaling || var.cosmos_mongo_db_pos_gateway_params.enable_serverless ? null : var.cosmos_mongo_db_pos_gateway_params.throughput

  dynamic "autoscale_settings" {
    for_each = var.cosmos_mongo_db_pos_gateway_params.enable_autoscaling && !var.cosmos_mongo_db_pos_gateway_params.enable_serverless ? [""] : []
    content {
      max_throughput = var.cosmos_mongo_db_pos_gateway_params.max_throughput
    }
  }

}

locals {
  collections = [
    {
      name                = "eventstore"
      default_ttl_seconds = 15770000 #6 months
      indexes = [{
        keys   = ["_id"]
        unique = true
        },
        {
          keys   = ["timestamp"]
          unique = false
        }
      ]
      shard_key = "sessionId"
    },
    {
      name                = "sessions-view",
      default_ttl_seconds = 15770000 #6 months
      indexes = [
        {
          keys   = ["_id"] # wallet id pm
          unique = true
        },
        {
          keys   = ["updatedAt"],
          unique = false
        },
        {
          keys   = ["createdAt"],
          unique = false
        }
      ],
      shard_key = "_id"
    }
  ]
}

module "cosmosdb_pos_gateway_collections" {

  source   = "./.terraform/modules/__v4__/cosmosdb_mongodb_collection"
  for_each = { for index, coll in local.collections : coll.name => coll }

  name                = each.value.name
  resource_group_name = azurerm_resource_group.cosmos_rg.name

  cosmosdb_mongo_account_name  = "${local.project}-cosmos-account"
  cosmosdb_mongo_database_name = azurerm_cosmosdb_mongo_database.pos_gateway.name

  indexes             = each.value.indexes
  shard_key           = each.value.shard_key
  default_ttl_seconds = each.value.default_ttl_seconds
  lock_enable         = var.env_short != "p" ? false : true
}
