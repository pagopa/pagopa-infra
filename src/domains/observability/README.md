# observability

<!-- markdownlint-disable -->
<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_azuread"></a> [azuread](#requirement\_azuread) | = 2.21.0 |
| <a name="requirement_azurerm"></a> [azurerm](#requirement\_azurerm) | = 3.53.0 |
| <a name="requirement_null"></a> [null](#requirement\_null) | = 3.1.1 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_apim_app_forwarder_api"></a> [apim\_app\_forwarder\_api](#module\_apim\_app\_forwarder\_api) | git::https://github.com/pagopa/terraform-azurerm-v3.git//api_management_api | v6.4.1 |
| <a name="module_apim_app_forwarder_product"></a> [apim\_app\_forwarder\_product](#module\_apim\_app\_forwarder\_product) | git::https://github.com/pagopa/terraform-azurerm-v3.git//api_management_product | v6.4.1 |
| <a name="module_app_forwarder_app_service"></a> [app\_forwarder\_app\_service](#module\_app\_forwarder\_app\_service) | git::https://github.com/pagopa/terraform-azurerm-v3.git//app_service | v8.12.2 |
| <a name="module_app_forwarder_slot_staging"></a> [app\_forwarder\_slot\_staging](#module\_app\_forwarder\_slot\_staging) | git::https://github.com/pagopa/terraform-azurerm-v3.git//app_service_slot | v8.12.2 |

## Resources

| Name | Type |
|------|------|
| [azurerm_api_management_api_version_set.app_forwarder_api](https://registry.terraform.io/providers/hashicorp/azurerm/3.53.0/docs/resources/api_management_api_version_set) | resource |
| [azurerm_api_management_subscription.apim_app_forwarder_subkey](https://registry.terraform.io/providers/hashicorp/azurerm/3.53.0/docs/resources/api_management_subscription) | resource |
| [azurerm_data_factory_custom_dataset.qi_datasets](https://registry.terraform.io/providers/hashicorp/azurerm/3.53.0/docs/resources/data_factory_custom_dataset) | resource |
| [azurerm_data_factory_custom_dataset.qi_datasets_cosmos](https://registry.terraform.io/providers/hashicorp/azurerm/3.53.0/docs/resources/data_factory_custom_dataset) | resource |
| [azurerm_data_factory_linked_service_cosmosdb.cosmos_biz](https://registry.terraform.io/providers/hashicorp/azurerm/3.53.0/docs/resources/data_factory_linked_service_cosmosdb) | resource |
| [azurerm_data_factory_linked_service_kusto.dataexp_ls](https://registry.terraform.io/providers/hashicorp/azurerm/3.53.0/docs/resources/data_factory_linked_service_kusto) | resource |
| [azurerm_data_factory_pipeline.pipeline_KPI_FDR_IMPORT_ESITI](https://registry.terraform.io/providers/hashicorp/azurerm/3.53.0/docs/resources/data_factory_pipeline) | resource |
| [azurerm_data_factory_pipeline.pipeline_KPI_FDR_IMPORT_ESITI_DAILY_Manuale](https://registry.terraform.io/providers/hashicorp/azurerm/3.53.0/docs/resources/data_factory_pipeline) | resource |
| [azurerm_data_factory_pipeline.pipeline_KPI_FDR_IMPORT_ESITI_Manuale](https://registry.terraform.io/providers/hashicorp/azurerm/3.53.0/docs/resources/data_factory_pipeline) | resource |
| [azurerm_data_factory_pipeline.pipeline_KPI_FDR_RENDICONTAZIONI](https://registry.terraform.io/providers/hashicorp/azurerm/3.53.0/docs/resources/data_factory_pipeline) | resource |
| [azurerm_data_factory_pipeline.pipeline_KPI_TNSPO](https://registry.terraform.io/providers/hashicorp/azurerm/3.53.0/docs/resources/data_factory_pipeline) | resource |
| [azurerm_data_factory_pipeline.pipeline_KPI_TPNP](https://registry.terraform.io/providers/hashicorp/azurerm/3.53.0/docs/resources/data_factory_pipeline) | resource |
| [azurerm_data_factory_pipeline.pipeline_KPI_TPNP_Recupero](https://registry.terraform.io/providers/hashicorp/azurerm/3.53.0/docs/resources/data_factory_pipeline) | resource |
| [azurerm_data_factory_pipeline.pipeline_KPI_TPSPO_DASPO](https://registry.terraform.io/providers/hashicorp/azurerm/3.53.0/docs/resources/data_factory_pipeline) | resource |
| [azurerm_data_factory_pipeline.pipeline_PDND_KPI_DASPO](https://registry.terraform.io/providers/hashicorp/azurerm/3.53.0/docs/resources/data_factory_pipeline) | resource |
| [azurerm_data_factory_pipeline.pipeline_PDND_KPI_LFDR](https://registry.terraform.io/providers/hashicorp/azurerm/3.53.0/docs/resources/data_factory_pipeline) | resource |
| [azurerm_data_factory_pipeline.pipeline_PDND_KPI_LSPO](https://registry.terraform.io/providers/hashicorp/azurerm/3.53.0/docs/resources/data_factory_pipeline) | resource |
| [azurerm_data_factory_pipeline.pipeline_PDND_KPI_NRFDR](https://registry.terraform.io/providers/hashicorp/azurerm/3.53.0/docs/resources/data_factory_pipeline) | resource |
| [azurerm_data_factory_pipeline.pipeline_PDND_KPI_TNSPO](https://registry.terraform.io/providers/hashicorp/azurerm/3.53.0/docs/resources/data_factory_pipeline) | resource |
| [azurerm_data_factory_pipeline.pipeline_PDND_KPI_TPNP](https://registry.terraform.io/providers/hashicorp/azurerm/3.53.0/docs/resources/data_factory_pipeline) | resource |
| [azurerm_data_factory_pipeline.pipeline_PDND_KPI_WAFDR](https://registry.terraform.io/providers/hashicorp/azurerm/3.53.0/docs/resources/data_factory_pipeline) | resource |
| [azurerm_data_factory_pipeline.pipeline_PDND_KPI_WPNFDR](https://registry.terraform.io/providers/hashicorp/azurerm/3.53.0/docs/resources/data_factory_pipeline) | resource |
| [azurerm_data_factory_trigger_schedule.Trigger_KPI_FDR_IMPORT_ESITI](https://registry.terraform.io/providers/hashicorp/azurerm/3.53.0/docs/resources/data_factory_trigger_schedule) | resource |
| [azurerm_data_factory_trigger_schedule.Trigger_KPI_FDR_RENDICONTAZIONI](https://registry.terraform.io/providers/hashicorp/azurerm/3.53.0/docs/resources/data_factory_trigger_schedule) | resource |
| [azurerm_data_factory_trigger_schedule.Trigger_KPI_TNSPO](https://registry.terraform.io/providers/hashicorp/azurerm/3.53.0/docs/resources/data_factory_trigger_schedule) | resource |
| [azurerm_data_factory_trigger_schedule.Trigger_KPI_TPNP](https://registry.terraform.io/providers/hashicorp/azurerm/3.53.0/docs/resources/data_factory_trigger_schedule) | resource |
| [azurerm_data_factory_trigger_schedule.Trigger_KPI_TPSPO_DASPO](https://registry.terraform.io/providers/hashicorp/azurerm/3.53.0/docs/resources/data_factory_trigger_schedule) | resource |
| [azurerm_data_factory_trigger_schedule.Trigger_PDND_KPI_DASPO](https://registry.terraform.io/providers/hashicorp/azurerm/3.53.0/docs/resources/data_factory_trigger_schedule) | resource |
| [azurerm_data_factory_trigger_schedule.Trigger_PDND_KPI_LFDR](https://registry.terraform.io/providers/hashicorp/azurerm/3.53.0/docs/resources/data_factory_trigger_schedule) | resource |
| [azurerm_data_factory_trigger_schedule.Trigger_PDND_KPI_LSPO](https://registry.terraform.io/providers/hashicorp/azurerm/3.53.0/docs/resources/data_factory_trigger_schedule) | resource |
| [azurerm_data_factory_trigger_schedule.Trigger_PDND_KPI_NRFDR](https://registry.terraform.io/providers/hashicorp/azurerm/3.53.0/docs/resources/data_factory_trigger_schedule) | resource |
| [azurerm_data_factory_trigger_schedule.Trigger_PDND_KPI_TNSPO](https://registry.terraform.io/providers/hashicorp/azurerm/3.53.0/docs/resources/data_factory_trigger_schedule) | resource |
| [azurerm_data_factory_trigger_schedule.Trigger_PDND_KPI_TPNP](https://registry.terraform.io/providers/hashicorp/azurerm/3.53.0/docs/resources/data_factory_trigger_schedule) | resource |
| [azurerm_data_factory_trigger_schedule.Trigger_PDND_KPI_WAFDR](https://registry.terraform.io/providers/hashicorp/azurerm/3.53.0/docs/resources/data_factory_trigger_schedule) | resource |
| [azurerm_data_factory_trigger_schedule.Trigger_PDND_KPI_WPNFDR](https://registry.terraform.io/providers/hashicorp/azurerm/3.53.0/docs/resources/data_factory_trigger_schedule) | resource |
| [azurerm_key_vault_secret.apim_app_forwarder_subscription_key](https://registry.terraform.io/providers/hashicorp/azurerm/3.53.0/docs/resources/key_vault_secret) | resource |
| [azurerm_key_vault_secret.certificate_crt_app_forwarder_s](https://registry.terraform.io/providers/hashicorp/azurerm/3.53.0/docs/resources/key_vault_secret) | resource |
| [azurerm_key_vault_secret.certificate_key_app_forwarder_s](https://registry.terraform.io/providers/hashicorp/azurerm/3.53.0/docs/resources/key_vault_secret) | resource |
| [azurerm_kusto_cluster.data_explorer_cluster](https://registry.terraform.io/providers/hashicorp/azurerm/3.53.0/docs/resources/kusto_cluster) | resource |
| [azurerm_kusto_database.re_db](https://registry.terraform.io/providers/hashicorp/azurerm/3.53.0/docs/resources/kusto_database) | resource |
| [azurerm_kusto_database_principal_assignment.qi_principal_assignment](https://registry.terraform.io/providers/hashicorp/azurerm/3.53.0/docs/resources/kusto_database_principal_assignment) | resource |
| [azurerm_kusto_eventhub_data_connection.eventhub_connection_for_re_event](https://registry.terraform.io/providers/hashicorp/azurerm/3.53.0/docs/resources/kusto_eventhub_data_connection) | resource |
| [azurerm_client_config.current](https://registry.terraform.io/providers/hashicorp/azurerm/3.53.0/docs/data-sources/client_config) | data source |
| [azurerm_container_registry.acr](https://registry.terraform.io/providers/hashicorp/azurerm/3.53.0/docs/data-sources/container_registry) | data source |
| [azurerm_cosmosdb_account.bizevent_cosmos_account](https://registry.terraform.io/providers/hashicorp/azurerm/3.53.0/docs/data-sources/cosmosdb_account) | data source |
| [azurerm_data_factory.qi_data_factory](https://registry.terraform.io/providers/hashicorp/azurerm/3.53.0/docs/data-sources/data_factory) | data source |
| [azurerm_data_factory.qi_data_factory_cosmos](https://registry.terraform.io/providers/hashicorp/azurerm/3.53.0/docs/data-sources/data_factory) | data source |
| [azurerm_eventhub.pagopa-evh-ns03_nodo-dei-pagamenti-re_nodo-dei-pagamenti-re](https://registry.terraform.io/providers/hashicorp/azurerm/3.53.0/docs/data-sources/eventhub) | data source |
| [azurerm_key_vault.kv](https://registry.terraform.io/providers/hashicorp/azurerm/3.53.0/docs/data-sources/key_vault) | data source |
| [azurerm_key_vault.kv_shared](https://registry.terraform.io/providers/hashicorp/azurerm/3.53.0/docs/data-sources/key_vault) | data source |
| [azurerm_key_vault_secret.certificate_crt_app_forwarder](https://registry.terraform.io/providers/hashicorp/azurerm/3.53.0/docs/data-sources/key_vault_secret) | data source |
| [azurerm_key_vault_secret.certificate_key_app_forwarder](https://registry.terraform.io/providers/hashicorp/azurerm/3.53.0/docs/data-sources/key_vault_secret) | data source |
| [azurerm_resource_group.monitor_rg](https://registry.terraform.io/providers/hashicorp/azurerm/3.53.0/docs/data-sources/resource_group) | data source |
| [azurerm_resource_group.rg_node_forwarder](https://registry.terraform.io/providers/hashicorp/azurerm/3.53.0/docs/data-sources/resource_group) | data source |
| [azurerm_subnet.subnet_apim](https://registry.terraform.io/providers/hashicorp/azurerm/3.53.0/docs/data-sources/subnet) | data source |
| [azurerm_subnet.subnet_node_forwarder](https://registry.terraform.io/providers/hashicorp/azurerm/3.53.0/docs/data-sources/subnet) | data source |
| [azurerm_subscription.current](https://registry.terraform.io/providers/hashicorp/azurerm/3.53.0/docs/data-sources/subscription) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_apim_dns_zone_prefix"></a> [apim\_dns\_zone\_prefix](#input\_apim\_dns\_zone\_prefix) | The dns subdomain for apim. | `string` | `null` | no |
| <a name="input_app_forwarder_enabled"></a> [app\_forwarder\_enabled](#input\_app\_forwarder\_enabled) | Enable app\_forwarder | `bool` | `false` | no |
| <a name="input_dexp_db"></a> [dexp\_db](#input\_dexp\_db) | n/a | <pre>object({<br>    enable             = bool<br>    hot_cache_period   = string<br>    soft_delete_period = string<br>  })</pre> | n/a | yes |
| <a name="input_dexp_params"></a> [dexp\_params](#input\_dexp\_params) | n/a | <pre>object({<br>    enabled = bool<br>    sku = object({<br>      name     = string<br>      capacity = number<br>    })<br>    autoscale = object({<br>      enabled       = bool<br>      min_instances = number<br>      max_instances = number<br>    })<br>    public_network_access_enabled = bool<br>    double_encryption_enabled     = bool<br>    disk_encryption_enabled       = bool<br>    purge_enabled                 = bool<br>  })</pre> | n/a | yes |
| <a name="input_dexp_re_db_linkes_service"></a> [dexp\_re\_db\_linkes\_service](#input\_dexp\_re\_db\_linkes\_service) | n/a | <pre>object({<br>    enable = bool<br>  })</pre> | n/a | yes |
| <a name="input_domain"></a> [domain](#input\_domain) | n/a | `string` | n/a | yes |
| <a name="input_env"></a> [env](#input\_env) | n/a | `string` | n/a | yes |
| <a name="input_env_short"></a> [env\_short](#input\_env\_short) | n/a | `string` | n/a | yes |
| <a name="input_external_domain"></a> [external\_domain](#input\_external\_domain) | Domain for delegation | `string` | `null` | no |
| <a name="input_instance"></a> [instance](#input\_instance) | One of beta, prod01, prod02 | `string` | n/a | yes |
| <a name="input_location"></a> [location](#input\_location) | One of westeurope, northeurope | `string` | n/a | yes |
| <a name="input_location_short"></a> [location\_short](#input\_location\_short) | One of wue, neu | `string` | n/a | yes |
| <a name="input_monitor_resource_group_name"></a> [monitor\_resource\_group\_name](#input\_monitor\_resource\_group\_name) | Monitor resource group name | `string` | n/a | yes |
| <a name="input_prefix"></a> [prefix](#input\_prefix) | n/a | `string` | n/a | yes |
| <a name="input_tags"></a> [tags](#input\_tags) | n/a | `map(any)` | <pre>{<br>  "CreatedBy": "Terraform"<br>}</pre> | no |

## Outputs

No outputs.
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->