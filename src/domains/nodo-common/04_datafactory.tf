locals {
  administrator_login    = data.azurerm_key_vault_secret.pgres_flex_admin_login.value
  administrator_password = data.azurerm_key_vault_secret.pgres_flex_admin_pwd.value

}

resource "azurerm_resource_group" "data_factory_rg" {
  name     = format("%s-df-rg", local.project)
  location = var.location
  tags     = var.tags
}


resource "azurerm_data_factory" "data_factory" {
  name                   = format("%s-df", local.project)
  location               = azurerm_resource_group.data_factory_rg.location
  resource_group_name    = azurerm_resource_group.data_factory_rg.name
  public_network_enabled = false

  # Still doesn't work: https://github.com/hashicorp/terraform-provider-azurerm/issues/12949
  managed_virtual_network_enabled = true

  identity {
    type = "SystemAssigned"
  }

  tags = var.tags
}

resource "azurerm_data_factory_integration_runtime_azure" "autoresolve" {
  name = "AutoResolveIntegrationRuntime"
  # resource_group_name     = azurerm_resource_group.data_factory_rg.name
  data_factory_id         = azurerm_data_factory.data_factory.id
  location                = "AutoResolve"
  virtual_network_enabled = true
}

resource "azurerm_private_endpoint" "data_factory_pe" {
  name                = format("%s-pe", azurerm_data_factory.data_factory.name)
  location            = azurerm_resource_group.data_factory_rg.location
  resource_group_name = azurerm_resource_group.data_factory_rg.name
  subnet_id           = data.azurerm_subnet.private_endpoint_snet.id

  private_dns_zone_group {
    name                 = format("%s-private-dns-zone-group", azurerm_data_factory.data_factory.name)
    private_dns_zone_ids = [azurerm_private_dns_zone.adf.id]
  }

  private_service_connection {
    name                           = format("%s-private-service-connection", azurerm_data_factory.data_factory.name)
    private_connection_resource_id = azurerm_data_factory.data_factory.id
    is_manual_connection           = false
    subresource_names              = ["datafactory"]
  }

  tags = var.tags
}

resource "azurerm_private_dns_a_record" "data_factory_a_record" {
  name                = azurerm_data_factory.data_factory.name
  zone_name           = azurerm_private_dns_zone.adf.name
  resource_group_name = azurerm_private_dns_zone.adf.resource_group_name
  ttl                 = 300
  records             = azurerm_private_endpoint.data_factory_pe.private_service_connection.*.private_ip_address

  tags = var.tags
}

locals {
  datasets = { for filename in fileset(path.module, "datafactory/datasets/*.json") : replace(basename(filename), ".json", "") => file("${path.module}/${filename}") }
}

############### LINKED SERVICE ####################
resource "azurerm_data_factory_linked_custom_service" "azure_postgresql_ls" {
  name                 = "AzurePostgreSqlLinkedService"
  data_factory_id      = azurerm_data_factory.data_factory.id
  type                 = "AzurePostgreSql"
  type_properties_json = <<JSON
{
  "connectionString":"host=pagopa-${var.env_short}-weu-nodo-flexible-postgresql.postgres.database.azure.com;port=5432;database=nodo;uid=${local.administrator_login};encryptionmethod=1;validateservercertificate=0;password=${local.administrator_password}"
}
JSON
}

############### DATASET ####################
resource "azurerm_data_factory_custom_dataset" "datasets" {
  depends_on      = [azurerm_data_factory_linked_custom_service.azure_postgresql_ls]
  for_each        = local.datasets
  name            = "${each.key}Dataset"
  data_factory_id = azurerm_data_factory.data_factory.id
  type            = "AzurePostgreSqlTable"

  type_properties_json = file("datafactory/datasets/type_properties/${each.key}.json")

  schema_json = <<JSON
      ${each.value}
  JSON

  linked_service {
    name = azurerm_data_factory_linked_custom_service.azure_postgresql_ls.name
  }

  lifecycle { create_before_destroy = true }
}

################ DATAFLOW ####################
resource "azurerm_data_factory_data_flow" "dataflow_re" {
  depends_on      = [azurerm_data_factory_custom_dataset.datasets]
  data_factory_id = azurerm_data_factory.data_factory.id
  name            = "reDataflow"

  source {
    name        = "reRead"
    description = "Extract re where inserted_timestamp < (today-n)"

    dataset {
      name = "reDataset"
    }
  }

  transformation {
    name        = "markRecordReToDelete"
    description = "deleting record if inserted_timestamp < now - 'n days'"
  }

  sink {
    name        = "executeReDeleteDB"
    description = "Delete re data on db"

    dataset {
      name = "reDataset"
    }
  }

  script = templatefile("datafactory/dataflows/reDataflow.dsl", {})
}

