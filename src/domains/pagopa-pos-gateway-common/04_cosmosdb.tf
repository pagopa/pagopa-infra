resource "azurerm_resource_group" "cosmos_rg" {
  name     = "${local.project}-cosmos-rg"
  location = var.location

  tags = module.tag_config.tags
}




module "cosmos" {
  source = "./.terraform/modules/__v4__/IDH/cosmosdb_account"

  env = var.env
  idh_resource_tier = var.cosmos_idh_resource_tier
  product_name = local.prefix

  domain                     = local.domain
  name                       = "${local.project}-cosmos-account"
  resource_group_name        = azurerm_resource_group.cosmos_rg.name
  location                   = var.location

  main_geo_location_location = var.location

  additional_geo_locations = []


  embedded_subnet = {
    enabled              = true
    vnet_name            = local.spoke_data_vnet_name
    vnet_rg_name         = local.spoke_data_vnet_resource_group_name
  }

  # fixme configure the cidr list and service name allowed on this cosmosdb
  embedded_nsg_configuration = {
    source_address_prefixes      = ["*"]
    source_address_prefixes_name = "All"
  }

  private_endpoint_config = {
      enabled = true


  }


  tags = module.tag_config.tags
}


resource "azurerm_key_vault_secret" "cosmos_pagopa_pos_gateway_pkey" {
  name         = "${local.domain}-${var.env_short}-cosmos-pkey"
  value        = module.cosmos.primary_key
  content_type = "text/plain"

  key_vault_id = data.azurerm_key_vault.domain_kv.id
}
