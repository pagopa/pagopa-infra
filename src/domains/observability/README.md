# observability

# Connected Service Configuration – Usage Guide

## Overview

The file `05_connected_service_configuration.tf` centralizes the configuration of managed private endpoints and linked services used by Azure Data Factory. It defines four main `locals` blocks, each serving a specific integration purpose.

---

## How to Add a New Private Endpoint and Linked Service

### Step 1 – Define a Managed Private Endpoint

Add a new entry to the `data_factory_managed_private_endpoint` local map. Each entry requires the following attributes:

| Attribute | Description                                                                                                                                                                    |
|---|--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| `target_resource_id` | The Azure resource ID of the target service                                                                                                                                    |
| `fqdns` | List of FQDNs retrieved from Key Vault for DNS resolution, or `null`                                                                                                           |
| `subresource_name` | The sub-resource name required for connection approval (optional, service-dependent)                                                                                           |
| `type` | The resource type, used to map the correct Azure API for private endpoint approval. Allowed values defined in `local.az_api_type_mappings`, e.g., `cosmosdb`, `storage`, `postgres` |

**Example:**

```hcl
data_factory_managed_private_endpoint = {
  MyCosmosEndpoint = {
    target_resource_id = data.azurerm_cosmosdb_account.my_cosmos_account.id
    fqdns              = null
    subresource_name   = "Sql"
    type               = "cosmosdb"
  }
}
```

---

### Step 2 – Define the Linked Service

Depending on the target resource type, add a corresponding entry to the appropriate linked service map.

#### CosmosDB

Add an entry to `data_factory_linked_services_cosmosdb`:

| Attribute | Description |
|---|---|
| `connection_string` | The primary SQL connection string of the Cosmos DB account |
| `account_name` | The name of the Cosmos DB account |
| `database` | The name of the target database |

```hcl
data_factory_linked_services_cosmosdb = {
  MyCosmosService = {
    connection_string = data.azurerm_cosmosdb_account.my_cosmos_account.primary_sql_connection_string
    account_name       = data.azurerm_cosmosdb_account.my_cosmos_account.name
    database          = "MyDatabase"
  }
}
```

#### Blob Storage

Add an entry to `data_factory_linked_services_blob`:

| Attribute | Description |
|---|---|
| `connection_string` | The connection string of the Azure Blob Storage account |

```hcl
data_factory_linked_services_blob = {
  MyStorageService = {
    connection_string = data.azurerm_storage_account.my_storage_account.primary_connection_string
  }
}
```

#### PostgreSQL

Add an entry to `data_factory_linked_services_postgres`. Credentials are retrieved from Azure Key Vault:

| Attribute | Description |
|---|---|
| `key_vault_id` | The ID of the Key Vault containing the secrets |
| `host_secret_name` | Name of the secret storing the PostgreSQL server hostname |
| `port_secret_name` | Name of the secret storing the server port |
| `database_secret_name` | Name of the secret storing the database name |
| `username_secret_name` | Name of the secret storing the authentication username |
| `password_secret_name` | Name of the secret storing the authentication password |

```hcl
data_factory_linked_services_postgres = {
  MyPostgresService = {
    key_vault_id         = data.azurerm_key_vault.my_kv.id
    host_secret_name     = "my-postgres-host"
    port_secret_name     = "my-postgres-port"
    database_secret_name = "my-postgres-database"
    username_secret_name = "my-postgres-username"
    password_secret_name = "my-postgres-password"
  }
}
```

---

### Step 3 – Verify API Type Mapping

The `az_api_type_mappings` local maps each resource type to the corresponding Azure API versions used for data retrieval and private endpoint connection approval. This block does not require modification unless a new resource type is introduced.

The currently supported types are:

| Type |
|---|
| `cosmosdb` | 
| `storage` |
| `postgres` |
---



