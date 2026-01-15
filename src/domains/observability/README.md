# observability

<!-- markdownlint-disable -->
<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_azapi"></a> [azapi](#requirement\_azapi) | <= 2.0.1 |
| <a name="requirement_azuread"></a> [azuread](#requirement\_azuread) | = 2.21.0 |
| <a name="requirement_azurerm"></a> [azurerm](#requirement\_azurerm) | = 3.117.0 |
| <a name="requirement_null"></a> [null](#requirement\_null) | <= 3.2.1 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module___v3__"></a> [\_\_v3\_\_](#module\_\_\_v3\_\_) | git::https://github.com/pagopa/terraform-azurerm-v3 | 087a57940a67444c3b883030c54ceb78562c64ef |
| <a name="module_apim_app_forwarder_api"></a> [apim\_app\_forwarder\_api](#module\_apim\_app\_forwarder\_api) | ./.terraform/modules/__v3__/api_management_api | n/a |
| <a name="module_apim_app_forwarder_product"></a> [apim\_app\_forwarder\_product](#module\_apim\_app\_forwarder\_product) | ./.terraform/modules/__v3__/api_management_product | n/a |
| <a name="module_app_forwarder_app_service"></a> [app\_forwarder\_app\_service](#module\_app\_forwarder\_app\_service) | ./.terraform/modules/__v3__/app_service | n/a |
| <a name="module_app_forwarder_slot_staging"></a> [app\_forwarder\_slot\_staging](#module\_app\_forwarder\_slot\_staging) | ./.terraform/modules/__v3__/app_service_slot | n/a |
| <a name="module_eventhub_namespace_observability"></a> [eventhub\_namespace\_observability](#module\_eventhub\_namespace\_observability) | ./.terraform/modules/__v3__/eventhub | n/a |
| <a name="module_eventhub_namespace_observability_gpd"></a> [eventhub\_namespace\_observability\_gpd](#module\_eventhub\_namespace\_observability\_gpd) | ./.terraform/modules/__v3__/eventhub | n/a |
| <a name="module_eventhub_observability_configuration"></a> [eventhub\_observability\_configuration](#module\_eventhub\_observability\_configuration) | ./.terraform/modules/__v3__/eventhub_configuration | n/a |
| <a name="module_eventhub_observability_gpd_configuration"></a> [eventhub\_observability\_gpd\_configuration](#module\_eventhub\_observability\_gpd\_configuration) | ./.terraform/modules/__v3__/eventhub_configuration | n/a |
| <a name="module_gpd_ingestion_sa"></a> [gpd\_ingestion\_sa](#module\_gpd\_ingestion\_sa) | ./.terraform/modules/__v3__/storage_account | n/a |
| <a name="module_observability_sa"></a> [observability\_sa](#module\_observability\_sa) | ./.terraform/modules/__v3__/storage_account | n/a |
| <a name="module_observability_st_snet"></a> [observability\_st\_snet](#module\_observability\_st\_snet) | ./.terraform/modules/__v3__/subnet | n/a |
| <a name="module_tag_config"></a> [tag\_config](#module\_tag\_config) | ../../tag_config | n/a |

## Resources

| Name | Type |
|------|------|
| [azapi_resource.ls_postgres_cruscotto](https://registry.terraform.io/providers/azure/azapi/latest/docs/resources/resource) | resource |
| [azapi_resource.ls_postgres_cruscotto_tf](https://registry.terraform.io/providers/azure/azapi/latest/docs/resources/resource) | resource |
| [azapi_resource.ls_postgres_nodo_tf](https://registry.terraform.io/providers/azure/azapi/latest/docs/resources/resource) | resource |
| [azapi_resource.pdnd_cdc_gec_bundles_dataflow](https://registry.terraform.io/providers/azure/azapi/latest/docs/resources/resource) | resource |
| [azapi_resource.pdnd_cdc_gec_cibundles_dataflow](https://registry.terraform.io/providers/azure/azapi/latest/docs/resources/resource) | resource |
| [azapi_resource.pdnd_cdc_gec_paymenttypes_dataflow](https://registry.terraform.io/providers/azure/azapi/latest/docs/resources/resource) | resource |
| [azapi_resource.pdnd_cdc_gec_touchpoints_dataflow](https://registry.terraform.io/providers/azure/azapi/latest/docs/resources/resource) | resource |
| [azapi_resource_action.approve_privatelink_private_endpoint_connection](https://registry.terraform.io/providers/azure/azapi/latest/docs/resources/resource_action) | resource |
| [azurerm_api_management_api_version_set.app_forwarder_api](https://registry.terraform.io/providers/hashicorp/azurerm/3.117.0/docs/resources/api_management_api_version_set) | resource |
| [azurerm_api_management_subscription.apim_app_forwarder_subkey](https://registry.terraform.io/providers/hashicorp/azurerm/3.117.0/docs/resources/api_management_subscription) | resource |
| [azurerm_data_factory_custom_dataset.crusc8_tables_datasets](https://registry.terraform.io/providers/hashicorp/azurerm/3.117.0/docs/resources/data_factory_custom_dataset) | resource |
| [azurerm_data_factory_custom_dataset.qi_datasets](https://registry.terraform.io/providers/hashicorp/azurerm/3.117.0/docs/resources/data_factory_custom_dataset) | resource |
| [azurerm_data_factory_custom_dataset.qi_datasets_cosmos](https://registry.terraform.io/providers/hashicorp/azurerm/3.117.0/docs/resources/data_factory_custom_dataset) | resource |
| [azurerm_data_factory_dataset_json.afm_gec_bundle_cdc_json](https://registry.terraform.io/providers/hashicorp/azurerm/3.117.0/docs/resources/data_factory_dataset_json) | resource |
| [azurerm_data_factory_dataset_json.afm_gec_cibundle_cdc_json](https://registry.terraform.io/providers/hashicorp/azurerm/3.117.0/docs/resources/data_factory_dataset_json) | resource |
| [azurerm_data_factory_dataset_json.afm_gec_paymenttypes_cdc_json](https://registry.terraform.io/providers/hashicorp/azurerm/3.117.0/docs/resources/data_factory_dataset_json) | resource |
| [azurerm_data_factory_dataset_json.afm_gec_touchpoints_cdc_json](https://registry.terraform.io/providers/hashicorp/azurerm/3.117.0/docs/resources/data_factory_dataset_json) | resource |
| [azurerm_data_factory_linked_service_azure_blob_storage.afm_gec_storage_linked_service](https://registry.terraform.io/providers/hashicorp/azurerm/3.117.0/docs/resources/data_factory_linked_service_azure_blob_storage) | resource |
| [azurerm_data_factory_linked_service_cosmosdb.afm_gec_cosmosdb_linked_service](https://registry.terraform.io/providers/hashicorp/azurerm/3.117.0/docs/resources/data_factory_linked_service_cosmosdb) | resource |
| [azurerm_data_factory_linked_service_cosmosdb.cosmos_biz](https://registry.terraform.io/providers/hashicorp/azurerm/3.117.0/docs/resources/data_factory_linked_service_cosmosdb) | resource |
| [azurerm_data_factory_linked_service_key_vault.ls_df_to_kv](https://registry.terraform.io/providers/hashicorp/azurerm/3.117.0/docs/resources/data_factory_linked_service_key_vault) | resource |
| [azurerm_data_factory_linked_service_key_vault.ls_df_to_kv_nodo](https://registry.terraform.io/providers/hashicorp/azurerm/3.117.0/docs/resources/data_factory_linked_service_key_vault) | resource |
| [azurerm_data_factory_linked_service_kusto.dataexp_ls](https://registry.terraform.io/providers/hashicorp/azurerm/3.117.0/docs/resources/data_factory_linked_service_kusto) | resource |
| [azurerm_data_factory_managed_private_endpoint.private_endpoint](https://registry.terraform.io/providers/hashicorp/azurerm/3.117.0/docs/resources/data_factory_managed_private_endpoint) | resource |
| [azurerm_data_factory_pipeline.pipeline_KPI_FDR_IMPORT_ESITI](https://registry.terraform.io/providers/hashicorp/azurerm/3.117.0/docs/resources/data_factory_pipeline) | resource |
| [azurerm_data_factory_pipeline.pipeline_KPI_FDR_IMPORT_ESITI_DAILY_Manuale](https://registry.terraform.io/providers/hashicorp/azurerm/3.117.0/docs/resources/data_factory_pipeline) | resource |
| [azurerm_data_factory_pipeline.pipeline_KPI_FDR_IMPORT_ESITI_Manuale](https://registry.terraform.io/providers/hashicorp/azurerm/3.117.0/docs/resources/data_factory_pipeline) | resource |
| [azurerm_data_factory_pipeline.pipeline_KPI_FDR_RENDICONTAZIONI](https://registry.terraform.io/providers/hashicorp/azurerm/3.117.0/docs/resources/data_factory_pipeline) | resource |
| [azurerm_data_factory_pipeline.pipeline_KPI_TNSPO](https://registry.terraform.io/providers/hashicorp/azurerm/3.117.0/docs/resources/data_factory_pipeline) | resource |
| [azurerm_data_factory_pipeline.pipeline_KPI_TPNP](https://registry.terraform.io/providers/hashicorp/azurerm/3.117.0/docs/resources/data_factory_pipeline) | resource |
| [azurerm_data_factory_pipeline.pipeline_KPI_TPNP_Recupero](https://registry.terraform.io/providers/hashicorp/azurerm/3.117.0/docs/resources/data_factory_pipeline) | resource |
| [azurerm_data_factory_pipeline.pipeline_KPI_TPSPO_DASPO](https://registry.terraform.io/providers/hashicorp/azurerm/3.117.0/docs/resources/data_factory_pipeline) | resource |
| [azurerm_data_factory_pipeline.pipeline_PDND_CDC_GEC_BUNDLES](https://registry.terraform.io/providers/hashicorp/azurerm/3.117.0/docs/resources/data_factory_pipeline) | resource |
| [azurerm_data_factory_pipeline.pipeline_PDND_CDC_GEC_CIBUNDLES](https://registry.terraform.io/providers/hashicorp/azurerm/3.117.0/docs/resources/data_factory_pipeline) | resource |
| [azurerm_data_factory_pipeline.pipeline_PDND_CDC_GEC_PAYMENTTYPES](https://registry.terraform.io/providers/hashicorp/azurerm/3.117.0/docs/resources/data_factory_pipeline) | resource |
| [azurerm_data_factory_pipeline.pipeline_PDND_CDC_GEC_TOUCHPOINTS](https://registry.terraform.io/providers/hashicorp/azurerm/3.117.0/docs/resources/data_factory_pipeline) | resource |
| [azurerm_data_factory_pipeline.pipeline_PDND_KPI_DASPO](https://registry.terraform.io/providers/hashicorp/azurerm/3.117.0/docs/resources/data_factory_pipeline) | resource |
| [azurerm_data_factory_pipeline.pipeline_PDND_KPI_LFDR](https://registry.terraform.io/providers/hashicorp/azurerm/3.117.0/docs/resources/data_factory_pipeline) | resource |
| [azurerm_data_factory_pipeline.pipeline_PDND_KPI_LSPO](https://registry.terraform.io/providers/hashicorp/azurerm/3.117.0/docs/resources/data_factory_pipeline) | resource |
| [azurerm_data_factory_pipeline.pipeline_PDND_KPI_NRFDR](https://registry.terraform.io/providers/hashicorp/azurerm/3.117.0/docs/resources/data_factory_pipeline) | resource |
| [azurerm_data_factory_pipeline.pipeline_PDND_KPI_TNSPO](https://registry.terraform.io/providers/hashicorp/azurerm/3.117.0/docs/resources/data_factory_pipeline) | resource |
| [azurerm_data_factory_pipeline.pipeline_PDND_KPI_TPNP](https://registry.terraform.io/providers/hashicorp/azurerm/3.117.0/docs/resources/data_factory_pipeline) | resource |
| [azurerm_data_factory_pipeline.pipeline_PDND_KPI_WAFDR](https://registry.terraform.io/providers/hashicorp/azurerm/3.117.0/docs/resources/data_factory_pipeline) | resource |
| [azurerm_data_factory_pipeline.pipeline_PDND_KPI_WPNFDR](https://registry.terraform.io/providers/hashicorp/azurerm/3.117.0/docs/resources/data_factory_pipeline) | resource |
| [azurerm_data_factory_pipeline.pipeline_SMO_QPT_RECEIPT](https://registry.terraform.io/providers/hashicorp/azurerm/3.117.0/docs/resources/data_factory_pipeline) | resource |
| [azurerm_data_factory_pipeline.pipeline_SMO_QPT_TAXONOMY_AGGREGATE](https://registry.terraform.io/providers/hashicorp/azurerm/3.117.0/docs/resources/data_factory_pipeline) | resource |
| [azurerm_data_factory_pipeline.pipeline_SMO_QPT_TIMEOUT](https://registry.terraform.io/providers/hashicorp/azurerm/3.117.0/docs/resources/data_factory_pipeline) | resource |
| [azurerm_data_factory_trigger_schedule.Trigger_KPI_FDR_IMPORT_ESITI](https://registry.terraform.io/providers/hashicorp/azurerm/3.117.0/docs/resources/data_factory_trigger_schedule) | resource |
| [azurerm_data_factory_trigger_schedule.Trigger_KPI_FDR_RENDICONTAZIONI](https://registry.terraform.io/providers/hashicorp/azurerm/3.117.0/docs/resources/data_factory_trigger_schedule) | resource |
| [azurerm_data_factory_trigger_schedule.Trigger_KPI_TNSPO](https://registry.terraform.io/providers/hashicorp/azurerm/3.117.0/docs/resources/data_factory_trigger_schedule) | resource |
| [azurerm_data_factory_trigger_schedule.Trigger_KPI_TPNP](https://registry.terraform.io/providers/hashicorp/azurerm/3.117.0/docs/resources/data_factory_trigger_schedule) | resource |
| [azurerm_data_factory_trigger_schedule.Trigger_KPI_TPSPO_DASPO](https://registry.terraform.io/providers/hashicorp/azurerm/3.117.0/docs/resources/data_factory_trigger_schedule) | resource |
| [azurerm_data_factory_trigger_schedule.Trigger_PDND_CDC_GEC_BUNDLES](https://registry.terraform.io/providers/hashicorp/azurerm/3.117.0/docs/resources/data_factory_trigger_schedule) | resource |
| [azurerm_data_factory_trigger_schedule.Trigger_PDND_CDC_GEC_CIBUNDLES](https://registry.terraform.io/providers/hashicorp/azurerm/3.117.0/docs/resources/data_factory_trigger_schedule) | resource |
| [azurerm_data_factory_trigger_schedule.Trigger_PDND_CDC_GEC_PAYMENTTYPES](https://registry.terraform.io/providers/hashicorp/azurerm/3.117.0/docs/resources/data_factory_trigger_schedule) | resource |
| [azurerm_data_factory_trigger_schedule.Trigger_PDND_CDC_GEC_TOUCHPOINTS](https://registry.terraform.io/providers/hashicorp/azurerm/3.117.0/docs/resources/data_factory_trigger_schedule) | resource |
| [azurerm_data_factory_trigger_schedule.Trigger_PDND_KPI_DASPO](https://registry.terraform.io/providers/hashicorp/azurerm/3.117.0/docs/resources/data_factory_trigger_schedule) | resource |
| [azurerm_data_factory_trigger_schedule.Trigger_PDND_KPI_LFDR](https://registry.terraform.io/providers/hashicorp/azurerm/3.117.0/docs/resources/data_factory_trigger_schedule) | resource |
| [azurerm_data_factory_trigger_schedule.Trigger_PDND_KPI_LSPO](https://registry.terraform.io/providers/hashicorp/azurerm/3.117.0/docs/resources/data_factory_trigger_schedule) | resource |
| [azurerm_data_factory_trigger_schedule.Trigger_PDND_KPI_NRFDR](https://registry.terraform.io/providers/hashicorp/azurerm/3.117.0/docs/resources/data_factory_trigger_schedule) | resource |
| [azurerm_data_factory_trigger_schedule.Trigger_PDND_KPI_TNSPO](https://registry.terraform.io/providers/hashicorp/azurerm/3.117.0/docs/resources/data_factory_trigger_schedule) | resource |
| [azurerm_data_factory_trigger_schedule.Trigger_PDND_KPI_TPNP](https://registry.terraform.io/providers/hashicorp/azurerm/3.117.0/docs/resources/data_factory_trigger_schedule) | resource |
| [azurerm_data_factory_trigger_schedule.Trigger_PDND_KPI_WAFDR](https://registry.terraform.io/providers/hashicorp/azurerm/3.117.0/docs/resources/data_factory_trigger_schedule) | resource |
| [azurerm_data_factory_trigger_schedule.Trigger_PDND_KPI_WPNFDR](https://registry.terraform.io/providers/hashicorp/azurerm/3.117.0/docs/resources/data_factory_trigger_schedule) | resource |
| [azurerm_data_factory_trigger_schedule.Trigger_SMO_QPT_RECEIPT](https://registry.terraform.io/providers/hashicorp/azurerm/3.117.0/docs/resources/data_factory_trigger_schedule) | resource |
| [azurerm_data_factory_trigger_schedule.Trigger_SMO_QPT_TAXONOMY_AGGREGATE](https://registry.terraform.io/providers/hashicorp/azurerm/3.117.0/docs/resources/data_factory_trigger_schedule) | resource |
| [azurerm_data_factory_trigger_schedule.Trigger_SMO_QPT_TIMEOUT](https://registry.terraform.io/providers/hashicorp/azurerm/3.117.0/docs/resources/data_factory_trigger_schedule) | resource |
| [azurerm_eventhub_consumer_group.rtp_consumer_gpd](https://registry.terraform.io/providers/hashicorp/azurerm/3.117.0/docs/resources/eventhub_consumer_group) | resource |
| [azurerm_eventhub_namespace_authorization_rule.cdc_connection_string](https://registry.terraform.io/providers/hashicorp/azurerm/3.117.0/docs/resources/eventhub_namespace_authorization_rule) | resource |
| [azurerm_eventhub_namespace_authorization_rule.cdc_test_connection_string](https://registry.terraform.io/providers/hashicorp/azurerm/3.117.0/docs/resources/eventhub_namespace_authorization_rule) | resource |
| [azurerm_key_vault_access_policy.df_see_kv_cruscotto](https://registry.terraform.io/providers/hashicorp/azurerm/3.117.0/docs/resources/key_vault_access_policy) | resource |
| [azurerm_key_vault_access_policy.df_see_kv_nodo](https://registry.terraform.io/providers/hashicorp/azurerm/3.117.0/docs/resources/key_vault_access_policy) | resource |
| [azurerm_key_vault_secret.apim_app_forwarder_subscription_key](https://registry.terraform.io/providers/hashicorp/azurerm/3.117.0/docs/resources/key_vault_secret) | resource |
| [azurerm_key_vault_secret.azure_web_jobs_storage_kv](https://registry.terraform.io/providers/hashicorp/azurerm/3.117.0/docs/resources/key_vault_secret) | resource |
| [azurerm_key_vault_secret.certificate_crt_app_forwarder_s](https://registry.terraform.io/providers/hashicorp/azurerm/3.117.0/docs/resources/key_vault_secret) | resource |
| [azurerm_key_vault_secret.certificate_key_app_forwarder_s](https://registry.terraform.io/providers/hashicorp/azurerm/3.117.0/docs/resources/key_vault_secret) | resource |
| [azurerm_kusto_cluster.data_explorer_cluster](https://registry.terraform.io/providers/hashicorp/azurerm/3.117.0/docs/resources/kusto_cluster) | resource |
| [azurerm_kusto_database.pm_db](https://registry.terraform.io/providers/hashicorp/azurerm/3.117.0/docs/resources/kusto_database) | resource |
| [azurerm_kusto_database.re_db](https://registry.terraform.io/providers/hashicorp/azurerm/3.117.0/docs/resources/kusto_database) | resource |
| [azurerm_kusto_database_principal_assignment.qi_principal_assignment](https://registry.terraform.io/providers/hashicorp/azurerm/3.117.0/docs/resources/kusto_database_principal_assignment) | resource |
| [azurerm_kusto_eventhub_data_connection.eventhub_connection_for_ingestion_qi_fdr](https://registry.terraform.io/providers/hashicorp/azurerm/3.117.0/docs/resources/kusto_eventhub_data_connection) | resource |
| [azurerm_kusto_eventhub_data_connection.eventhub_connection_for_ingestion_qi_iuvs](https://registry.terraform.io/providers/hashicorp/azurerm/3.117.0/docs/resources/kusto_eventhub_data_connection) | resource |
| [azurerm_kusto_eventhub_data_connection.eventhub_connection_for_re_event](https://registry.terraform.io/providers/hashicorp/azurerm/3.117.0/docs/resources/kusto_eventhub_data_connection) | resource |
| [azurerm_kusto_script.create_merge_table](https://registry.terraform.io/providers/hashicorp/azurerm/3.117.0/docs/resources/kusto_script) | resource |
| [azurerm_private_endpoint.observability_storage_private_endpoint](https://registry.terraform.io/providers/hashicorp/azurerm/3.117.0/docs/resources/private_endpoint) | resource |
| [azurerm_resource_group.eventhub_observability_rg](https://registry.terraform.io/providers/hashicorp/azurerm/3.117.0/docs/resources/resource_group) | resource |
| [azurerm_resource_group.gpd_ingestion_rg](https://registry.terraform.io/providers/hashicorp/azurerm/3.117.0/docs/resources/resource_group) | resource |
| [azurerm_resource_group.st_observability_rg](https://registry.terraform.io/providers/hashicorp/azurerm/3.117.0/docs/resources/resource_group) | resource |
| [azurerm_role_assignment.adgroup_dataexp_reader](https://registry.terraform.io/providers/hashicorp/azurerm/3.117.0/docs/resources/role_assignment) | resource |
| [azurerm_role_assignment.fdr_qi_fdr_iuvs_data_evh_data_receiver_role](https://registry.terraform.io/providers/hashicorp/azurerm/3.117.0/docs/resources/role_assignment) | resource |
| [azurerm_role_assignment.fdr_qi_flow_data_evh_data_receiver_role](https://registry.terraform.io/providers/hashicorp/azurerm/3.117.0/docs/resources/role_assignment) | resource |
| [azurerm_storage_container.blob-observability-st](https://registry.terraform.io/providers/hashicorp/azurerm/3.117.0/docs/resources/storage_container) | resource |
| [azurerm_subnet.eventhub_observability_gpd_snet](https://registry.terraform.io/providers/hashicorp/azurerm/3.117.0/docs/resources/subnet) | resource |
| [azurerm_subnet.eventhub_observability_snet](https://registry.terraform.io/providers/hashicorp/azurerm/3.117.0/docs/resources/subnet) | resource |
| [azapi_resource.privatelink_private_endpoint_connection](https://registry.terraform.io/providers/azure/azapi/latest/docs/data-sources/resource) | data source |
| [azuread_group.adgroup_developers](https://registry.terraform.io/providers/hashicorp/azuread/2.21.0/docs/data-sources/group) | data source |
| [azuread_group.adgroup_externals](https://registry.terraform.io/providers/hashicorp/azuread/2.21.0/docs/data-sources/group) | data source |
| [azuread_group.adgroup_operations](https://registry.terraform.io/providers/hashicorp/azuread/2.21.0/docs/data-sources/group) | data source |
| [azuread_group.adgroup_technical_project_managers](https://registry.terraform.io/providers/hashicorp/azuread/2.21.0/docs/data-sources/group) | data source |
| [azurerm_client_config.current](https://registry.terraform.io/providers/hashicorp/azurerm/3.117.0/docs/data-sources/client_config) | data source |
| [azurerm_container_registry.acr](https://registry.terraform.io/providers/hashicorp/azurerm/3.117.0/docs/data-sources/container_registry) | data source |
| [azurerm_cosmosdb_account.afm_cosmos_account](https://registry.terraform.io/providers/hashicorp/azurerm/3.117.0/docs/data-sources/cosmosdb_account) | data source |
| [azurerm_cosmosdb_account.bizevent_cosmos_account](https://registry.terraform.io/providers/hashicorp/azurerm/3.117.0/docs/data-sources/cosmosdb_account) | data source |
| [azurerm_data_factory.obeserv_data_factory](https://registry.terraform.io/providers/hashicorp/azurerm/3.117.0/docs/data-sources/data_factory) | data source |
| [azurerm_data_factory.qi_data_factory](https://registry.terraform.io/providers/hashicorp/azurerm/3.117.0/docs/data-sources/data_factory) | data source |
| [azurerm_data_factory.qi_data_factory_cosmos](https://registry.terraform.io/providers/hashicorp/azurerm/3.117.0/docs/data-sources/data_factory) | data source |
| [azurerm_eventhub.pagopa-evh-ns03_nodo-dei-pagamenti-re_nodo-dei-pagamenti-re](https://registry.terraform.io/providers/hashicorp/azurerm/3.117.0/docs/data-sources/eventhub) | data source |
| [azurerm_eventhub.pagopa-evh-ns04_nodo-dei-pagamenti-fdr-qi-fdr-iuvs](https://registry.terraform.io/providers/hashicorp/azurerm/3.117.0/docs/data-sources/eventhub) | data source |
| [azurerm_eventhub.pagopa-evh-ns04_nodo-dei-pagamenti-fdr-qi-flows](https://registry.terraform.io/providers/hashicorp/azurerm/3.117.0/docs/data-sources/eventhub) | data source |
| [azurerm_key_vault.cruscotto_kv](https://registry.terraform.io/providers/hashicorp/azurerm/3.117.0/docs/data-sources/key_vault) | data source |
| [azurerm_key_vault.gps_kv](https://registry.terraform.io/providers/hashicorp/azurerm/3.117.0/docs/data-sources/key_vault) | data source |
| [azurerm_key_vault.kv](https://registry.terraform.io/providers/hashicorp/azurerm/3.117.0/docs/data-sources/key_vault) | data source |
| [azurerm_key_vault.kv_shared](https://registry.terraform.io/providers/hashicorp/azurerm/3.117.0/docs/data-sources/key_vault) | data source |
| [azurerm_key_vault.network_kv](https://registry.terraform.io/providers/hashicorp/azurerm/3.117.0/docs/data-sources/key_vault) | data source |
| [azurerm_key_vault.nodo_kv](https://registry.terraform.io/providers/hashicorp/azurerm/3.117.0/docs/data-sources/key_vault) | data source |
| [azurerm_key_vault.qi-kv](https://registry.terraform.io/providers/hashicorp/azurerm/3.117.0/docs/data-sources/key_vault) | data source |
| [azurerm_key_vault_secret.certificate_crt_app_forwarder](https://registry.terraform.io/providers/hashicorp/azurerm/3.117.0/docs/data-sources/key_vault_secret) | data source |
| [azurerm_key_vault_secret.certificate_key_app_forwarder](https://registry.terraform.io/providers/hashicorp/azurerm/3.117.0/docs/data-sources/key_vault_secret) | data source |
| [azurerm_key_vault_secret.cruscotto_db_database](https://registry.terraform.io/providers/hashicorp/azurerm/3.117.0/docs/data-sources/key_vault_secret) | data source |
| [azurerm_key_vault_secret.cruscotto_db_host](https://registry.terraform.io/providers/hashicorp/azurerm/3.117.0/docs/data-sources/key_vault_secret) | data source |
| [azurerm_key_vault_secret.cruscotto_db_password](https://registry.terraform.io/providers/hashicorp/azurerm/3.117.0/docs/data-sources/key_vault_secret) | data source |
| [azurerm_key_vault_secret.cruscotto_db_port](https://registry.terraform.io/providers/hashicorp/azurerm/3.117.0/docs/data-sources/key_vault_secret) | data source |
| [azurerm_key_vault_secret.cruscotto_db_username](https://registry.terraform.io/providers/hashicorp/azurerm/3.117.0/docs/data-sources/key_vault_secret) | data source |
| [azurerm_key_vault_secret.database_proxy_fqdn](https://registry.terraform.io/providers/hashicorp/azurerm/3.117.0/docs/data-sources/key_vault_secret) | data source |
| [azurerm_key_vault_secret.nodo_db_database](https://registry.terraform.io/providers/hashicorp/azurerm/3.117.0/docs/data-sources/key_vault_secret) | data source |
| [azurerm_key_vault_secret.nodo_db_host](https://registry.terraform.io/providers/hashicorp/azurerm/3.117.0/docs/data-sources/key_vault_secret) | data source |
| [azurerm_key_vault_secret.nodo_db_port](https://registry.terraform.io/providers/hashicorp/azurerm/3.117.0/docs/data-sources/key_vault_secret) | data source |
| [azurerm_key_vault_secret.nodo_db_username](https://registry.terraform.io/providers/hashicorp/azurerm/3.117.0/docs/data-sources/key_vault_secret) | data source |
| [azurerm_monitor_action_group.email](https://registry.terraform.io/providers/hashicorp/azurerm/3.117.0/docs/data-sources/monitor_action_group) | data source |
| [azurerm_monitor_action_group.slack](https://registry.terraform.io/providers/hashicorp/azurerm/3.117.0/docs/data-sources/monitor_action_group) | data source |
| [azurerm_private_dns_zone.eventhub](https://registry.terraform.io/providers/hashicorp/azurerm/3.117.0/docs/data-sources/private_dns_zone) | data source |
| [azurerm_private_dns_zone.storage](https://registry.terraform.io/providers/hashicorp/azurerm/3.117.0/docs/data-sources/private_dns_zone) | data source |
| [azurerm_private_link_service.vmss_pls](https://registry.terraform.io/providers/hashicorp/azurerm/3.117.0/docs/data-sources/private_link_service) | data source |
| [azurerm_resource_group.monitor_rg](https://registry.terraform.io/providers/hashicorp/azurerm/3.117.0/docs/data-sources/resource_group) | data source |
| [azurerm_resource_group.rg_event_private_dns_zone](https://registry.terraform.io/providers/hashicorp/azurerm/3.117.0/docs/data-sources/resource_group) | data source |
| [azurerm_resource_group.rg_node_forwarder](https://registry.terraform.io/providers/hashicorp/azurerm/3.117.0/docs/data-sources/resource_group) | data source |
| [azurerm_resource_group.rg_vnet_italy](https://registry.terraform.io/providers/hashicorp/azurerm/3.117.0/docs/data-sources/resource_group) | data source |
| [azurerm_storage_account.observ_storage_account](https://registry.terraform.io/providers/hashicorp/azurerm/3.117.0/docs/data-sources/storage_account) | data source |
| [azurerm_subnet.subnet_apim](https://registry.terraform.io/providers/hashicorp/azurerm/3.117.0/docs/data-sources/subnet) | data source |
| [azurerm_subnet.subnet_node_forwarder](https://registry.terraform.io/providers/hashicorp/azurerm/3.117.0/docs/data-sources/subnet) | data source |
| [azurerm_subscription.current](https://registry.terraform.io/providers/hashicorp/azurerm/3.117.0/docs/data-sources/subscription) | data source |
| [azurerm_virtual_network.vnet](https://registry.terraform.io/providers/hashicorp/azurerm/3.117.0/docs/data-sources/virtual_network) | data source |
| [azurerm_virtual_network.vnet_italy](https://registry.terraform.io/providers/hashicorp/azurerm/3.117.0/docs/data-sources/virtual_network) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_apim_dns_zone_prefix"></a> [apim\_dns\_zone\_prefix](#input\_apim\_dns\_zone\_prefix) | The dns subdomain for apim. | `string` | `null` | no |
| <a name="input_app_forwarder_enabled"></a> [app\_forwarder\_enabled](#input\_app\_forwarder\_enabled) | Enable app\_forwarder | `bool` | `false` | no |
| <a name="input_app_forwarder_ip_restriction_default_action"></a> [app\_forwarder\_ip\_restriction\_default\_action](#input\_app\_forwarder\_ip\_restriction\_default\_action) | (Required) The Default action for traffic that does not match any ip\_restriction rule. possible values include Allow and Deny. | `string` | n/a | yes |
| <a name="input_cidr_subnet_observability_evh"></a> [cidr\_subnet\_observability\_evh](#input\_cidr\_subnet\_observability\_evh) | Address prefixes evh | `list(string)` | n/a | yes |
| <a name="input_cidr_subnet_observability_gpd_evh"></a> [cidr\_subnet\_observability\_gpd\_evh](#input\_cidr\_subnet\_observability\_gpd\_evh) | Address prefixes evh | `list(string)` | n/a | yes |
| <a name="input_cidr_subnet_observability_storage"></a> [cidr\_subnet\_observability\_storage](#input\_cidr\_subnet\_observability\_storage) | Storage address space | `list(string)` | `null` | no |
| <a name="input_dexp_db"></a> [dexp\_db](#input\_dexp\_db) | n/a | <pre>object({<br/>    enable             = bool<br/>    hot_cache_period   = string<br/>    soft_delete_period = string<br/>  })</pre> | n/a | yes |
| <a name="input_dexp_params"></a> [dexp\_params](#input\_dexp\_params) | n/a | <pre>object({<br/>    enabled = bool<br/>    sku = object({<br/>      name     = string<br/>      capacity = number<br/>    })<br/>    autoscale = object({<br/>      enabled       = bool<br/>      min_instances = number<br/>      max_instances = number<br/>    })<br/>    public_network_access_enabled = bool<br/>    double_encryption_enabled     = bool<br/>    disk_encryption_enabled       = bool<br/>    purge_enabled                 = bool<br/>  })</pre> | n/a | yes |
| <a name="input_dexp_pm_db"></a> [dexp\_pm\_db](#input\_dexp\_pm\_db) | n/a | <pre>object({<br/>    enable             = bool<br/>    hot_cache_period   = string<br/>    soft_delete_period = string<br/>  })</pre> | <pre>{<br/>  "enable": false,<br/>  "hot_cache_period": "P5D",<br/>  "soft_delete_period": "P365D"<br/>}</pre> | no |
| <a name="input_dexp_re_db_linkes_service"></a> [dexp\_re\_db\_linkes\_service](#input\_dexp\_re\_db\_linkes\_service) | n/a | <pre>object({<br/>    enable = bool<br/>  })</pre> | n/a | yes |
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
| <a name="input_ehns_zone_redundant"></a> [ehns\_zone\_redundant](#input\_ehns\_zone\_redundant) | Specifies if the EventHub Namespace should be Zone Redundant (created across Availability Zones). | `bool` | n/a | yes |
| <a name="input_enable_sa_backup"></a> [enable\_sa\_backup](#input\_enable\_sa\_backup) | (Optional) enables storage account point in time recovery | `bool` | `false` | no |
| <a name="input_env"></a> [env](#input\_env) | n/a | `string` | n/a | yes |
| <a name="input_env_short"></a> [env\_short](#input\_env\_short) | n/a | `string` | n/a | yes |
| <a name="input_eventhubs"></a> [eventhubs](#input\_eventhubs) | A list of event hubs to add to namespace. | <pre>list(object({<br/>    name              = string<br/>    partitions        = number<br/>    message_retention = number<br/>    consumers         = list(string)<br/>    keys = list(object({<br/>      name   = string<br/>      listen = bool<br/>      send   = bool<br/>      manage = bool<br/>    }))<br/>  }))</pre> | `[]` | no |
| <a name="input_eventhubs_gpd"></a> [eventhubs\_gpd](#input\_eventhubs\_gpd) | A list of event hubs to add to namespace. | <pre>list(object({<br/>    name              = string<br/>    partitions        = number<br/>    message_retention = number<br/>    consumers         = list(string)<br/>    keys = list(object({<br/>      name   = string<br/>      listen = bool<br/>      send   = bool<br/>      manage = bool<br/>    }))<br/>  }))</pre> | `[]` | no |
| <a name="input_external_domain"></a> [external\_domain](#input\_external\_domain) | Domain for delegation | `string` | `null` | no |
| <a name="input_gpd_ingestion_storage_account"></a> [gpd\_ingestion\_storage\_account](#input\_gpd\_ingestion\_storage\_account) | n/a | <pre>object({<br/>    advanced_threat_protection    = bool<br/>    blob_delete_retention_days    = number<br/>    blob_versioning_enabled       = bool<br/>    backup_enabled                = bool<br/>    backup_retention              = optional(number, 0)<br/>    account_replication_type      = string<br/>    public_network_access_enabled = bool<br/><br/>  })</pre> | <pre>{<br/>  "account_replication_type": "LRS",<br/>  "advanced_threat_protection": false,<br/>  "backup_enabled": false,<br/>  "backup_retention": 0,<br/>  "blob_delete_retention_days": 30,<br/>  "blob_versioning_enabled": false,<br/>  "public_network_access_enabled": true<br/>}</pre> | no |
| <a name="input_instance"></a> [instance](#input\_instance) | One of beta, prod01, prod02 | `string` | n/a | yes |
| <a name="input_location"></a> [location](#input\_location) | One of westeurope, northeurope | `string` | n/a | yes |
| <a name="input_location_itn"></a> [location\_itn](#input\_location\_itn) | italynorth | `string` | n/a | yes |
| <a name="input_location_short"></a> [location\_short](#input\_location\_short) | One of wue, neu | `string` | n/a | yes |
| <a name="input_location_short_itn"></a> [location\_short\_itn](#input\_location\_short\_itn) | itn | `string` | n/a | yes |
| <a name="input_monitor_resource_group_name"></a> [monitor\_resource\_group\_name](#input\_monitor\_resource\_group\_name) | Monitor resource group name | `string` | n/a | yes |
| <a name="input_observability_sa_advanced_threat_protection"></a> [observability\_sa\_advanced\_threat\_protection](#input\_observability\_sa\_advanced\_threat\_protection) | Enable contract threat advanced protection | `bool` | `false` | no |
| <a name="input_observability_sa_backup_retention_days"></a> [observability\_sa\_backup\_retention\_days](#input\_observability\_sa\_backup\_retention\_days) | Number of days to retain backups. | `number` | `0` | no |
| <a name="input_observability_sa_delete_after_last_access"></a> [observability\_sa\_delete\_after\_last\_access](#input\_observability\_sa\_delete\_after\_last\_access) | Number of days since modification to blob before deleting | `number` | `3650` | no |
| <a name="input_observability_sa_delete_retention_days"></a> [observability\_sa\_delete\_retention\_days](#input\_observability\_sa\_delete\_retention\_days) | Number of days to retain deleted. | `number` | `0` | no |
| <a name="input_observability_sa_tier_to_cool_after_last_access"></a> [observability\_sa\_tier\_to\_cool\_after\_last\_access](#input\_observability\_sa\_tier\_to\_cool\_after\_last\_access) | Number of days since last access to blob before moving to cool tier | `number` | `183` | no |
| <a name="input_observability_storage_account_replication_type"></a> [observability\_storage\_account\_replication\_type](#input\_observability\_storage\_account\_replication\_type) | (Optional) observability datastore storage account replication type | `string` | `"LRS"` | no |
| <a name="input_observability_tier_to_archive_after_days_since_last_access_time_greater_than"></a> [observability\_tier\_to\_archive\_after\_days\_since\_last\_access\_time\_greater\_than](#input\_observability\_tier\_to\_archive\_after\_days\_since\_last\_access\_time\_greater\_than) | Number of days since last access to blob before moving to archive tier | `number` | `730` | no |
| <a name="input_prefix"></a> [prefix](#input\_prefix) | n/a | `string` | n/a | yes |

## Outputs

No outputs.
<!-- END_TF_DOCS -->
