## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.6 |
| <a name="requirement_azuread"></a> [azuread](#requirement\_azuread) | <= 2.47.0 |
| <a name="requirement_azurerm"></a> [azurerm](#requirement\_azurerm) | <= 3.97.1 |
| <a name="requirement_null"></a> [null](#requirement\_null) | <= 3.2.2 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_azurerm"></a> [azurerm](#provider\_azurerm) | 3.84.0 |
| <a name="provider_null"></a> [null](#provider\_null) | 3.2.2 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_cosmosdb_account_mongodb"></a> [cosmosdb\_account\_mongodb](#module\_cosmosdb\_account\_mongodb) | git::https://github.com/pagopa/terraform-azurerm-v3.git//cosmosdb_account | v8.5.0 |
| <a name="module_cosmosdb_notices_collections"></a> [cosmosdb\_notices\_collections](#module\_cosmosdb\_notices\_collections) | git::https://github.com/pagopa/terraform-azurerm-v3.git//cosmosdb_mongodb_collection | v8.5.0 |
| <a name="module_identity_cd_01"></a> [identity\_cd\_01](#module\_identity\_cd\_01) | github.com/pagopa/terraform-azurerm-v3//github_federated_identity | v7.45.0 |
| <a name="module_institutions_sa"></a> [institutions\_sa](#module\_institutions\_sa) | git::https://github.com/pagopa/terraform-azurerm-v3.git//storage_account | v8.5.0 |
| <a name="module_notices_sa"></a> [notices\_sa](#module\_notices\_sa) | git::https://github.com/pagopa/terraform-azurerm-v3.git//storage_account | v8.5.0 |
| <a name="module_templates_sa"></a> [templates\_sa](#module\_templates\_sa) | git::https://github.com/pagopa/terraform-azurerm-v3.git//storage_account | v8.5.0 |

## Resources

| Name | Type |
|------|------|
| [azurerm_cosmosdb_mongo_database.notices_mongo_db](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/cosmosdb_mongo_database) | resource |
| [azurerm_key_vault_access_policy.gha_iac_managed_identities](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/key_vault_access_policy) | resource |
| [azurerm_private_dns_a_record.ingress](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/private_dns_a_record) | resource |
| [azurerm_private_endpoint.institutions_blob_private_endpoint](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/private_endpoint) | resource |
| [azurerm_private_endpoint.notices_blob_private_endpoint](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/private_endpoint) | resource |
| [azurerm_private_endpoint.notices_table_private_endpoint](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/private_endpoint) | resource |
| [azurerm_private_endpoint.templates_blob_private_endpoint](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/private_endpoint) | resource |
| [azurerm_resource_group.db_rg](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/resource_group) | resource |
| [azurerm_resource_group.printit_rg](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/resource_group) | resource |
| [azurerm_storage_container.institutions_blob_file](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/storage_container) | resource |
| [azurerm_storage_container.notices_blob_file](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/storage_container) | resource |
| [azurerm_storage_container.template_blob_file](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/storage_container) | resource |
| [azurerm_storage_management_policy.st_blob_receipts_management_policy](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/storage_management_policy) | resource |
| [azurerm_storage_table.template_data_table](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/storage_table) | resource |
| [null_resource.github_runner_app_permissions_to_namespace_cd_01](https://registry.terraform.io/providers/hashicorp/null/latest/docs/resources/resource) | resource |
| [azurerm_application_insights.application_insights](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/application_insights) | data source |
| [azurerm_client_config.current](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/client_config) | data source |
| [azurerm_key_vault.key_vault](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/key_vault) | data source |
| [azurerm_kubernetes_cluster.aks](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/kubernetes_cluster) | data source |
| [azurerm_log_analytics_workspace.log_analytics](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/log_analytics_workspace) | data source |
| [azurerm_monitor_action_group.email](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/monitor_action_group) | data source |
| [azurerm_monitor_action_group.slack](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/monitor_action_group) | data source |
| [azurerm_private_dns_zone.cosmos](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/private_dns_zone) | data source |
| [azurerm_private_dns_zone.internal](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/private_dns_zone) | data source |
| [azurerm_private_dns_zone.privatelink_blob_azure_com](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/private_dns_zone) | data source |
| [azurerm_private_dns_zone.privatelink_queue_azure_com](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/private_dns_zone) | data source |
| [azurerm_private_dns_zone.privatelink_table_azure_com](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/private_dns_zone) | data source |
| [azurerm_resource_group.identity_rg](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/resource_group) | data source |
| [azurerm_resource_group.monitor_rg](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/resource_group) | data source |
| [azurerm_resource_group.rg_vnet](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/resource_group) | data source |
| [azurerm_subnet.aks_subnet](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/subnet) | data source |
| [azurerm_subnet.cosmos_subnet](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/subnet) | data source |
| [azurerm_subnet.storage_subnet](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/subnet) | data source |
| [azurerm_subscription.current](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/subscription) | data source |
| [azurerm_virtual_network.vnet](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/virtual_network) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_cosmos_mongo_db_notices_params"></a> [cosmos\_mongo\_db\_notices\_params](#input\_cosmos\_mongo\_db\_notices\_params) | CosmosDB | <pre>object({<br>    capabilities   = list(string)<br>    offer_type     = string<br>    server_version = string<br>    kind           = string<br>    consistency_policy = object({<br>      consistency_level       = string<br>      max_interval_in_seconds = number<br>      max_staleness_prefix    = number<br>    })<br>    main_geo_location_zone_redundant = bool<br>    enable_free_tier                 = bool<br>    additional_geo_locations = list(object({<br>      location          = string<br>      failover_priority = number<br>      zone_redundant    = bool<br>    }))<br>    private_endpoint_enabled          = bool<br>    public_network_access_enabled     = bool<br>    is_virtual_network_filter_enabled = bool<br>    backup_continuous_enabled         = bool<br>    enable_serverless                 = bool<br>    enable_autoscaling                = bool<br>    throughput                        = number<br>    max_throughput                    = number<br>    container_default_ttl             = number<br>  })</pre> | n/a | yes |
| <a name="input_domain"></a> [domain](#input\_domain) | n/a | `string` | n/a | yes |
| <a name="input_env"></a> [env](#input\_env) | n/a | `string` | n/a | yes |
| <a name="input_env_short"></a> [env\_short](#input\_env\_short) | n/a | `string` | n/a | yes |
| <a name="input_ingress_load_balancer_ip"></a> [ingress\_load\_balancer\_ip](#input\_ingress\_load\_balancer\_ip) | n/a | `string` | n/a | yes |
| <a name="input_instance"></a> [instance](#input\_instance) | One of beta, prod01, prod02 | `string` | n/a | yes |
| <a name="input_institutions_storage_account"></a> [institutions\_storage\_account](#input\_institutions\_storage\_account) | n/a | <pre>object({<br>    account_kind                  = string<br>    account_tier                  = string<br>    account_replication_type      = string<br>    advanced_threat_protection    = bool<br>    blob_versioning_enabled       = bool<br>    public_network_access_enabled = bool<br>    blob_delete_retention_days    = number<br>    enable_low_availability_alert = bool<br>    backup_enabled                = optional(bool, false)<br>    backup_retention              = optional(number, 0)<br>  })</pre> | n/a | yes |
| <a name="input_is_feature_enabled"></a> [is\_feature\_enabled](#input\_is\_feature\_enabled) | n/a | <pre>object({<br>    cosmosdb_notice      = bool<br>    storage_institutions = bool<br>    storage_notice       = bool<br>    storage_templates    = bool<br>  })</pre> | n/a | yes |
| <a name="input_location"></a> [location](#input\_location) | One of westeurope, northeurope | `string` | n/a | yes |
| <a name="input_log_analytics_workspace_name"></a> [log\_analytics\_workspace\_name](#input\_log\_analytics\_workspace\_name) | Specifies the name of the Log Analytics Workspace. | `string` | n/a | yes |
| <a name="input_log_analytics_workspace_resource_group_name"></a> [log\_analytics\_workspace\_resource\_group\_name](#input\_log\_analytics\_workspace\_resource\_group\_name) | The name of the resource group in which the Log Analytics workspace is located in. | `string` | n/a | yes |
| <a name="input_monitor_resource_group_name"></a> [monitor\_resource\_group\_name](#input\_monitor\_resource\_group\_name) | Monitor resource group name | `string` | n/a | yes |
| <a name="input_notices_storage_account"></a> [notices\_storage\_account](#input\_notices\_storage\_account) | n/a | <pre>object({<br>    account_kind                                                        = string<br>    account_tier                                                        = string<br>    account_replication_type                                            = string<br>    advanced_threat_protection                                          = bool<br>    blob_versioning_enabled                                             = bool<br>    public_network_access_enabled                                       = bool<br>    blob_delete_retention_days                                          = number<br>    enable_low_availability_alert                                       = bool<br>    backup_enabled                                                      = optional(bool, false)<br>    backup_retention                                                    = optional(number, 0)<br>    blob_tier_to_cool_after_last_access                                 = number<br>    blob_tier_to_archive_after_days_since_last_access_time_greater_than = number<br>    blob_delete_after_last_access                                       = number<br>  })</pre> | n/a | yes |
| <a name="input_prefix"></a> [prefix](#input\_prefix) | n/a | `string` | n/a | yes |
| <a name="input_templates_storage_account"></a> [templates\_storage\_account](#input\_templates\_storage\_account) | n/a | <pre>object({<br>    account_kind                  = string<br>    account_tier                  = string<br>    account_replication_type      = string<br>    advanced_threat_protection    = bool<br>    blob_versioning_enabled       = bool<br>    public_network_access_enabled = bool<br>    blob_delete_retention_days    = number<br>    enable_low_availability_alert = bool<br>    backup_enabled                = optional(bool, false)<br>    backup_retention              = optional(number, 0)<br>  })</pre> | n/a | yes |
| <a name="input_dns_zone_internal_prefix"></a> [dns\_zone\_internal\_prefix](#input\_dns\_zone\_internal\_prefix) | The dns subdomain. | `string` | `null` | no |
| <a name="input_dns_zone_platform"></a> [dns\_zone\_platform](#input\_dns\_zone\_platform) | The platform dns subdomain. | `string` | `null` | no |
| <a name="input_dns_zone_prefix"></a> [dns\_zone\_prefix](#input\_dns\_zone\_prefix) | The wallet dns subdomain. | `string` | `null` | no |
| <a name="input_ehns_alerts_enabled"></a> [ehns\_alerts\_enabled](#input\_ehns\_alerts\_enabled) | Event hub alerts enabled? | `bool` | `true` | no |
| <a name="input_ehns_auto_inflate_enabled"></a> [ehns\_auto\_inflate\_enabled](#input\_ehns\_auto\_inflate\_enabled) | Is Auto Inflate enabled for the EventHub Namespace? | `bool` | `false` | no |
| <a name="input_ehns_capacity"></a> [ehns\_capacity](#input\_ehns\_capacity) | Specifies the Capacity / Throughput Units for a Standard SKU namespace. | `number` | `null` | no |
| <a name="input_ehns_maximum_throughput_units"></a> [ehns\_maximum\_throughput\_units](#input\_ehns\_maximum\_throughput\_units) | Specifies the maximum number of throughput units when Auto Inflate is Enabled | `number` | `null` | no |
| <a name="input_ehns_metric_alerts"></a> [ehns\_metric\_alerts](#input\_ehns\_metric\_alerts) | Map of name = criteria objects | <pre>map(object({<br>    # criteria.*.aggregation to be one of [Average Count Minimum Maximum Total]<br>    aggregation = string<br>    metric_name = string<br>    description = string<br>    # criteria.0.operator to be one of [Equals NotEquals GreaterThan GreaterThanOrEqual LessThan LessThanOrEqual]<br>    operator  = string<br>    threshold = number<br>    # Possible values are PT1M, PT5M, PT15M, PT30M and PT1H<br>    frequency = string<br>    # Possible values are PT1M, PT5M, PT15M, PT30M, PT1H, PT6H, PT12H and P1D.<br>    window_size = string<br><br>    dimension = list(object(<br>      {<br>        name     = string<br>        operator = string<br>        values   = list(string)<br>      }<br>    ))<br>  }))</pre> | `{}` | no |
| <a name="input_ehns_sku_name"></a> [ehns\_sku\_name](#input\_ehns\_sku\_name) | Defines which tier to use. | `string` | `"Basic"` | no |
| <a name="input_ehns_zone_redundant"></a> [ehns\_zone\_redundant](#input\_ehns\_zone\_redundant) | Specifies if the EventHub Namespace should be Zone Redundant (created across Availability Zones). | `bool` | `false` | no |
| <a name="input_eventhub_enabled"></a> [eventhub\_enabled](#input\_eventhub\_enabled) | eventhub enable? | `bool` | `false` | no |
| <a name="input_eventhubs"></a> [eventhubs](#input\_eventhubs) | A list of event hubs to add to namespace. | <pre>list(object({<br>    name              = string<br>    partitions        = number<br>    message_retention = number<br>    consumers         = list(string)<br>    keys = list(object({<br>      name   = string<br>      listen = bool<br>      send   = bool<br>      manage = bool<br>    }))<br>  }))</pre> | `[]` | no |
| <a name="input_external_domain"></a> [external\_domain](#input\_external\_domain) | Domain for delegation | `string` | `null` | no |
| <a name="input_location_short"></a> [location\_short](#input\_location\_short) | One of wue, neu | `string` | `"itn"` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | n/a | `map(any)` | <pre>{<br>  "CreatedBy": "Terraform"<br>}</pre> | no |

## Outputs

No outputs.
<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.6 |
| <a name="requirement_azuread"></a> [azuread](#requirement\_azuread) | <= 2.47.0 |
| <a name="requirement_azurerm"></a> [azurerm](#requirement\_azurerm) | <= 3.116.0 |
| <a name="requirement_null"></a> [null](#requirement\_null) | <= 3.2.2 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module___v3__"></a> [\_\_v3\_\_](#module\_\_\_v3\_\_) | git::https://github.com/pagopa/terraform-azurerm-v3 | 087a57940a67444c3b883030c54ceb78562c64ef |
| <a name="module_cosmosdb_account_mongodb"></a> [cosmosdb\_account\_mongodb](#module\_cosmosdb\_account\_mongodb) | ./.terraform/modules/__v3__//cosmosdb_account | n/a |
| <a name="module_cosmosdb_notices_collections"></a> [cosmosdb\_notices\_collections](#module\_cosmosdb\_notices\_collections) | ./.terraform/modules/__v3__//cosmosdb_mongodb_collection | n/a |
| <a name="module_eventhub_namespace"></a> [eventhub\_namespace](#module\_eventhub\_namespace) | git::https://github.com/pagopa/terraform-azurerm-v3.git//eventhub | v8.22.0 |
| <a name="module_eventhub_printit_configuration"></a> [eventhub\_printit\_configuration](#module\_eventhub\_printit\_configuration) | ./.terraform/modules/__v3__//eventhub_configuration | n/a |
| <a name="module_identity_cd_01"></a> [identity\_cd\_01](#module\_identity\_cd\_01) | github.com/pagopa/terraform-azurerm-v3//github_federated_identity | v8.22.0 |
| <a name="module_identity_pr_01"></a> [identity\_pr\_01](#module\_identity\_pr\_01) | github.com/pagopa/terraform-azurerm-v3//github_federated_identity | v8.22.0 |
| <a name="module_identity_ref_01"></a> [identity\_ref\_01](#module\_identity\_ref\_01) | github.com/pagopa/terraform-azurerm-v3//github_federated_identity | v8.36.1 |
| <a name="module_institutions_sa"></a> [institutions\_sa](#module\_institutions\_sa) | ./.terraform/modules/__v3__//storage_account | n/a |
| <a name="module_notices_sa"></a> [notices\_sa](#module\_notices\_sa) | ./.terraform/modules/__v3__//storage_account | n/a |
| <a name="module_tag_config"></a> [tag\_config](#module\_tag\_config) | ../../tag_config | n/a |
| <a name="module_templates_sa"></a> [templates\_sa](#module\_templates\_sa) | ./.terraform/modules/__v3__//storage_account | n/a |
| <a name="module_workload_identity"></a> [workload\_identity](#module\_workload\_identity) | ./.terraform/modules/__v3__/kubernetes_workload_identity_init | n/a |

## Resources

| Name | Type |
|------|------|
| [azurerm_cosmosdb_mongo_database.notices_mongo_db](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/cosmosdb_mongo_database) | resource |
| [azurerm_key_vault_access_policy.gha_iac_managed_identities](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/key_vault_access_policy) | resource |
| [azurerm_key_vault_access_policy.gha_pr_iac_managed_identities](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/key_vault_access_policy) | resource |
| [azurerm_key_vault_access_policy.gha_ref_iac_managed_identities](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/key_vault_access_policy) | resource |
| [azurerm_key_vault_secret.blob_storage_pdf_client_id](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/key_vault_secret) | resource |
| [azurerm_private_dns_a_record.ingress](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/private_dns_a_record) | resource |
| [azurerm_private_endpoint.institutions_blob_private_endpoint](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/private_endpoint) | resource |
| [azurerm_private_endpoint.notices_blob_private_endpoint](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/private_endpoint) | resource |
| [azurerm_private_endpoint.notices_table_private_endpoint](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/private_endpoint) | resource |
| [azurerm_private_endpoint.templates_blob_private_endpoint](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/private_endpoint) | resource |
| [azurerm_resource_group.db_rg](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/resource_group) | resource |
| [azurerm_resource_group.eventhub_ita_rg](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/resource_group) | resource |
| [azurerm_resource_group.printit_rg](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/resource_group) | resource |
| [azurerm_role_assignment.role_blob_storage_pdf](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/role_assignment) | resource |
| [azurerm_storage_container.institutions_blob_file](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/storage_container) | resource |
| [azurerm_storage_container.institutions_blob_logo_file](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/storage_container) | resource |
| [azurerm_storage_container.notices_blob_file](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/storage_container) | resource |
| [azurerm_storage_container.template_blob_file](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/storage_container) | resource |
| [azurerm_storage_management_policy.st_blob_receipts_management_policy](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/storage_management_policy) | resource |
| [azurerm_storage_table.template_data_table](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/storage_table) | resource |
| [azurerm_subnet.cidr_redis_italy](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/subnet) | resource |
| [azurerm_subnet.cidr_storage_italy](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/subnet) | resource |
| [azurerm_subnet.cosmosdb_italy_snet](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/subnet) | resource |
| [azurerm_subnet.eventhub_italy](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/subnet) | resource |
| [azurerm_subnet.pdf_engine_italy_snet](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/subnet) | resource |
| [azurerm_user_assigned_identity.identity_blob_storage_pdf](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/user_assigned_identity) | resource |
| [null_resource.github_runner_app_permissions_to_namespace_cd_01](https://registry.terraform.io/providers/hashicorp/null/latest/docs/resources/resource) | resource |
| [azurerm_application_insights.application_insights_italy](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/application_insights) | data source |
| [azurerm_client_config.current](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/client_config) | data source |
| [azurerm_key_vault.key_vault](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/key_vault) | data source |
| [azurerm_key_vault.kv](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/key_vault) | data source |
| [azurerm_kubernetes_cluster.aks](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/kubernetes_cluster) | data source |
| [azurerm_log_analytics_workspace.log_analytics_italy](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/log_analytics_workspace) | data source |
| [azurerm_monitor_action_group.email](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/monitor_action_group) | data source |
| [azurerm_monitor_action_group.slack](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/monitor_action_group) | data source |
| [azurerm_private_dns_zone.cosmos](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/private_dns_zone) | data source |
| [azurerm_private_dns_zone.eventhub](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/private_dns_zone) | data source |
| [azurerm_private_dns_zone.internal](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/private_dns_zone) | data source |
| [azurerm_private_dns_zone.privatelink_blob_azure_com](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/private_dns_zone) | data source |
| [azurerm_private_dns_zone.privatelink_queue_azure_com](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/private_dns_zone) | data source |
| [azurerm_private_dns_zone.privatelink_table_azure_com](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/private_dns_zone) | data source |
| [azurerm_resource_group.identity_rg](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/resource_group) | data source |
| [azurerm_resource_group.monitor_italy_rg](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/resource_group) | data source |
| [azurerm_resource_group.rg_event_private_dns_zone](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/resource_group) | data source |
| [azurerm_resource_group.rg_vnet_italy](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/resource_group) | data source |
| [azurerm_subnet.aks_subnet](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/subnet) | data source |
| [azurerm_subscription.current](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/subscription) | data source |
| [azurerm_virtual_network.vnet_italy](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/virtual_network) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_cidr_printit_cosmosdb_italy"></a> [cidr\_printit\_cosmosdb\_italy](#input\_cidr\_printit\_cosmosdb\_italy) | Address prefixes for all cosmosdb in italy. | `list(string)` | n/a | yes |
| <a name="input_cidr_printit_eventhub_italy"></a> [cidr\_printit\_eventhub\_italy](#input\_cidr\_printit\_eventhub\_italy) | Address prefixes for all evh accounts in italy. | `list(string)` | n/a | yes |
| <a name="input_cidr_printit_pdf_engine_italy"></a> [cidr\_printit\_pdf\_engine\_italy](#input\_cidr\_printit\_pdf\_engine\_italy) | Address prefixes for all pdf engine accounts in italy. | `list(string)` | n/a | yes |
| <a name="input_cidr_printit_redis_italy"></a> [cidr\_printit\_redis\_italy](#input\_cidr\_printit\_redis\_italy) | Address prefixes for all redis accounts in italy. | `list(string)` | n/a | yes |
| <a name="input_cidr_printit_storage_italy"></a> [cidr\_printit\_storage\_italy](#input\_cidr\_printit\_storage\_italy) | Address prefixes for all storage accounts in italy. | `list(string)` | n/a | yes |
| <a name="input_cosmos_mongo_db_notices_params"></a> [cosmos\_mongo\_db\_notices\_params](#input\_cosmos\_mongo\_db\_notices\_params) | CosmosDB | <pre>object({<br>    capabilities   = list(string)<br>    offer_type     = string<br>    server_version = string<br>    kind           = string<br>    consistency_policy = object({<br>      consistency_level       = string<br>      max_interval_in_seconds = number<br>      max_staleness_prefix    = number<br>    })<br>    main_geo_location_zone_redundant = bool<br>    enable_free_tier                 = bool<br>    additional_geo_locations = list(object({<br>      location          = string<br>      failover_priority = number<br>      zone_redundant    = bool<br>    }))<br>    private_endpoint_enabled          = bool<br>    public_network_access_enabled     = bool<br>    is_virtual_network_filter_enabled = bool<br>    backup_continuous_enabled         = bool<br>    enable_serverless                 = bool<br>    enable_autoscaling                = bool<br>    throughput                        = number<br>    max_throughput                    = number<br>    container_default_ttl             = number<br>  })</pre> | n/a | yes |
| <a name="input_dns_zone_internal_prefix"></a> [dns\_zone\_internal\_prefix](#input\_dns\_zone\_internal\_prefix) | The dns subdomain. | `string` | `null` | no |
| <a name="input_dns_zone_platform"></a> [dns\_zone\_platform](#input\_dns\_zone\_platform) | The platform dns subdomain. | `string` | `null` | no |
| <a name="input_dns_zone_prefix"></a> [dns\_zone\_prefix](#input\_dns\_zone\_prefix) | The wallet dns subdomain. | `string` | `null` | no |
| <a name="input_domain"></a> [domain](#input\_domain) | n/a | `string` | n/a | yes |
| <a name="input_ehns_alerts_enabled"></a> [ehns\_alerts\_enabled](#input\_ehns\_alerts\_enabled) | Event hub alerts enabled? | `bool` | n/a | yes |
| <a name="input_ehns_auto_inflate_enabled"></a> [ehns\_auto\_inflate\_enabled](#input\_ehns\_auto\_inflate\_enabled) | Is Auto Inflate enabled for the EventHub Namespace? | `bool` | n/a | yes |
| <a name="input_ehns_capacity"></a> [ehns\_capacity](#input\_ehns\_capacity) | Specifies the Capacity / Throughput Units for a Standard SKU namespace. | `number` | n/a | yes |
| <a name="input_ehns_maximum_throughput_units"></a> [ehns\_maximum\_throughput\_units](#input\_ehns\_maximum\_throughput\_units) | Specifies the maximum number of throughput units when Auto Inflate is Enabled | `number` | n/a | yes |
| <a name="input_ehns_metric_alerts"></a> [ehns\_metric\_alerts](#input\_ehns\_metric\_alerts) | Map of name = criteria objects | <pre>map(object({<br>    # criteria.*.aggregation to be one of [Average Count Minimum Maximum Total]<br>    aggregation = string<br>    metric_name = string<br>    description = string<br>    # criteria.0.operator to be one of [Equals NotEquals GreaterThan GreaterThanOrEqual LessThan LessThanOrEqual]<br>    operator  = string<br>    threshold = number<br>    # Possible values are PT1M, PT5M, PT15M, PT30M and PT1H<br>    frequency = string<br>    # Possible values are PT1M, PT5M, PT15M, PT30M, PT1H, PT6H, PT12H and P1D.<br>    window_size = string<br><br>    dimension = list(object(<br>      {<br>        name     = string<br>        operator = string<br>        values   = list(string)<br>      }<br>    ))<br>  }))</pre> | `{}` | no |
| <a name="input_ehns_private_endpoint_is_present"></a> [ehns\_private\_endpoint\_is\_present](#input\_ehns\_private\_endpoint\_is\_present) | (Required) create private endpoint to the event hubs | `bool` | n/a | yes |
| <a name="input_ehns_public_network_access"></a> [ehns\_public\_network\_access](#input\_ehns\_public\_network\_access) | (Required) enables public network access to the event hubs | `bool` | n/a | yes |
| <a name="input_ehns_sku_name"></a> [ehns\_sku\_name](#input\_ehns\_sku\_name) | Defines which tier to use. | `string` | n/a | yes |
| <a name="input_ehns_zone_redundant"></a> [ehns\_zone\_redundant](#input\_ehns\_zone\_redundant) | Specifies if the EventHub Namespace should be Zone Redundant (created across Availability Zones). | `bool` | n/a | yes |
| <a name="input_env"></a> [env](#input\_env) | n/a | `string` | n/a | yes |
| <a name="input_env_short"></a> [env\_short](#input\_env\_short) | n/a | `string` | n/a | yes |
| <a name="input_external_domain"></a> [external\_domain](#input\_external\_domain) | Domain for delegation | `string` | `null` | no |
| <a name="input_ingress_load_balancer_ip"></a> [ingress\_load\_balancer\_ip](#input\_ingress\_load\_balancer\_ip) | n/a | `string` | n/a | yes |
| <a name="input_instance"></a> [instance](#input\_instance) | One of beta, prod01, prod02 | `string` | n/a | yes |
| <a name="input_institutions_storage_account"></a> [institutions\_storage\_account](#input\_institutions\_storage\_account) | n/a | <pre>object({<br>    account_kind                  = string<br>    account_tier                  = string<br>    account_replication_type      = string<br>    advanced_threat_protection    = bool<br>    blob_versioning_enabled       = bool<br>    public_network_access_enabled = bool<br>    blob_delete_retention_days    = number<br>    enable_low_availability_alert = bool<br>    backup_enabled                = optional(bool, false)<br>    backup_retention              = optional(number, 0)<br>  })</pre> | n/a | yes |
| <a name="input_is_feature_enabled"></a> [is\_feature\_enabled](#input\_is\_feature\_enabled) | n/a | <pre>object({<br>    cosmosdb_notice      = bool<br>    storage_institutions = bool<br>    storage_notice       = bool<br>    storage_templates    = bool<br>    eventhub             = bool<br>  })</pre> | <pre>{<br>  "cosmosdb_notice": false,<br>  "eventhub": false,<br>  "storage_institutions": false,<br>  "storage_notice": false,<br>  "storage_templates": false<br>}</pre> | no |
| <a name="input_location"></a> [location](#input\_location) | One of westeurope, northeurope | `string` | n/a | yes |
| <a name="input_location_short"></a> [location\_short](#input\_location\_short) | One of wue, neu | `string` | `"itn"` | no |
| <a name="input_log_analytics_italy_workspace_name"></a> [log\_analytics\_italy\_workspace\_name](#input\_log\_analytics\_italy\_workspace\_name) | Specifies the name of the Log Analytics Workspace Italy. | `string` | n/a | yes |
| <a name="input_log_analytics_italy_workspace_resource_group_name"></a> [log\_analytics\_italy\_workspace\_resource\_group\_name](#input\_log\_analytics\_italy\_workspace\_resource\_group\_name) | The name of the resource group in which the Log Analytics workspace Italy is located in. | `string` | n/a | yes |
| <a name="input_log_analytics_workspace_name"></a> [log\_analytics\_workspace\_name](#input\_log\_analytics\_workspace\_name) | Specifies the name of the Log Analytics Workspace. | `string` | n/a | yes |
| <a name="input_log_analytics_workspace_resource_group_name"></a> [log\_analytics\_workspace\_resource\_group\_name](#input\_log\_analytics\_workspace\_resource\_group\_name) | The name of the resource group in which the Log Analytics workspace is located in. | `string` | n/a | yes |
| <a name="input_monitor_italy_resource_group_name"></a> [monitor\_italy\_resource\_group\_name](#input\_monitor\_italy\_resource\_group\_name) | Monitor Italy resource group name | `string` | n/a | yes |
| <a name="input_monitor_resource_group_name"></a> [monitor\_resource\_group\_name](#input\_monitor\_resource\_group\_name) | Monitor resource group name | `string` | n/a | yes |
| <a name="input_notices_storage_account"></a> [notices\_storage\_account](#input\_notices\_storage\_account) | Storage account | <pre>object({<br>    account_kind                        = string<br>    account_tier                        = string<br>    account_replication_type            = string<br>    advanced_threat_protection          = bool<br>    blob_versioning_enabled             = bool<br>    public_network_access_enabled       = bool<br>    blob_delete_retention_days          = number<br>    enable_low_availability_alert       = bool<br>    backup_enabled                      = optional(bool, false)<br>    backup_retention                    = optional(number, 0)<br>    blob_tier_to_cool_after_last_access = number<br>    #     blob_tier_to_archive_after_days_since_last_access_time_greater_than = number<br>    blob_delete_after_last_access = number<br>  })</pre> | n/a | yes |
| <a name="input_prefix"></a> [prefix](#input\_prefix) | general | `string` | n/a | yes |
| <a name="input_templates_storage_account"></a> [templates\_storage\_account](#input\_templates\_storage\_account) | n/a | <pre>object({<br>    account_kind                  = string<br>    account_tier                  = string<br>    account_replication_type      = string<br>    advanced_threat_protection    = bool<br>    blob_versioning_enabled       = bool<br>    public_network_access_enabled = bool<br>    blob_delete_retention_days    = number<br>    enable_low_availability_alert = bool<br>    backup_enabled                = optional(bool, false)<br>    backup_retention              = optional(number, 0)<br>  })</pre> | n/a | yes |

## Outputs

No outputs.
<!-- END_TF_DOCS -->