resource "azurerm_data_factory_data_flow" "dataflow_wfesp" {
  depends_on      = [azurerm_data_factory_custom_dataset.datasets]
  data_factory_id = azurerm_data_factory.data_factory.id
  name            = "wfespDataflow"

  source {
    name        = "rptRead"
    description = "Extract rpt where inserted_timestamp < (today-n)"

    dataset {
      name = "wfespRptDataset"
    }
  }
  source {
    name        = "carrelloRptRead"
    description = "Extract carrello_rpt where inserted_timestamp < (today-n)"

    dataset {
      name = "wfespCarrelloRptDataset"
    }
  }
  source {
    name        = "redirectMyBankRead"
    description = "Extract redirect_my_bank where inserted_timestamp < (today-n)"

    dataset {
      name = "wfespRedirectMyBankDataset"
    }
  }

  transformation {
    name        = "markRecordRptToDelete"
    description = "deleting record if inserted_timestamp < now - 'n days'"
  }
  transformation {
    name        = "markRecordCarrelloRptToDelete"
    description = "deleting record if inserted_timestamp < now - 'n days'"
  }
  transformation {
    name        = "markRecordRedirectMyBankToDelete"
    description = "deleting record if inserted_timestamp < now - 'n days'"
  }

  sink {
    name        = "executeRptDeleteDB"
    description = "Delete rpt data on db"

    dataset {
      name = "wfespRptDataset"
    }
  }
  sink {
    name        = "executeCarrelloRptDeleteDB"
    description = "Delete carrello_rpt data on db"

    dataset {
      name = "wfespCarrelloRptDataset"
    }
  }
  sink {
    name        = "executeRedirectMyBankDeleteDB"
    description = "Delete redirect_my_bank data on db"

    dataset {
      name = "wfespRedirectMyBankDataset"
    }
  }

  script = templatefile("datafactory/dataflows/wfespDataflow.dsl", {})
}

