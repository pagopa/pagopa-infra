#resource "azurerm_data_factory_data_flow" "dataflow_recoverTxViews" {
#  count = var.env_short == "p" ? 0 : 1
#
#  depends_on      = [
#    azurerm_data_factory_dataset_cosmosdb_sqlapi.biz-events,
#    azurerm_data_factory_dataset_cosmosdb_sqlapi.biz-events-view-general,
#    azurerm_data_factory_dataset_cosmosdb_sqlapi.biz-events-view-item,
#    azurerm_data_factory_dataset_cosmosdb_sqlapi.biz-events-view-user
#  ]
#  data_factory_id = azurerm_data_factory.data_factory.id
#  name            = "recoverTxViews"
#
#  source {
#    name        = "bizEventsRead"
#    description = "Extract biz-events where inserted_timestamp < (today-n)"
#
#    dataset {
#      name = "biz-events"
#    }
#  }
#
#  transformation {
#    name = "tokenizePayerData"
#    description = "tokenize payer data"
#  }
#  transformation {
#    name        = "mapGeneralViewData"
#    description = "map biz-event record to general data view"
#  }
#  transformation {
#    name = "tokenizePayerData"
#    description = "tokenize payer data"
#  }
#  transformation {
#    name = "branchToUserViewData"
#    description = "branch execution for user view insertion"
#  }
#  transformation {
#    name        = "mapUserViewData"
#    description = "map biz-event record to user view"
#  }
#  transformation {
#    name = "tokenizeDebtorData"
#    description = "tokenize debtor data"
#  }
#  transformation {
#    name = "branchToCartViewData"
#    description = "branch execution for cart view insertion"
#  }
#  transformation {
#    name        = "mapCartViewData"
#    description = "map biz-event record to cart view"
#  }
#
#  sink {
#    name        = "insertOnGeneralView"
#    description = "Insert data on general view"
#
#    dataset {
#      name = "biz-events-view-general"
#    }
#  }
#  sink {
#    name        = "insertOnUserView"
#    description = "Insert data on user view"
#
#    dataset {
#      name = "biz-events-view-user"
#    }
#  }
#  sink {
#    name        = "insertOnCartView"
#    description = "Insert data on cart view"
#
#    dataset {
#      name = "biz-events-view-cart"
#    }
#  }
#
#  script = templatefile("datafactory/dataflows/recoverTxViews.dsl", {})
#}
