resource "azurerm_data_factory_data_flow" "dataflow_recoverTxViews" {
  count = var.env_short == "p" ? 0 : 1

  depends_on      = [
    azurerm_data_factory_custom_dataset.biz_events_datasets_cosmos,
  ]
  data_factory_id = data.azurerm_data_factory.qi_data_factory_cosmos.id
  name            = "recoverTxViews"

  source {
    name        = "bizCosmosRead"

    dataset {
      name = "biz-events"
    }
  }

  source {
    name        = "pmPostgresRead"

  }

  transformation {
    name = "uniteFlows"
  }
  transformation {
    name        = "joinWithTokenizerDebtor"
  }
  transformation {
    name = "deriveViewColumns"
  }
  transformation {
    name = "JoinWithTokenizerResponse"
  }
  transformation {
    name        = "mapUserViewData"
  }
  transformation {
    name = "selectPayerUserView"
  }
  transformation {
    name = "selectDebtorUserView"
  }
  transformation {
    name        = "addDebtorPii"
  }
  transformation {
    name        = "tokenizeDebtorTaxCode"
  }
  transformation {
    name        = "selectDebtorTaxCode"
  }
  transformation {
    name        = "deriveDebtorBody"
  }
  transformation {
    name        = "selectCartItemView"
  }
  transformation {
    name        = "selectTaxCode"
  }
  transformation {
    name        = "addPayerPii"
  }
  transformation {
    name        = "tokenizePayerData"
  }
  transformation {
    name        = "derivedPayerBody"
  }
  transformation {
    name        = "selectGeneralViewData"
  }
  transformation {
    name        = "txToEventDerive"
  }
  transformation {
    name        = "selectConvertedFields"
  }
  transformation {
    name        = "selectGeneralViewData"
  }
  transformation {
    name        = "selectDataToSave"
  }

  sink {
    name        = "cartGeneralViewData"
    description = "Insert data on general view"

    dataset {
      name = "biz-events-view-general"
    }
  }
  sink {
    name        = "debtorUserViewSink"
    description = "Insert data on user view"

    dataset {
      name = "biz-events-view-user"
    }
  }
  sink {
    name        = "payerUserViewSink"
    description = "Insert data on user view"

    dataset {
      name = "biz-events-view-user"
    }
  }
  sink {
    name        = "cartItemView"
    description = "Insert data on cart view"

    dataset {
      name = "biz-events-view-cart"
    }
  }

  script = templatefile("datafactory/dataflows/recoverTxViews.dsl", {})
}