<!-- markdownlint-disable -->
<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_azapi"></a> [azapi](#requirement\_azapi) | <= 2.0.1 |
| <a name="requirement_azuread"></a> [azuread](#requirement\_azuread) | ~> 3.1 |
| <a name="requirement_azurerm"></a> [azurerm](#requirement\_azurerm) | ~> 4.16 |
| <a name="requirement_null"></a> [null](#requirement\_null) | <= 3.2.1 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module___v4__"></a> [\_\_v4\_\_](#module\_\_\_v4\_\_) | git::https://github.com/pagopa/terraform-azurerm-v4 | d9105c01f5a063ec4742d3c8443c96109ca87a68 |
| <a name="module_eventhub_namespace_observability"></a> [eventhub\_namespace\_observability](#module\_eventhub\_namespace\_observability) | ./.terraform/modules/__v4__/eventhub | n/a |
| <a name="module_eventhub_namespace_observability_gpd"></a> [eventhub\_namespace\_observability\_gpd](#module\_eventhub\_namespace\_observability\_gpd) | ./.terraform/modules/__v4__/eventhub | n/a |
| <a name="module_eventhub_observability_configuration"></a> [eventhub\_observability\_configuration](#module\_eventhub\_observability\_configuration) | ./.terraform/modules/__v4__/eventhub_configuration | n/a |
| <a name="module_eventhub_observability_gpd_configuration"></a> [eventhub\_observability\_gpd\_configuration](#module\_eventhub\_observability\_gpd\_configuration) | ./.terraform/modules/__v4__/eventhub_configuration | n/a |
| <a name="module_eventhub_observability_gpd_spoke_pe_snet"></a> [eventhub\_observability\_gpd\_spoke\_pe\_snet](#module\_eventhub\_observability\_gpd\_spoke\_pe\_snet) | ./.terraform/modules/__v4__/IDH/subnet | n/a |
| <a name="module_eventhub_observability_spoke_pe_snet"></a> [eventhub\_observability\_spoke\_pe\_snet](#module\_eventhub\_observability\_spoke\_pe\_snet) | ./.terraform/modules/__v4__/IDH/subnet | n/a |
| <a name="module_gpd_ingestion_sa"></a> [gpd\_ingestion\_sa](#module\_gpd\_ingestion\_sa) | ./.terraform/modules/__v4__/storage_account | n/a |
| <a name="module_observability_sa"></a> [observability\_sa](#module\_observability\_sa) | ./.terraform/modules/__v4__/storage_account | n/a |
| <a name="module_observability_st_snet"></a> [observability\_st\_snet](#module\_observability\_st\_snet) | ./.terraform/modules/__v4__/subnet | n/a |
| <a name="module_tag_config"></a> [tag\_config](#module\_tag\_config) | ../../tag_config | n/a |

## Resources

| Name | Type |
|------|------|
| [azapi_resource.df_connection_linked_service_postgres](https://registry.terraform.io/providers/azure/azapi/latest/docs/resources/resource) | resource |
| [azapi_resource.ls_postgres_cruscotto](https://registry.terraform.io/providers/azure/azapi/latest/docs/resources/resource) | resource |
| [azapi_resource.ls_postgres_cruscotto_tf](https://registry.terraform.io/providers/azure/azapi/latest/docs/resources/resource) | resource |
| [azapi_resource.ls_postgres_nodo_tf](https://registry.terraform.io/providers/azure/azapi/latest/docs/resources/resource) | resource |
| [azapi_resource.pdnd_cdc_gec_bundles_dataflow](https://registry.terraform.io/providers/azure/azapi/latest/docs/resources/resource) | resource |
| [azapi_resource.pdnd_cdc_gec_cibundles_dataflow](https://registry.terraform.io/providers/azure/azapi/latest/docs/resources/resource) | resource |
| [azapi_resource.pdnd_cdc_gec_paymenttypes_dataflow](https://registry.terraform.io/providers/azure/azapi/latest/docs/resources/resource) | resource |
| [azapi_resource.pdnd_cdc_gec_touchpoints_dataflow](https://registry.terraform.io/providers/azure/azapi/latest/docs/resources/resource) | resource |
| [azapi_resource_action.approve_privatelink_private_endpoint_connection](https://registry.terraform.io/providers/azure/azapi/latest/docs/resources/resource_action) | resource |
| [azapi_resource_action.df_connection_approve_private_endpoint_connection](https://registry.terraform.io/providers/azure/azapi/latest/docs/resources/resource_action) | resource |
| [azurerm_data_factory_custom_dataset.cfg_tables_list_datasets](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/data_factory_custom_dataset) | resource |
| [azurerm_data_factory_custom_dataset.crusc8_tables_datasets](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/data_factory_custom_dataset) | resource |
| [azurerm_data_factory_custom_dataset.qi_datasets](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/data_factory_custom_dataset) | resource |
| [azurerm_data_factory_custom_dataset.qi_datasets_cosmos](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/data_factory_custom_dataset) | resource |
| [azurerm_data_factory_dataset_json.afm_gec_bundle_cdc_json](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/data_factory_dataset_json) | resource |
| [azurerm_data_factory_dataset_json.afm_gec_cibundle_cdc_json](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/data_factory_dataset_json) | resource |
| [azurerm_data_factory_dataset_json.afm_gec_paymenttypes_cdc_json](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/data_factory_dataset_json) | resource |
| [azurerm_data_factory_dataset_json.afm_gec_touchpoints_cdc_json](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/data_factory_dataset_json) | resource |
| [azurerm_data_factory_linked_custom_service.df_connection_linked_service_cosmosdb](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/data_factory_linked_custom_service) | resource |
| [azurerm_data_factory_linked_service_azure_blob_storage.afm_gec_storage_linked_service](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/data_factory_linked_service_azure_blob_storage) | resource |
| [azurerm_data_factory_linked_service_azure_blob_storage.df_connection_linked_service_blob](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/data_factory_linked_service_azure_blob_storage) | resource |
| [azurerm_data_factory_linked_service_cosmosdb.afm_gec_cosmosdb_linked_service](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/data_factory_linked_service_cosmosdb) | resource |
| [azurerm_data_factory_linked_service_cosmosdb.cosmos_biz](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/data_factory_linked_service_cosmosdb) | resource |
| [azurerm_data_factory_linked_service_key_vault.df_connection_linked_service_key_vault](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/data_factory_linked_service_key_vault) | resource |
| [azurerm_data_factory_linked_service_key_vault.ls_df_to_kv](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/data_factory_linked_service_key_vault) | resource |
| [azurerm_data_factory_linked_service_key_vault.ls_df_to_kv_nodo](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/data_factory_linked_service_key_vault) | resource |
| [azurerm_data_factory_linked_service_kusto.dataexp_ls](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/data_factory_linked_service_kusto) | resource |
| [azurerm_data_factory_managed_private_endpoint.df_connection_managed_private_endpoint](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/data_factory_managed_private_endpoint) | resource |
| [azurerm_data_factory_managed_private_endpoint.private_endpoint](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/data_factory_managed_private_endpoint) | resource |
| [azurerm_data_factory_pipeline.pipeline_KPI_FDR_IMPORT_ESITI](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/data_factory_pipeline) | resource |
| [azurerm_data_factory_pipeline.pipeline_KPI_FDR_IMPORT_ESITI_DAILY_Manuale](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/data_factory_pipeline) | resource |
| [azurerm_data_factory_pipeline.pipeline_KPI_FDR_IMPORT_ESITI_Manuale](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/data_factory_pipeline) | resource |
| [azurerm_data_factory_pipeline.pipeline_KPI_FDR_RENDICONTAZIONI](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/data_factory_pipeline) | resource |
| [azurerm_data_factory_pipeline.pipeline_KPI_TNSPO](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/data_factory_pipeline) | resource |
| [azurerm_data_factory_pipeline.pipeline_KPI_TPNP](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/data_factory_pipeline) | resource |
| [azurerm_data_factory_pipeline.pipeline_KPI_TPNP_Recupero](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/data_factory_pipeline) | resource |
| [azurerm_data_factory_pipeline.pipeline_KPI_TPSPO_DASPO](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/data_factory_pipeline) | resource |
| [azurerm_data_factory_pipeline.pipeline_PDND_CDC_GEC_BUNDLES](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/data_factory_pipeline) | resource |
| [azurerm_data_factory_pipeline.pipeline_PDND_CDC_GEC_CIBUNDLES](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/data_factory_pipeline) | resource |
| [azurerm_data_factory_pipeline.pipeline_PDND_CDC_GEC_PAYMENTTYPES](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/data_factory_pipeline) | resource |
| [azurerm_data_factory_pipeline.pipeline_PDND_CDC_GEC_TOUCHPOINTS](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/data_factory_pipeline) | resource |
| [azurerm_data_factory_pipeline.pipeline_PDND_KPI_DASPO](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/data_factory_pipeline) | resource |
| [azurerm_data_factory_pipeline.pipeline_PDND_KPI_LFDR](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/data_factory_pipeline) | resource |
| [azurerm_data_factory_pipeline.pipeline_PDND_KPI_LSPO](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/data_factory_pipeline) | resource |
| [azurerm_data_factory_pipeline.pipeline_PDND_KPI_NRFDR](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/data_factory_pipeline) | resource |
| [azurerm_data_factory_pipeline.pipeline_PDND_KPI_TNSPO](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/data_factory_pipeline) | resource |
| [azurerm_data_factory_pipeline.pipeline_PDND_KPI_TPNP](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/data_factory_pipeline) | resource |
| [azurerm_data_factory_pipeline.pipeline_PDND_KPI_WAFDR](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/data_factory_pipeline) | resource |
| [azurerm_data_factory_pipeline.pipeline_PDND_KPI_WPNFDR](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/data_factory_pipeline) | resource |
| [azurerm_data_factory_pipeline.pipeline_SMO_IMPORT_ANAGRAFICA](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/data_factory_pipeline) | resource |
| [azurerm_data_factory_pipeline.pipeline_SMO_QPT_RECEIPT](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/data_factory_pipeline) | resource |
| [azurerm_data_factory_pipeline.pipeline_SMO_QPT_TAXONOMY_AGGREGATE](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/data_factory_pipeline) | resource |
| [azurerm_data_factory_pipeline.pipeline_SMO_QPT_TIMEOUT](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/data_factory_pipeline) | resource |
| [azurerm_data_factory_pipeline.pipeline_SMO_QPT_TRANSACTION](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/data_factory_pipeline) | resource |
| [azurerm_data_factory_trigger_schedule.Trigger_KPI_FDR_IMPORT_ESITI](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/data_factory_trigger_schedule) | resource |
| [azurerm_data_factory_trigger_schedule.Trigger_KPI_FDR_RENDICONTAZIONI](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/data_factory_trigger_schedule) | resource |
| [azurerm_data_factory_trigger_schedule.Trigger_KPI_TNSPO](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/data_factory_trigger_schedule) | resource |
| [azurerm_data_factory_trigger_schedule.Trigger_KPI_TPNP](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/data_factory_trigger_schedule) | resource |
| [azurerm_data_factory_trigger_schedule.Trigger_KPI_TPSPO_DASPO](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/data_factory_trigger_schedule) | resource |
| [azurerm_data_factory_trigger_schedule.Trigger_PDND_CDC_GEC_BUNDLES](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/data_factory_trigger_schedule) | resource |
| [azurerm_data_factory_trigger_schedule.Trigger_PDND_CDC_GEC_CIBUNDLES](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/data_factory_trigger_schedule) | resource |
| [azurerm_data_factory_trigger_schedule.Trigger_PDND_CDC_GEC_PAYMENTTYPES](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/data_factory_trigger_schedule) | resource |
| [azurerm_data_factory_trigger_schedule.Trigger_PDND_CDC_GEC_TOUCHPOINTS](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/data_factory_trigger_schedule) | resource |
| [azurerm_data_factory_trigger_schedule.Trigger_PDND_KPI_DASPO](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/data_factory_trigger_schedule) | resource |
| [azurerm_data_factory_trigger_schedule.Trigger_PDND_KPI_LFDR](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/data_factory_trigger_schedule) | resource |
| [azurerm_data_factory_trigger_schedule.Trigger_PDND_KPI_LSPO](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/data_factory_trigger_schedule) | resource |
| [azurerm_data_factory_trigger_schedule.Trigger_PDND_KPI_NRFDR](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/data_factory_trigger_schedule) | resource |
| [azurerm_data_factory_trigger_schedule.Trigger_PDND_KPI_TNSPO](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/data_factory_trigger_schedule) | resource |
| [azurerm_data_factory_trigger_schedule.Trigger_PDND_KPI_TPNP](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/data_factory_trigger_schedule) | resource |
| [azurerm_data_factory_trigger_schedule.Trigger_PDND_KPI_WAFDR](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/data_factory_trigger_schedule) | resource |
| [azurerm_data_factory_trigger_schedule.Trigger_PDND_KPI_WPNFDR](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/data_factory_trigger_schedule) | resource |
| [azurerm_data_factory_trigger_schedule.Trigger_SMO_IMPORT_ANAGRAFICA](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/data_factory_trigger_schedule) | resource |
| [azurerm_data_factory_trigger_schedule.Trigger_SMO_QPT_RECEIPT](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/data_factory_trigger_schedule) | resource |
| [azurerm_data_factory_trigger_schedule.Trigger_SMO_QPT_TAXONOMY_AGGREGATE](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/data_factory_trigger_schedule) | resource |
| [azurerm_data_factory_trigger_schedule.Trigger_SMO_QPT_TIMEOUT](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/data_factory_trigger_schedule) | resource |
| [azurerm_data_factory_trigger_schedule.Trigger_SMO_QPT_TRANSACTION](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/data_factory_trigger_schedule) | resource |
| [azurerm_eventhub_consumer_group.rtp_consumer_gpd](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/eventhub_consumer_group) | resource |
| [azurerm_eventhub_namespace_authorization_rule.cdc_connection_string](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/eventhub_namespace_authorization_rule) | resource |
| [azurerm_eventhub_namespace_authorization_rule.cdc_test_connection_string](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/eventhub_namespace_authorization_rule) | resource |
| [azurerm_key_vault_access_policy.df_connection_access_kv](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/key_vault_access_policy) | resource |
| [azurerm_key_vault_access_policy.df_see_kv_cruscotto](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/key_vault_access_policy) | resource |
| [azurerm_key_vault_access_policy.df_see_kv_nodo](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/key_vault_access_policy) | resource |
| [azurerm_key_vault_secret.azure_web_jobs_storage_kv](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/key_vault_secret) | resource |
| [azurerm_kusto_cluster.data_explorer_cluster](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/kusto_cluster) | resource |
| [azurerm_kusto_database.pm_db](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/kusto_database) | resource |
| [azurerm_kusto_database.re_db](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/kusto_database) | resource |
| [azurerm_kusto_database_principal_assignment.qi_principal_assignment](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/kusto_database_principal_assignment) | resource |
| [azurerm_kusto_eventhub_data_connection.eventhub_connection_for_ingestion_qi_fdr](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/kusto_eventhub_data_connection) | resource |
| [azurerm_kusto_eventhub_data_connection.eventhub_connection_for_ingestion_qi_iuvs](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/kusto_eventhub_data_connection) | resource |
| [azurerm_kusto_eventhub_data_connection.eventhub_connection_for_re_event](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/kusto_eventhub_data_connection) | resource |
| [azurerm_kusto_script.create_merge_table](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/kusto_script) | resource |
| [azurerm_private_endpoint.eventhub_gpd_spoke_pe](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/private_endpoint) | resource |
| [azurerm_private_endpoint.eventhub_spoke_pe](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/private_endpoint) | resource |
| [azurerm_private_endpoint.observability_storage_private_endpoint](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/private_endpoint) | resource |
| [azurerm_resource_group.eventhub_observability_rg](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/resource_group) | resource |
| [azurerm_resource_group.gpd_ingestion_rg](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/resource_group) | resource |
| [azurerm_resource_group.st_observability_rg](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/resource_group) | resource |
| [azurerm_role_assignment.adgroup_dataexp_reader](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/role_assignment) | resource |
| [azurerm_role_assignment.fdr_qi_fdr_iuvs_data_evh_data_receiver_role](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/role_assignment) | resource |
| [azurerm_role_assignment.fdr_qi_flow_data_evh_data_receiver_role](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/role_assignment) | resource |
| [azurerm_storage_container.blob-observability-st](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/storage_container) | resource |
| [azapi_resource.df_connection_privatelink_private_endpoint_connection](https://registry.terraform.io/providers/azure/azapi/latest/docs/data-sources/resource) | data source |
| [azapi_resource.privatelink_private_endpoint_connection](https://registry.terraform.io/providers/azure/azapi/latest/docs/data-sources/resource) | data source |
| [azuread_group.adgroup_developers](https://registry.terraform.io/providers/hashicorp/azuread/latest/docs/data-sources/group) | data source |
| [azuread_group.adgroup_externals](https://registry.terraform.io/providers/hashicorp/azuread/latest/docs/data-sources/group) | data source |
| [azuread_group.adgroup_operations](https://registry.terraform.io/providers/hashicorp/azuread/latest/docs/data-sources/group) | data source |
| [azuread_group.adgroup_technical_project_managers](https://registry.terraform.io/providers/hashicorp/azuread/latest/docs/data-sources/group) | data source |
| [azurerm_client_config.current](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/client_config) | data source |
| [azurerm_cosmosdb_account.afm_cosmos_account](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/cosmosdb_account) | data source |
| [azurerm_cosmosdb_account.bizevent_cosmos_account](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/cosmosdb_account) | data source |
| [azurerm_cosmosdb_account.ecommerce_cosmos_account](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/cosmosdb_account) | data source |
| [azurerm_data_factory.obeserv_data_factory](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/data_factory) | data source |
| [azurerm_eventhub.pagopa-evh-ns03_nodo-dei-pagamenti-re_nodo-dei-pagamenti-re](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/eventhub) | data source |
| [azurerm_eventhub.pagopa-evh-ns04_nodo-dei-pagamenti-fdr-qi-fdr-iuvs](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/eventhub) | data source |
| [azurerm_eventhub.pagopa-evh-ns04_nodo-dei-pagamenti-fdr-qi-flows](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/eventhub) | data source |
| [azurerm_key_vault.cruscotto_kv](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/key_vault) | data source |
| [azurerm_key_vault.gps_kv](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/key_vault) | data source |
| [azurerm_key_vault.kv](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/key_vault) | data source |
| [azurerm_key_vault.network_kv](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/key_vault) | data source |
| [azurerm_key_vault.nodo_kv](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/key_vault) | data source |
| [azurerm_key_vault.qi-kv](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/key_vault) | data source |
| [azurerm_key_vault_secret.cruscotto_db_database](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/key_vault_secret) | data source |
| [azurerm_key_vault_secret.cruscotto_db_host](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/key_vault_secret) | data source |
| [azurerm_key_vault_secret.cruscotto_db_port](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/key_vault_secret) | data source |
| [azurerm_key_vault_secret.cruscotto_db_username](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/key_vault_secret) | data source |
| [azurerm_key_vault_secret.database_proxy_fqdn](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/key_vault_secret) | data source |
| [azurerm_key_vault_secret.df_connection_postgres_database](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/key_vault_secret) | data source |
| [azurerm_key_vault_secret.df_connection_postgres_host](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/key_vault_secret) | data source |
| [azurerm_key_vault_secret.df_connection_postgres_port](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/key_vault_secret) | data source |
| [azurerm_key_vault_secret.df_connection_postgres_username](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/key_vault_secret) | data source |
| [azurerm_key_vault_secret.nodo_db_database](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/key_vault_secret) | data source |
| [azurerm_key_vault_secret.nodo_db_host](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/key_vault_secret) | data source |
| [azurerm_key_vault_secret.nodo_db_port](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/key_vault_secret) | data source |
| [azurerm_key_vault_secret.nodo_db_username](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/key_vault_secret) | data source |
| [azurerm_monitor_action_group.email](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/monitor_action_group) | data source |
| [azurerm_monitor_action_group.slack](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/monitor_action_group) | data source |
| [azurerm_private_dns_zone.eventhub](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/private_dns_zone) | data source |
| [azurerm_private_dns_zone.storage](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/private_dns_zone) | data source |
| [azurerm_private_link_service.vmss_pls](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/private_link_service) | data source |
| [azurerm_resource_group.monitor_rg](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/resource_group) | data source |
| [azurerm_resource_group.rg_vnet_italy](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/resource_group) | data source |
| [azurerm_storage_account.observ_storage_account](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/storage_account) | data source |
| [azurerm_subscription.current](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/subscription) | data source |
| [azurerm_virtual_network.vnet](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/virtual_network) | data source |
| [azurerm_virtual_network.vnet_italy](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/virtual_network) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_cidr_subnet_observability_storage"></a> [cidr\_subnet\_observability\_storage](#input\_cidr\_subnet\_observability\_storage) | Storage address space | `list(string)` | `null` | no |
| <a name="input_dexp_db"></a> [dexp\_db](#input\_dexp\_db) | n/a | <pre>object({<br/>    enable             = bool<br/>    hot_cache_period   = string<br/>    soft_delete_period = string<br/>  })</pre> | n/a | yes |
| <a name="input_dexp_params"></a> [dexp\_params](#input\_dexp\_params) | n/a | <pre>object({<br/>    enabled = bool<br/>    sku = object({<br/>      name     = string<br/>      capacity = number<br/>    })<br/>    autoscale = object({<br/>      enabled       = bool<br/>      min_instances = number<br/>      max_instances = number<br/>    })<br/>    public_network_access_enabled = bool<br/>    double_encryption_enabled     = bool<br/>    disk_encryption_enabled       = bool<br/>    purge_enabled                 = bool<br/>  })</pre> | n/a | yes |
| <a name="input_dexp_pm_db"></a> [dexp\_pm\_db](#input\_dexp\_pm\_db) | n/a | <pre>object({<br/>    enable             = bool<br/>    hot_cache_period   = string<br/>    soft_delete_period = string<br/>  })</pre> | <pre>{<br/>  "enable": false,<br/>  "hot_cache_period": "P5D",<br/>  "soft_delete_period": "P365D"<br/>}</pre> | no |
| <a name="input_domain"></a> [domain](#input\_domain) | n/a | `string` | n/a | yes |
| <a name="input_ehns_alerts_enabled"></a> [ehns\_alerts\_enabled](#input\_ehns\_alerts\_enabled) | Event hub alerts enabled? | `bool` | n/a | yes |
| <a name="input_ehns_auto_inflate_enabled"></a> [ehns\_auto\_inflate\_enabled](#input\_ehns\_auto\_inflate\_enabled) | Is Auto Inflate enabled for the EventHub Namespace? | `bool` | n/a | yes |
| <a name="input_ehns_capacity"></a> [ehns\_capacity](#input\_ehns\_capacity) | Specifies the Capacity / Throughput Units for a Standard SKU namespace. | `number` | n/a | yes |
| <a name="input_ehns_maximum_throughput_units"></a> [ehns\_maximum\_throughput\_units](#input\_ehns\_maximum\_throughput\_units) | Specifies the maximum number of throughput units when Auto Inflate is Enabled | `number` | n/a | yes |
| <a name="input_ehns_metric_alerts"></a> [ehns\_metric\_alerts](#input\_ehns\_metric\_alerts) | Map of name = criteria objects | <pre>map(object({<br/>    # criteria.*.aggregation to be one of [Average Count Minimum Maximum Total]<br/>    aggregation = string<br/>    metric_name = string<br/>    description = string<br/>    # criteria.0.operator to be one of [Equals NotEquals GreaterThan GreaterThanOrEqual LessThan LessThanOrEqual]<br/>    operator  = string<br/>    threshold = number<br/>    # Possible values are PT1M, PT5M, PT15M, PT30M and PT1H<br/>    frequency = string<br/>    # Possible values are PT1M, PT5M, PT15M, PT30M, PT1H, PT6H, PT12H and P1D.<br/>    window_size = string<br/><br/>    dimension = list(object(<br/>      {<br/>        name     = string<br/>        operator = string<br/>        values   = list(string)<br/>      }<br/>    ))<br/>  }))</pre> | `{}` | no |
| <a name="input_ehns_metric_alerts_gpd"></a> [ehns\_metric\_alerts\_gpd](#input\_ehns\_metric\_alerts\_gpd) | Map of name = criteria objects | <pre>map(object({<br/>    # criteria.*.aggregation to be one of [Average Count Minimum Maximum Total]<br/>    aggregation = string<br/>    metric_name = string<br/>    description = string<br/>    # criteria.0.operator to be one of [Equals NotEquals GreaterThan GreaterThanOrEqual LessThan LessThanOrEqual]<br/>    operator  = string<br/>    threshold = number<br/>    # Possible values are PT1M, PT5M, PT15M, PT30M and PT1H<br/>    frequency = string<br/>    # Possible values are PT1M, PT5M, PT15M, PT30M, PT1H, PT6H, PT12H and P1D.<br/>    window_size = string<br/><br/>    dimension = list(object(<br/>      {<br/>        name     = string<br/>        operator = string<br/>        values   = list(string)<br/>      }<br/>    ))<br/>  }))</pre> | `{}` | no |
| <a name="input_ehns_private_endpoint_is_present"></a> [ehns\_private\_endpoint\_is\_present](#input\_ehns\_private\_endpoint\_is\_present) | (Required) create private endpoint to the event hubs | `bool` | n/a | yes |
| <a name="input_ehns_public_network_access"></a> [ehns\_public\_network\_access](#input\_ehns\_public\_network\_access) | (Required) enables public network access to the event hubs | `bool` | n/a | yes |
| <a name="input_ehns_sku_name"></a> [ehns\_sku\_name](#input\_ehns\_sku\_name) | Defines which tier to use. | `string` | n/a | yes |
| <a name="input_enable_sa_backup"></a> [enable\_sa\_backup](#input\_enable\_sa\_backup) | (Optional) enables storage account point in time recovery | `bool` | `false` | no |
| <a name="input_env"></a> [env](#input\_env) | n/a | `string` | n/a | yes |
| <a name="input_env_short"></a> [env\_short](#input\_env\_short) | n/a | `string` | n/a | yes |
| <a name="input_eventhubs"></a> [eventhubs](#input\_eventhubs) | A list of event hubs to add to namespace. | <pre>list(object({<br/>    name              = string<br/>    partitions        = number<br/>    message_retention = number<br/>    consumers         = list(string)<br/>    keys = list(object({<br/>      name   = string<br/>      listen = bool<br/>      send   = bool<br/>      manage = bool<br/>    }))<br/>  }))</pre> | `[]` | no |
| <a name="input_eventhubs_gpd"></a> [eventhubs\_gpd](#input\_eventhubs\_gpd) | A list of event hubs to add to namespace. | <pre>list(object({<br/>    name              = string<br/>    partitions        = number<br/>    message_retention = number<br/>    consumers         = list(string)<br/>    keys = list(object({<br/>      name   = string<br/>      listen = bool<br/>      send   = bool<br/>      manage = bool<br/>    }))<br/>  }))</pre> | `[]` | no |
| <a name="input_gpd_ingestion_storage_account"></a> [gpd\_ingestion\_storage\_account](#input\_gpd\_ingestion\_storage\_account) | n/a | <pre>object({<br/>    advanced_threat_protection    = bool<br/>    blob_delete_retention_days    = number<br/>    blob_versioning_enabled       = bool<br/>    backup_enabled                = bool<br/>    backup_retention              = optional(number, 0)<br/>    account_replication_type      = string<br/>    public_network_access_enabled = bool<br/><br/>  })</pre> | <pre>{<br/>  "account_replication_type": "LRS",<br/>  "advanced_threat_protection": false,<br/>  "backup_enabled": false,<br/>  "backup_retention": 0,<br/>  "blob_delete_retention_days": 30,<br/>  "blob_versioning_enabled": false,<br/>  "public_network_access_enabled": true<br/>}</pre> | no |
| <a name="input_location_itn"></a> [location\_itn](#input\_location\_itn) | italynorth | `string` | n/a | yes |
| <a name="input_location_short"></a> [location\_short](#input\_location\_short) | One of wue, neu | `string` | n/a | yes |
| <a name="input_location_short_itn"></a> [location\_short\_itn](#input\_location\_short\_itn) | itn | `string` | n/a | yes |
| <a name="input_monitor_resource_group_name"></a> [monitor\_resource\_group\_name](#input\_monitor\_resource\_group\_name) | Monitor resource group name | `string` | n/a | yes |
| <a name="input_observability_sa_advanced_threat_protection"></a> [observability\_sa\_advanced\_threat\_protection](#input\_observability\_sa\_advanced\_threat\_protection) | Enable contract threat advanced protection | `bool` | `false` | no |
| <a name="input_observability_sa_backup_retention_days"></a> [observability\_sa\_backup\_retention\_days](#input\_observability\_sa\_backup\_retention\_days) | Number of days to retain backups. | `number` | `0` | no |
| <a name="input_observability_sa_delete_retention_days"></a> [observability\_sa\_delete\_retention\_days](#input\_observability\_sa\_delete\_retention\_days) | Number of days to retain deleted. | `number` | `0` | no |
| <a name="input_observability_storage_account_replication_type"></a> [observability\_storage\_account\_replication\_type](#input\_observability\_storage\_account\_replication\_type) | (Optional) observability datastore storage account replication type | `string` | `"LRS"` | no |
| <a name="input_prefix"></a> [prefix](#input\_prefix) | n/a | `string` | n/a | yes |

## Outputs

No outputs.
<!-- END_TF_DOCS -->
