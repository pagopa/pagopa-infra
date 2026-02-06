resource "azurerm_resource_group" "printit_pdf_engine_app_service_rg" {
  name     = "${local.project}-pdf-engine-rg"
  location = var.location

  tags = module.tag_config.tags
}

data "azurerm_container_registry" "container_registry" {
  name                = "pagopa${var.env_short}itncoreacr"
  resource_group_name = "pagopa-${var.env_short}-itn-acr-rg"
}

################
# node
################

module "printit_pdf_engine_app_service" {
  source = "./.terraform/modules/__v4__/IDH/app_service_webapp"

  count = var.is_feature_enabled.pdf_engine ? 1 : 0

  env                 = var.env
  idh_resource_tier   = var.idh_app_service_resource_tier
  product_name        = var.prefix
  resource_group_name = azurerm_resource_group.printit_pdf_engine_app_service_rg.name
  location            = var.location

  # App service plan
  name                  = "${local.project}-app-pdf-engine"
  app_service_plan_name = "${local.project}-plan-pdf-engine"

  always_on                = var.app_service_pdf_engine_always_on
  docker_image             = "pagopapdfengine"
  docker_image_tag         = "latest"
  docker_registry_url      = "https://${data.azurerm_container_registry.container_registry.login_server}"
  docker_registry_username = data.azurerm_container_registry.container_registry.admin_username
  docker_registry_password = data.azurerm_container_registry.container_registry.admin_password

  health_check_path            = "/info"
  health_check_maxpingfailures = 2

  app_settings                 = local.printit_pdf_engine_app_settings
  private_endpoint_dns_zone_id = data.azurerm_private_dns_zone.azurewebsite.id
  allow_from_apim              = true
  allowed_subnet_ids           = [data.azurerm_subnet.apim_vnet.id]
  allowed_service_tags         = ["AzureDevOps"]

  embedded_subnet = {
    vnet_name    = data.azurerm_virtual_network.vnet.name
    vnet_rg_name = data.azurerm_virtual_network.vnet.resource_group_name
    enabled      = true
  }

  autoscale_settings = {
    max_capacity                       = var.env_short == "p" ? 10 : 3
    scale_up_requests_threshold        = 2000
    scale_down_requests_threshold      = 1000
    scale_up_response_time_threshold   = 5
    scale_down_response_time_threshold = 2
    scale_up_cpu_threshold             = 75
    scale_down_cpu_threshold           = 30
  }

  tags = module.tag_config.tags
}

###############
#java
###############
module "printit_pdf_engine_app_service_java" {
  source = "./.terraform/modules/__v4__/IDH/app_service_webapp"
  count  = var.is_feature_enabled.pdf_engine ? 1 : 0

  env               = var.env
  idh_resource_tier = var.idh_app_service_resource_tier
  product_name      = var.prefix

  resource_group_name = azurerm_resource_group.printit_pdf_engine_app_service_rg.name
  location            = var.location

  # App service plan
  name                  = "${local.project}-app-pdf-engine-java"
  app_service_plan_name = "${local.project}-plan-pdf-engine-java"

  always_on                = var.app_service_pdf_engine_always_on
  docker_image             = "pagopapdfenginejava"
  docker_image_tag         = "latest"
  docker_registry_url      = "https://${data.azurerm_container_registry.container_registry.login_server}"
  docker_registry_username = data.azurerm_container_registry.container_registry.admin_username
  docker_registry_password = data.azurerm_container_registry.container_registry.admin_password

  health_check_path            = "/info"
  health_check_maxpingfailures = 2

  app_settings                 = local.printit_pdf_engine_app_settings_java
  private_endpoint_dns_zone_id = data.azurerm_private_dns_zone.azurewebsite.id
  allow_from_apim              = true
  allowed_subnet_ids           = [data.azurerm_subnet.apim_vnet.id]
  allowed_service_tags         = ["AzureDevOps"]

  embedded_subnet = {
    vnet_name    = data.azurerm_virtual_network.vnet.name
    vnet_rg_name = data.azurerm_virtual_network.vnet.resource_group_name
    enabled      = true
  }

  autoscale_settings = {
    max_capacity                       = var.env_short == "p" ? 10 : 3
    scale_up_requests_threshold        = 2000
    scale_down_requests_threshold      = 1000
    scale_up_response_time_threshold   = 5
    scale_down_response_time_threshold = 2
    scale_up_cpu_threshold             = 75
    scale_down_cpu_threshold           = 30
  }

  tags = module.tag_config.tags
}

moved {
  from = module.printit_pdf_engine_app_service[0].azurerm_linux_web_app.this
  to   = module.printit_pdf_engine_app_service[0].module.main_slot.azurerm_linux_web_app.this
}

moved {
  from = module.printit_pdf_engine_app_service[0].azurerm_service_plan.this[0]
  to   = module.printit_pdf_engine_app_service[0].module.main_slot.azurerm_service_plan.this[0]
}

moved {
  from = module.printit_pdf_engine_app_service_java[0].azurerm_linux_web_app.this
  to   = module.printit_pdf_engine_app_service_java[0].module.main_slot.azurerm_linux_web_app.this
}

moved {
  from = module.printit_pdf_engine_app_service_java[0].azurerm_service_plan.this[0]
  to   = module.printit_pdf_engine_app_service_java[0].module.main_slot.azurerm_service_plan.this[0]
}

moved {
  from = module.printit_pdf_engine_slot_staging[0].azurerm_linux_web_app_slot.this
  to   = module.printit_pdf_engine_app_service[0].module.staging_slot[0].azurerm_linux_web_app_slot.this
}

moved {
  from = module.printit_pdf_engine_java_slot_staging[0].azurerm_linux_web_app_slot.this
  to   = module.printit_pdf_engine_app_service_java[0].module.staging_slot[0].azurerm_linux_web_app_slot.this
}