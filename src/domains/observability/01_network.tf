data "azurerm_virtual_network" "vnet" {
  name                = local.vnet_name
  resource_group_name = local.vnet_resource_group_name
}

data "azurerm_private_dns_zone" "storage" {
  name                = local.storage_blob_dns_zone_name
  resource_group_name = local.storage_blob_resource_group_name
}

data "azurerm_virtual_network" "vnet_italy" {
  name                = local.vnet_italy_name
  resource_group_name = local.vnet_italy_resource_group_name
}

data "azurerm_resource_group" "rg_vnet_italy" {
  name = local.vnet_italy_resource_group_name
}

#
# Eventhub
#
data "azurerm_private_dns_zone" "eventhub" {
  name                = "privatelink.servicebus.windows.net"
  resource_group_name = local.msg_resource_group_name
}



module "eventhub_observability_spoke_pe_snet" {
  source            = "./.terraform/modules/__v4__/IDH/subnet"
  env               = var.env
  idh_resource_tier = "slash28_privatelink_true"
  name              = "${local.project}-spoke-streaming-evh-pe-snet"
  product_name      = var.prefix

  resource_group_name  = local.vnet_hub_spoke_rg_name
  virtual_network_name = local.vnet_spoke_streaming_name

  custom_nsg_configuration = {
    target_service               = "eventhub"
    source_address_prefixes_name = "All"
    source_address_prefixes      = ["*"]
  }

  tags = module.tag_config.tags
}

module "eventhub_observability_gpd_spoke_pe_snet" {
  source            = "./.terraform/modules/__v4__/IDH/subnet"
  env               = var.env
  idh_resource_tier = "slash28_privatelink_true"
  name              = "${local.project}-spoke-streaming-evh-gpd-pe-snet"
  product_name      = var.prefix

  resource_group_name  = local.vnet_hub_spoke_rg_name
  virtual_network_name = local.vnet_spoke_streaming_name

  custom_nsg_configuration = {
    target_service               = "eventhub"
    source_address_prefixes_name = "All"
    source_address_prefixes      = ["*"]
  }

  tags = module.tag_config.tags
}
