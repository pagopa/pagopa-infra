#linked service for blob storage
resource "azurerm_data_factory_linked_service_azure_blob_storage" "df_connection_linked_service_blob" {
  for_each = local.data_factory_linked_services_blob
  name              = "${each.key}-blob-${var.env_short}-LinkService"
  data_factory_id   = data.azurerm_data_factory.obeserv_data_factory.id
  connection_string = each.value.connection_string

  integration_runtime_name = "AutoResolveIntegrationRuntime"
  # connection_string_insecure = "DefaultEndpointsProtocol=https;AccountName=pagopa${var.env_short}itnobservsa;EndpointSuffix=core.windows.net;"
  use_managed_identity = true

  lifecycle {
    ignore_changes = [
      connection_string_insecure,
      connection_string
    ]
  }

}