resource "azurerm_data_factory_data_flow" "dataflow_online" {
  depends_on      = [azurerm_data_factory_custom_dataset.datasets]
  data_factory_id = azurerm_data_factory.data_factory.id
  name            = "onlineDataflow"

  source {
    dataset {
      name = "onlineMessaggiDataset"
    }
    name        = "messaggiRead"
    description = "Extract records where timestamp_evento < (today-n)"
  }
  source {
    dataset {
      name = "onlineCdInfoPagamentoDataset"
    }
    name        = "cdInfoPagamentoRead"
    description = "Extract records where inserted_timestamp < (today-n)"
  }
  source {
    dataset {
      name = "onlineRptVersamentiBolloDataset"
    }
    name        = "rptVersamentiBolloRead"
    description = "Extract records where inserted_timestamp < (today-n)"
  }
  source {
    dataset {
      name = "onlineRptVersamentiDataset"
    }
    name        = "rptVersamentiRead"
    description = "Extract records where inserted_timestamp < (today-n)"
  }
  source {
    dataset {
      name = "onlineRptSoggettiDataset"
    }
    name        = "rptSoggettiRead"
    description = "Extract records where inserted_timestamp < (today-n)"
  }
  source {
    dataset {
      name = "onlineRptActivationsDataset"
    }
    name        = "rptActivationsRead"
    description = "Extract records where inserted_timestamp < (today-n)"
  }
  source {
    dataset {
      name = "onlineStatiRptDataset"
    }
    name        = "statiRptRead"
    description = "Extract records where inserted_timestamp < (today-n)"
  }
  source {
    dataset {
      name = "onlineStatiRptSnapshotDataset"
    }
    name        = "statiRptSnapshotRead"
    description = "Extract records where inserted_timestamp < (today-n)"
  }
  source {
    dataset {
      name = "onlineStatiCarrelloDataset"
    }
    name        = "statiCarrelloRead"
    description = "Extract records where inserted_timestamp < (today-n)"
  }
  source {
    dataset {
      name = "onlineStatiCarrelloSnapshotDataset"
    }
    name        = "statiCarrelloSnapshotRead"
    description = "Extract records where inserted_timestamp < (today-n)"
  }
  source {
    dataset {
      name = "onlineRtVersamentiBolloDataset"
    }
    name        = "rtVersamentiBolloRead"
    description = "Extract records where inserted_timestamp < (today-n)"
  }
  source {
    dataset {
      name = "onlineRtVersamentiDataset"
    }
    name        = "rtVersamentiRead"
    description = "Extract records where inserted_timestamp < (today-n)"
  }
  source {
    dataset {
      name = "onlineRtXmlDataset"
    }
    name        = "rtXmlRead"
    description = "Extract records where inserted_timestamp < (today-n)"
  }
  source {
    dataset {
      name = "onlineRptXmlDataset"
    }
    name        = "rptXmlRead"
    description = "Extract records where inserted_timestamp < (today-n)"
  }
  source {
    dataset {
      name = "onlinePmSessionDataDataset"
    }
    name        = "pmSessionDataRead"
    description = "Extract records where inserted_timestamp < (today-n)"
  }
  source {
    dataset {
      name = "onlinePmMetadataDataset"
    }
    name        = "pmMetadataRead"
    description = "Extract records where inserted_timestamp < (today-n)"
  }
  source {
    dataset {
      name = "onlineIdempotencyCacheDataset"
    }
    name        = "idempotencyCacheRead"
    description = "Extract records where inserted_timestamp < (today-n)"
  }
  source {
    dataset {
      name = "onlineNmuCancelUtilityDataset"
    }
    name        = "nmuCancelUtilityRead"
    description = "Extract records where inserted_timestamp < (today-n)"
  }
  source {
    dataset {
      name = "onlinePositionActivateDataset"
    }
    name        = "positionActivateRead"
    description = "Extract records where inserted_timestamp < (today-n)"
  }
  source {
    dataset {
      name = "onlinePositionPaymentStatusDataset"
    }
    name        = "positionPaymentStatusRead"
    description = "Extract records where inserted_timestamp < (today-n)"
  }
  source {
    dataset {
      name = "onlinePositionPaymentStatusSnapshotDataset"
    }
    name        = "positionPaymentStatusSnapshotRead"
    description = "Extract records where inserted_timestamp < (today-n)"
  }
  source {
    dataset {
      name = "onlinePositionReceiptDataset"
    }
    name        = "positionReceiptRecipientStatusRead"
    description = "Extract records where inserted_timestamp < (today-n)"
  }
  source {
    dataset {
      name = "onlinePositionReceiptTransferDataset"
    }
    name        = "positionReceiptTransferRead"
    description = "Extract records where inserted_timestamp < (today-n)"
  }
  source {
    dataset {
      name = "onlinePositionTransferDataset"
    }
    name        = "positionTransferRead"
    description = "Extract records where inserted_timestamp < (today-n)"
  }
  source {
    dataset {
      name = "onlinePositionReceiptRecipientDataset"
    }
    name        = "positionReceiptRecipientRead"
    description = "Extract records where inserted_timestamp < (today-n)"
  }
  source {
    dataset {
      name = "onlinePositionReceiptXmlDataset"
    }
    name        = "positionReceiptXmlRead"
    description = "Extract records where inserted_timestamp < (today-n)"
  }
  source {
    dataset {
      name = "onlinePositionReceiptDataset"
    }
    name        = "positionReceiptRead"
    description = "Extract records where inserted_timestamp < (today-n)"
  }
  source {
    dataset {
      name = "onlineTokenUtilityDataset"
    }
    name        = "tokenUtilityRead"
    description = "Extract records where inserted_timestamp < (today-n)"
  }
  source {
    dataset {
      name = "onlinePositionPaymentDataset"
    }
    name        = "positionPaymentRead"
    description = "Extract records where inserted_timestamp < (today-n)"
  }
  source {
    dataset {
      name = "onlinePositionPaymentPlanDataset"
    }
    name        = "positionPaymentPlanRead"
    description = "Extract records where inserted_timestamp < (today-n)"
  }
  source {
    dataset {
      name = "onlinePositionStatusDataset"
    }
    name        = "positionStatusRead"
    description = "Extract records where inserted_timestamp < (today-n)"
  }
  source {
    dataset {
      name = "onlinePositionStatusSnapshotDataset"
    }
    name        = "positionStatusSnapshotRead"
    description = "Extract records where inserted_timestamp < (today-n)"
  }
  source {
    dataset {
      name = "onlinePositionServiceDataset"
    }
    name        = "positionServiceRead"
    description = "Extract records where inserted_timestamp < (today-n)"
  }
  source {
    dataset {
      name = "onlinePositionSubjectDataset"
    }
    name        = "positionSubjectRead"
    description = "Extract records where inserted_timestamp < (today-n)"
  }
  source {
    dataset {
      name = "onlinePositionTransferMbdDataset"
    }
    name        = "positionTransferMbdRead"
    description = "Extract records where inserted_timestamp < (today-n)"
  }
  source {
    dataset {
      name = "onlineRtDataset"
    }
    name        = "rtRead"
    description = "Extract records where inserted_timestamp < (today-n)"
  }
  source {
    dataset {
      name = "onlineRptDataset"
    }
    name        = "rptRead"
    description = "Extract records where inserted_timestamp < (today-n)"
  }
  source {
    dataset {
      name = "onlineCarrelloDataset"
    }
    name        = "carrelloRead"
    description = "Extract records where inserted_timestamp < (today-n)"
  }
  source {
    dataset {
      name = "onlineRetryPspNotificaCancellazioneRptDataset"
    }
    name        = "retryRptNotificaCancellazioneRead"
    description = "Add source Extract records where inserted_timestamp < (today-n)"
  }
  source {
    dataset {
      name = "onlineRetryRptDataset"
    }
    name        = "retryRptRead"
    description = "Extract records where inserted_timestamp < (today-n)"
  }
  source {
    dataset {
      name = "onlineRetryPaAttivaRptDataset"
    }
    name        = "retryPaAttivaRptRead"
    description = "Extract records where inserted_timestamp < (today-n)"
  }
  source {
    dataset {
      name = "onlineRetryPspNotificaCancellazioneRptDataset"
    }
    name        = "retryPspNotificaCancellazioneRptRead"
    description = "Extract records where inserted_timestamp < (today-n)"
  }
  source {
    dataset {
      name = "onlineRetryPspAckDataset"
    }
    name        = "retryPspAckRead"
    description = "Extract records where inserted_timestamp < (today-n)"
  }
  source {
    dataset {
      name = "onlineRetryPaInviaRtDataset"
    }
    name        = "retryPaInviaRtRead"
    description = "Extract records where inserted_timestamp < (today-n)"
  }
  source {
    dataset {
      name = "onlinePositionRetrySendpaymentresultDataset"
    }
    name        = "positionRetrySendpaymentresultRead"
    description = "Extract records where inserted_timestamp < (today-n)"
  }
  source {
    dataset {
      name = "onlinePositionRetryPspSendPaymentDataset"
    }
    name        = "positionRetryPspSendPaymentRead"
    description = "Extract records where inserted_timestamp < (today-n)"
  }
  source {
    dataset {
      name = "onlinePositionRetryPaSendRtDataset"
    }
    name        = "positionRetryPaSendRtRead"
    description = "Extract records where inserted_timestamp < (today-n)"
  }
  source {
    dataset {
      name = "onlineRegistroChiamateNotificaRtDataset"
    }
    name        = "registroChiamateNotificaRtRead"
    description = "Extract records where data < (today-n)"
  }
  source {
    dataset {
      name = "onlineVerificaBollettinoDataset"
    }
    name        = "verificaBollettinoRead"
    description = "Extract records where inserted_timestamp < (today-n)"
  }

  transformation {
    name        = "markRecordMessaggiToDelete"
    description = "deleting record if timestamp_evento < now - 'n days'"
  }
  transformation {
    name        = "markRecordCdInfoPagamentoToDelete"
    description = "deleting record if inserted_timestamp < now - 'n days'"
  }
  transformation {
    name        = "markRecordRptVersamentiBolloToDelete"
    description = "deleting record if inserted_timestamp < now - 'n days'"
  }
  transformation {
    name        = "markRecordRptVersamentiToDelete"
    description = "deleting record if inserted_timestamp < now - 'n days'"
  }
  transformation {
    name        = "markRecordRptSoggettiToDelete"
    description = "deleting record if inserted_timestamp < now - 'n days'"
  }
  transformation {
    name        = "markRecordRptActivationsToDelete"
    description = "deleting record if inserted_timestamp < now - 'n days'"
  }
  transformation {
    name        = "markRecordStatiRptToDelete"
    description = "deleting record if inserted_timestamp < now - 'n days'"
  }
  transformation {
    name        = "markRecordStatiRptSnapshotToDelete"
    description = "deleting record if inserted_timestamp < now - 'n days'"
  }
  transformation {
    name        = "markRecordStatiCarrelloToDelete"
    description = "deleting record if inserted_timestamp < now - 'n days'"
  }
  transformation {
    name        = "markRecordStatiCarrelloSnapshotToDelete"
    description = "deleting record if inserted_timestamp < now - 'n days'"
  }
  transformation {
    name        = "markRecordRtVersamentiBolloToDelete"
    description = "deleting record if inserted_timestamp < now - 'n days'"
  }
  transformation {
    name        = "markRecordRtVersamentiToDelete"
    description = "deleting record if inserted_timestamp < now - 'n days'"
  }
  transformation {
    name        = "markRecordRtXmlToDelete"
    description = "deleting record if inserted_timestamp < now - 'n days'"
  }
  transformation {
    name        = "markRecordRptXmlToDelete"
    description = "deleting record if inserted_timestamp < now - 'n days'"
  }
  transformation {
    name        = "markRecordPmSessionDataToDelete"
    description = "deleting record if inserted_timestamp < now - 'n days'"
  }
  transformation {
    name        = "markRecordPmMetadataToDelete"
    description = "deleting record if inserted_timestamp < now - 'n days'"
  }
  transformation {
    name        = "markRecordIdempotencyCacheToDelete"
    description = "deleting record if inserted_timestamp < now - 'n days'"
  }
  transformation {
    name        = "markRecordNmuCancelUtilityToDelete"
    description = "deleting record if inserted_timestamp < now - 'n days'"
  }
  transformation {
    name        = "markRecordPositionActivateToDelete"
    description = "deleting record if inserted_timestamp < now - 'n days'"
  }
  transformation {
    name        = "markRecordPositionPaymentStatusToDelete"
    description = "deleting record if inserted_timestamp < now - 'n days'"
  }
  transformation {
    name        = "markRecordPositionPaymentStatusSnapshotToDelete"
    description = "deleting record if inserted_timestamp < now - 'n days'"
  }
  transformation {
    name        = "markRecordPositionReceiptRecipientStatusToDelete"
    description = "deleting record if inserted_timestamp < now - 'n days'"
  }
  transformation {
    name        = "markRecordPositionReceiptTransferToDelete"
    description = "deleting record if inserted_timestamp < now - 'n days'"
  }
  transformation {
    name        = "markRecordPositionTransferToDelete"
    description = "deleting record if inserted_timestamp < now - 'n days'"
  }
  transformation {
    name        = "markRecordPositionReceiptRecipientToDelete"
    description = "deleting record if inserted_timestamp < now - 'n days'"
  }
  transformation {
    name        = "markRecordPositionReceiptXmlToDelete"
    description = "deleting record if inserted_timestamp < now - 'n days'"
  }
  transformation {
    name        = "markRecordPositionReceiptToDelete"
    description = "deleting record if inserted_timestamp < now - 'n days'"
  }
  transformation {
    name        = "markRecordTokenUtilityToDelete"
    description = "deleting record if inserted_timestamp < now - 'n days'"
  }
  transformation {
    name        = "markRecordPositionPaymentToDelete"
    description = "deleting record if inserted_timestamp < now - 'n days'"
  }
  transformation {
    name        = "markRecordPositionPaymentPlanToDelete"
    description = "deleting record if inserted_timestamp < now - 'n days'"
  }
  transformation {
    name        = "markRecordPositionStatusToDelete"
    description = "deleting record if inserted_timestamp < now - 'n days'"
  }
  transformation {
    name        = "markRecordPositionStatusSnapshotToDelete"
    description = "deleting record if inserted_timestamp < now - 'n days'"
  }
  transformation {
    name        = "markRecordPositionServiceToDelete"
    description = "deleting record if inserted_timestamp < now - 'n days'"
  }
  transformation {
    name        = "markRecordPositionSubjectToDelete"
    description = "deleting record if inserted_timestamp < now - 'n days'"
  }
  transformation {
    name        = "markRecordPositionTransferMbdToDelete"
    description = "deleting record if inserted_timestamp < now - 'n days'"
  }
  transformation {
    name        = "markRecordRtToDelete"
    description = "deleting record if inserted_timestamp < now - 'n days'"
  }
  transformation {
    name        = "markRecordRptToDelete"
    description = "deleting record if inserted_timestamp < now - 'n days'"
  }
  transformation {
    name        = "markRecordCarrelloToDelete"
    description = "deleting record if inserted_timestamp < now - 'n days'"
  }
  transformation {
    name        = "markRecordRetryRptNotificaCancellazioneToDelete"
    description = "deleting record if inserted_timestamp < now - 'n days'"
  }
  transformation {
    name        = "markRecordRetryRptToDelete"
    description = "deleting record if inserted_timestamp < now - 'n days'"
  }
  transformation {
    name        = "markRecordRetryPaAttivaRptToDelete"
    description = "deleting record if inserted_timestamp < now - 'n days'"
  }
  transformation {
    name        = "markRecordRetryPspNotificaCancellazioneRptToDelete"
    description = "deleting record if inserted_timestamp < now - 'n days'"
  }
  transformation {
    name        = "markRecordRetryPspAckToDelete"
    description = "deleting record if inserted_timestamp < now - 'n days'"
  }
  transformation {
    name        = "markRecordRetryPaInviaRtToDelete"
    description = "deleting record if inserted_timestamp < now - 'n days'"
  }
  transformation {
    name        = "markRecordPositionRetrySendpaymentresultToDelete"
    description = "deleting record if inserted_timestamp < now - 'n days'"
  }
  transformation {
    name        = "markRecordPositionRetryPspSendPaymentToDelete"
    description = "deleting record if inserted_timestamp < now - 'n days'"
  }
  transformation {
    name        = "markRecordPositionRetryPaSendRtToDelete"
    description = "deleting record if inserted_timestamp < now - 'n days'"
  }
  transformation {
    name        = "markRecordRegistroChiamateNotificaRtToDelete"
    description = "deleting record if inserted_timestamp < now - 'n days'"
  }
  transformation {
    name        = "markRecordVerificaBollettinoToDelete"
    description = "deleting record if inserted_timestamp < now - 'n days'"
  }

  sink {
    dataset {
      name = "onlineMessaggiDataset"
    }
    name        = "executeMessaggiDeleteDB"
    description = "Delete data on db"
  }
  sink {
    dataset {
      name = "onlineCdInfoPagamentoDataset"
    }
    name        = "executeCdInfoPagamentoDeleteDB"
    description = "Delete data on db"
  }
  sink {
    dataset {
      name = "onlineRptVersamentiBolloDataset"
    }
    name        = "executeRptVersamentiBolloDeleteDB"
    description = "Delete data on db"
  }
  sink {
    dataset {
      name = "onlineRptVersamentiDataset"
    }
    name        = "executeRptVersamentiDeleteDB"
    description = "Delete data on db"
  }
  sink {
    dataset {
      name = "onlineRptSoggettiDataset"
    }
    name        = "executeRptSoggettiDeleteDB"
    description = "Delete data on db"
  }
  sink {
    dataset {
      name = "onlineRptActivationsDataset"
    }
    name        = "executeRptActivationsDeleteDB"
    description = "Delete data on db"
  }
  sink {
    dataset {
      name = "onlineStatiRptDataset"
    }
    name        = "executeStatiRptDeleteDB"
    description = "Delete data on db"
  }
  sink {
    dataset {
      name = "onlineStatiRptSnapshotDataset"
    }
    name        = "executeStatiRptSnapshotDeleteDB"
    description = "Delete data on db"
  }
  sink {
    dataset {
      name = "onlineStatiCarrelloDataset"
    }
    name        = "executeStatiCarrelloDeleteDB"
    description = "Delete data on db"
  }
  sink {
    dataset {
      name = "onlineStatiCarrelloSnapshotDataset"
    }
    name        = "executeStatiCarrelloSnapshotDeleteDB"
    description = "Delete data on db"
  }
  sink {
    dataset {
      name = "onlineRtVersamentiBolloDataset"
    }
    name        = "executeRtVersamentiBolloDeleteDB"
    description = "Delete data on db"
  }
  sink {
    dataset {
      name = "onlineRtVersamentiDataset"
    }
    name        = "executeRtVersamentiDeleteDB"
    description = "Delete data on db"
  }
  sink {
    dataset {
      name = "onlineRtXmlDataset"
    }
    name        = "executeRtXmlDeleteDB"
    description = "Delete data on db"
  }
  sink {
    dataset {
      name = "onlineRptXmlDataset"
    }
    name        = "executeRptXmlDeleteDB"
    description = "Delete data on db"
  }
  sink {
    dataset {
      name = "onlinePmSessionDataDataset"
    }
    name        = "executePmSessionDataDeleteDB"
    description = "Delete data on db"
  }
  sink {
    dataset {
      name = "onlinePmMetadataDataset"
    }
    name        = "executePmMetadataDeleteDB"
    description = "Delete data on db"
  }
  sink {
    dataset {
      name = "onlineIdempotencyCacheDataset"
    }
    name        = "executeIdempotencyCacheDeleteDB"
    description = "Delete data on db"
  }
  sink {
    dataset {
      name = "onlineNmuCancelUtilityDataset"
    }
    name        = "executeNmuCancelUtilityDeleteDB"
    description = "Delete data on db"
  }
  sink {
    dataset {
      name = "onlinePositionActivateDataset"
    }
    name        = "executePositionActivateDeleteDB"
    description = "Delete data on db"
  }
  sink {
    dataset {
      name = "onlinePositionPaymentStatusDataset"
    }
    name        = "executePositionPaymentStatusDeleteDB"
    description = "Delete data on db"
  }
  sink {
    dataset {
      name = "onlinePositionPaymentStatusSnapshotDataset"
    }
    name        = "executePositionPaymentStatusSnapshotDeleteDB"
    description = "Delete data on db"
  }
  sink {
    dataset {
      name = "onlinePositionReceiptRecipientStatusDataset"
    }
    name        = "executePositionReceiptRecipientStatusDeleteDB"
    description = "Delete data on db"
  }
  sink {
    dataset {
      name = "onlinePositionReceiptTransferDataset"
    }
    name        = "executePositionReceiptTransferDeleteDB"
    description = "Delete data on db"
  }
  sink {
    dataset {
      name = "onlinePositionTransferDataset"
    }
    name        = "executePositionTransferDeleteDB"
    description = "Delete data on db"
  }
  sink {
    dataset {
      name = "onlinePositionReceiptRecipientDataset"
    }
    name        = "executePositionReceiptRecipientDeleteDB"
    description = "Delete data on db"
  }
  sink {
    dataset {
      name = "onlinePositionReceiptXmlDataset"
    }
    name        = "executePositionReceiptXmlDeleteDB"
    description = "Delete data on db"
  }
  sink {
    dataset {
      name = "onlinePositionReceiptDataset"
    }
    name        = "executePositionReceiptDeleteDB"
    description = "Delete data on db"
  }
  sink {
    dataset {
      name = "onlineTokenUtilityDataset"
    }
    name        = "executeTokenUtilityDeleteDB"
    description = "Delete data on db"
  }
  sink {
    dataset {
      name = "onlinePositionPaymentDataset"
    }
    name        = "executePositionPaymentDeleteDB"
    description = "Delete data on db"
  }
  sink {
    dataset {
      name = "onlinePositionPaymentPlanDataset"
    }
    name        = "executePositionPaymentPlanDeleteDB"
    description = "Delete data on db"
  }
  sink {
    dataset {
      name = "onlinePositionStatusDataset"
    }
    name        = "executePositionStatusDeleteDB"
    description = "Delete data on db"
  }
  sink {
    dataset {
      name = "onlinePositionStatusSnapshotDataset"
    }
    name        = "executePositionStatusSnapshotDeleteDB"
    description = "Delete data on db"
  }
  sink {
    dataset {
      name = "onlinePositionServiceDataset"
    }
    name        = "executePositionServiceDeleteDB"
    description = "Delete data on db"
  }
  sink {
    dataset {
      name = "onlinePositionSubjectDataset"
    }
    name        = "executePositionSubjectDeleteDB"
    description = "Delete data on db"
  }
  sink {
    dataset {
      name = "onlinePositionTransferMbdDataset"
    }
    name        = "executePositionTransferMbdDeleteDB"
    description = "Delete data on db"
  }
  sink {
    dataset {
      name = "onlineRtDataset"
    }
    name        = "executeRtDeleteDB"
    description = "Delete data on db"
  }
  sink {
    dataset {
      name = "onlineRptDataset"
    }
    name        = "executeRptDeleteDB"
    description = "Delete data on db"
  }
  sink {
    dataset {
      name = "onlineCarrelloDataset"
    }
    name        = "executeCarrelloDeleteDB"
    description = "Delete data on db"
  }
  sink {
    dataset {
      name = "onlineRetryRptNotificaCancellazioneDataset"
    }
    name        = "executeRetryRptNotificaCancellazioneDeleteDB"
    description = "Delete data on db"
  }
  sink {
    dataset {
      name = "onlineRetryRptDataset"
    }
    name        = "executeRetryRptDeleteDB"
    description = "Delete data on db"
  }
  sink {
    dataset {
      name = "onlineRetryPaAttivaRptDataset"
    }
    name        = "executeRetryPaAttivaRptDeleteDB"
    description = "Delete data on db"
  }
  sink {
    dataset {
      name = "onlineRetryPspNotificaCancellazioneRptDataset"

    }
    name        = "executeRetryPspNotificaCancellazioneRptDeleteDB"
    description = "Delete data on db"
  }
  sink {
    dataset {
      name = "onlineRetryPspAckDataset"
    }
    name        = "executeRetryPspAckDeleteDB"
    description = "Delete data on db"
  }
  sink {
    dataset {
      name = "onlineRetryPaInviaRtDataset"
    }
    name        = "executeRetryPaInviaRtDeleteDB"
    description = "Delete data on db"
  }
  sink {
    dataset {
      name = "onlinePositionRetrySendpaymentresultDataset"
    }
    name        = "executePositionRetrySendpaymentresultDeleteDB"
    description = "Delete data on db"
  }
  sink {
    dataset {
      name = "onlinePositionRetryPspSendPaymentDataset"
    }
    name        = "executePositionRetryPspSendPaymentDeleteDB"
    description = "Delete data on db"
  }
  sink {
    dataset {
      name = "onlinePositionRetryPaSendRtDataset"
    }
    name        = "executePositionRetryPaSendRtDeleteDB"
    description = "Delete data on db"
  }
  sink {
    dataset {
      name = "onlineRegistroChiamateNotificaRtDataset"
    }
    name        = "executeRegistroChiamateNotificaRtDeleteDB"
    description = "Delete data on db"
  }
  sink {
    dataset {
      name = "onlineVerificaBollettinoDataset"
    }
    name        = "executeVerificaBollettinoDeleteDB"
    description = "Delete data on db"
  }

  script = templatefile("datafactory/dataflows/onlineDataflow.dsl", {})
}

