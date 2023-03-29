resource "azurerm_data_factory_data_flow" "dataflow_re" {
  depends_on      = [azurerm_data_factory_custom_dataset.datasets]
  data_factory_id = azurerm_data_factory.data_factory.id
  name            = "reDataflow"

  source {
    name        = "reExtract"
    description = "Extract re where inserted_timestamp < (today-n)"

    dataset {
      name = "reDataset"
    }
  }
  transformation {
    name        = "checkRecordToDelete"
    description = "deleting record if inserted_timestamp < now - 'n days' "
  }

  sink {
    name        = "sinkReDeleteDB"
    description = "Delete data of re"

    dataset {
      name = "reDataset"
    }
  }

  script = templatefile("datafactory/dataflows/re.dataflow", {
    daysToKeep = 90
  })

}
