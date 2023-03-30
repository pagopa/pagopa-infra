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
  datasets   = { for filename in fileset(path.module, "datafactory/datasets/*.json") : replace(basename(filename), ".json", "") => file("${path.module}/${filename}") }
  reDataflow = file("datafactory/dataflows/re.dataflow")
}

############### LINKED SERVICE ####################
#resource "azurerm_data_factory_linked_service_postgresql" "azure_postgresql_ls" {
#  depends_on          = [azurerm_data_factory.data_factory]
#  name                = "AzurePostgreSqlLinkedService"
#  data_factory_id     = azurerm_data_factory.data_factory.id
#  resource_group_name = azurerm_resource_group.data_factory_rg.name
#  connection_string   = "host=pagopa-${var.env_short}-weu-nodo-flexible-postgresql.postgres.database.azure.com;port=5432;database=nodo;uid=${local.administrator_login};encryptionmethod=1;validateservercertificate=0;password=${local.administrator_password}"
#  additional_properties = {
#    "type": "AzurePostgreSql"
#  }
#
#}

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

  script = templatefile("datafactory/dataflows/re.dataflow", {})
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

  script = templatefile("datafactory/dataflows/wfesp.dataflow", {})
}



resource "azurerm_data_factory_data_flow" "dataflow_online" {
  depends_on      = [azurerm_data_factory_custom_dataset.datasets]
  data_factory_id = azurerm_data_factory.data_factory.id
  name            = "onlineDataflow"

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

  script = templatefile("datafactory/dataflows/online.dataflow", {})
}