############### PIPELINES ###############
resource "azurerm_data_factory_pipeline" "pipeline_re" {
  depends_on          = [azurerm_data_factory_data_flow.dataflow_re]
  name                = "cleanRePipeline"
  data_factory_id     = azurerm_data_factory.data_factory.id
  resource_group_name = azurerm_private_dns_zone.adf.resource_group_name

  parameters = {
    daysToKeep = 90
  }
  activities_json = file("datafactory/pipelines/reActivities.json")
}

resource "azurerm_data_factory_pipeline" "pipeline_wfesp" {
  depends_on          = [azurerm_data_factory_data_flow.dataflow_wfesp]
  name                = "cleanWfespPipeline"
  data_factory_id     = azurerm_data_factory.data_factory.id
  resource_group_name = azurerm_private_dns_zone.adf.resource_group_name

  parameters = {
    daysToKeep = 90
  }
  activities_json = file("datafactory/pipelines/wfespActivities.json")
}

resource "azurerm_data_factory_pipeline" "pipeline_online" {
  depends_on          = [azurerm_data_factory_data_flow.dataflow_online]
  name                = "cleanOnlinePipeline"
  data_factory_id     = azurerm_data_factory.data_factory.id
  resource_group_name = azurerm_private_dns_zone.adf.resource_group_name

  parameters = {
    daysToKeep = 90
  }
  activities_json = file("datafactory/pipelines/onlineActivities.json")
}


