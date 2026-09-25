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


#Service bus topics
module "servicebus_topics" {
  source                  = "./.terraform/modules/__v4__/servicebus_topics"
  servicebus_namespace_id = data.azurerm_servicebus_namespace.nodo_service_bus.id
  servicebus_topics       = var.servicebus_topics
}