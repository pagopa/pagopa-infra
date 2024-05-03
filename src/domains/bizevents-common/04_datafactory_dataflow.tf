resource "azurerm_data_factory_data_flow" "write_biz_events_to_biz_view" {
  depends_on = [
    azurerm_data_factory_dataset_cosmosdb_sqlapi.biz_events_dataset,
    azurerm_data_factory_dataset_cosmosdb_sqlapi.biz_events_cart_view_dataset,
    azurerm_data_factory_dataset_cosmosdb_sqlapi.biz_events_general_view_dataset,
  azurerm_data_factory_dataset_cosmosdb_sqlapi.biz_events_user_view_dataset]


  data_factory_id = data.azurerm_data_factory.data_factory.id
  name            = "writeBizEventsToBizView"

  # sources
  source {
    name        = "BizEventsSourceData"
    description = "Extract Biz+ to create views"

    dataset {
      name = azurerm_data_factory_dataset_cosmosdb_sqlapi.biz_events_dataset.name
    }
  }

  # sink(s) 

  sink {
    name        = "ViewDebtorUserTarget"
    description = "Add sink dataset for biz-event-view-user"

    dataset {
      name = azurerm_data_factory_dataset_cosmosdb_sqlapi.biz_events_user_view_dataset.name
    }
  }
  sink {
    name        = "ViewPayerUserTarget"
    description = "Add sink dataset for biz-event-view-user"

    dataset {
      name = azurerm_data_factory_dataset_cosmosdb_sqlapi.biz_events_user_view_dataset.name
    }
  }
  sink {
    name        = "ViewGeneralTarget"
    description = "Add sink dataset for biz-event-view-general"

    dataset {
      name = azurerm_data_factory_dataset_cosmosdb_sqlapi.biz_events_general_view_dataset.name
    }
  }
  sink {
    name        = "ViewCartTarget"
    description = "Add sink dataset for biz-event-view-cart"

    dataset {
      name = azurerm_data_factory_dataset_cosmosdb_sqlapi.biz_events_cart_view_dataset.name
    }
  }
  sink {
    name        = "ViewUserTarget"
    description = "Add sink dataset for biz-event-view-user"

    dataset {
      name = azurerm_data_factory_dataset_cosmosdb_sqlapi.biz_events_user_view_dataset.name
    }
  }

  # transformation(s)
  transformation {
    name = "externalCallDebtorTokenizer"
    linked_service {
      name = "${var.env}_TokenizerRestService"
    }
  }
  transformation {
    name = "externalCallPayerTokenizer"
    linked_service {
      name = "${var.env}_TokenizerRestService"
    }
  }
  transformation {
    name        = "derivedViewColumns"
    description = "Creating/updating the columns for view containers"
  }
  transformation {
    name        = "splitSameDebtorAndPayer"
    description = "Check if payer and debtor are the same"
  }
  transformation {
    name        = "derivedSameDebtorAndPayerView"
    description = "Creating/updating the columns for user view container"
  }
  transformation {
    name        = "derivedDebtorView"
    description = "Creating/updating the columns for user view container"
  }
  transformation {
    name        = "derivedGeneralViewObject"
    description = "Creating/updating the columns for view containers"
  }
  transformation {
    name        = "derivedPayerView"
    description = "Creating/updating the columns for user view container"
  }
  transformation {
    name = "derivedSortTransferList"
  }
  transformation {
    name = "derivedTransferListRemittanceInformation"
  }
  transformation {
    name = "derivedCartViewSubjectAndDebtor"
  }
  transformation {
    name        = "derivedColumnDebtorTaxCode"
    description = "Creating/updating the columns for view containers"
  }
  transformation {
    name        = "derivedColumnPayerTaxCode"
    description = "Creating/updating the columns for view containers"
  }

  script = templatefile("datafactory/dataflows/writeBizEventsToBizView.dsl", {})
}