############## TRIGGERS #############
resource "azurerm_data_factory_trigger_schedule" "trigger_re" {
  depends_on          = [azurerm_data_factory_data_flow.dataflow_re]
  name                = "trigger_re_clean_up"
  data_factory_id     = azurerm_data_factory.data_factory.id
  resource_group_name = azurerm_private_dns_zone.adf.resource_group_name
  pipeline_name       = azurerm_data_factory_pipeline.pipeline_re.name
  frequency           = "Day"
  interval            = 1

  #  pipeline_parameters = {
  #    daysToKeep = 90
  #  }

  activated = true

  schedule {
    hours   = [0]
    minutes = [1]
  }

  #  time_zone = "W. Europe Standard Time"
}

resource "azurerm_data_factory_trigger_schedule" "trigger_wfesp" {
  depends_on          = [azurerm_data_factory_data_flow.dataflow_wfesp]
  name                = "trigger_wfesp_clean_up"
  data_factory_id     = azurerm_data_factory.data_factory.id
  resource_group_name = azurerm_private_dns_zone.adf.resource_group_name
  pipeline_name       = azurerm_data_factory_pipeline.pipeline_wfesp.name
  frequency           = "Day"
  interval            = 1
  #  timeZone            = "W. Europe Standard Time"

  #  pipeline_parameters = {
  #    daysToKeep = 90
  #  }

  activated = true

  schedule {
    hours   = [0]
    minutes = [1]
  }
}

resource "azurerm_data_factory_trigger_schedule" "trigger_online" {
  depends_on          = [azurerm_data_factory_data_flow.dataflow_online]
  name                = "trigger_online_clean_up"
  data_factory_id     = azurerm_data_factory.data_factory.id
  resource_group_name = azurerm_private_dns_zone.adf.resource_group_name
  pipeline_name       = azurerm_data_factory_pipeline.pipeline_online.name
  frequency           = "Day"
  interval            = 1
  #  timeZone            = "W. Europe Standard Time"

  #  pipeline_parameters = {
  #    daysToKeep = 90
  #  }

  activated = true

  schedule {
    hours   = [0]
    minutes = [1]
  }
}
