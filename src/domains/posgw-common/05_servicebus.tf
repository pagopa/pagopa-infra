# In order to contain service bus namespace cost creation we make use of the same 
# servicebus namespace already defined for nodo wisp dismantling, see here https://github.com/pagopa/pagopa-infra/blob/84adee7513c3782a627b76a1e44f7cbfdfe42dc8/src/domains/nodo-common/06_service_bus_wisp_converter.tf#L48 

locals {
  servicebus_namespace_name                = "${local.product}-weu-nodo-servicebus-wisp"
  servicebus_namespace_resource_group_name = "${local.product}-weu-nodo-sb-rg"
}

data "azurerm_servicebus_namespace" "nodo_service_bus" {
  name                = local.servicebus_namespace_name
  resource_group_name = local.servicebus_namespace_resource_group_name
}

#Service bus queues
module "servicebus_queues" {
  source                  = "./.terraform/modules/__v4__/servicebus_queues"
  servicebus_namespace_id = data.azurerm_servicebus_namespace.nodo_service_bus.id
  servicebus_queues       = var.servicebus_queues
}

#queues authorization rules connection strings
resource "azurerm_key_vault_secret" "servicebus_queues_primary_connection_strings" {
  for_each = module.servicebus_queues.queue_authorization_rules

  name         = "${local.domain}-${var.env_short}-${each.value.name}-primary-connection-string"
  value        = each.value.primary_connection_string
  content_type = "text/plain"

  key_vault_id = data.azurerm_key_vault.domain_kv.id

  depends_on = [module.servicebus_queues]
}

#Service bus topics
module "servicebus_topics" {
  source                  = "./.terraform/modules/__v4__/servicebus_topics"
  servicebus_namespace_id = data.azurerm_servicebus_namespace.nodo_service_bus.id
  servicebus_topics       = var.servicebus_topics
}

#topics authorization rules connection strings
resource "azurerm_key_vault_secret" "servicebus_topics_primary_connection_strings" {
  for_each = module.servicebus_topics.topic_authorization_rules

  name         = "${local.domain}-${var.env_short}-${each.value.name}-primary-connection-string"
  value        = each.value.primary_connection_string
  content_type = "text/plain"

  key_vault_id = data.azurerm_key_vault.domain_kv.id

  depends_on = [module.servicebus_topics]
}


