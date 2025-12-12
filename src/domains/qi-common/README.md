<!-- markdownlint-disable -->
<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_azuread"></a> [azuread](#requirement\_azuread) | = 2.38.0 |
| <a name="requirement_azurerm"></a> [azurerm](#requirement\_azurerm) | <= 3.116.0 |
| <a name="requirement_null"></a> [null](#requirement\_null) | = 3.2.1 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module___v3__"></a> [\_\_v3\_\_](#module\_\_\_v3\_\_) | git::https://github.com/pagopa/terraform-azurerm-v3 | f3485105e35ce8c801209dcbb4ef72f3d944f0e5 |
| <a name="module_cosmosdb_account_mongodb"></a> [cosmosdb\_account\_mongodb](#module\_cosmosdb\_account\_mongodb) | ./.terraform/modules/__v3__/cosmosdb_account | n/a |
| <a name="module_cosmosdb_accounting_reconciliation_collections"></a> [cosmosdb\_accounting\_reconciliation\_collections](#module\_cosmosdb\_accounting\_reconciliation\_collections) | ./.terraform/modules/__v3__/cosmosdb_mongodb_collection | n/a |
| <a name="module_cosmosdb_qi_snet"></a> [cosmosdb\_qi\_snet](#module\_cosmosdb\_qi\_snet) | ./.terraform/modules/__v3__/subnet | n/a |
| <a name="module_eventhub_namespace_qi"></a> [eventhub\_namespace\_qi](#module\_eventhub\_namespace\_qi) | ./.terraform/modules/__v3__/eventhub | n/a |
| <a name="module_eventhub_qi_configuration"></a> [eventhub\_qi\_configuration](#module\_eventhub\_qi\_configuration) | ./.terraform/modules/__v3__/eventhub_configuration | n/a |
| <a name="module_identity_cd_01"></a> [identity\_cd\_01](#module\_identity\_cd\_01) | github.com/pagopa/terraform-azurerm-v3//github_federated_identity | n/a |
| <a name="module_key_vault"></a> [key\_vault](#module\_key\_vault) | ./.terraform/modules/__v3__/key_vault | n/a |
| <a name="module_letsencrypt_qi"></a> [letsencrypt\_qi](#module\_letsencrypt\_qi) | ./.terraform/modules/__v3__/letsencrypt_credential | n/a |
| <a name="module_qi_fn_sa"></a> [qi\_fn\_sa](#module\_qi\_fn\_sa) | ./.terraform/modules/__v3__/storage_account | n/a |
| <a name="module_tag_config"></a> [tag\_config](#module\_tag\_config) | ../../tag_config | n/a |
| <a name="module_workload_identity"></a> [workload\_identity](#module\_workload\_identity) | ./.terraform/modules/__v3__/kubernetes_workload_identity_init | n/a |

## Resources

| Name | Type |
|------|------|
| [azuread_application.qi_app](https://registry.terraform.io/providers/hashicorp/azuread/2.38.0/docs/resources/application) | resource |
| [azuread_application_password.qi_app_pwd](https://registry.terraform.io/providers/hashicorp/azuread/2.38.0/docs/resources/application_password) | resource |
| [azuread_service_principal.qi_sp](https://registry.terraform.io/providers/hashicorp/azuread/2.38.0/docs/resources/service_principal) | resource |
| [azurerm_cosmosdb_mongo_database.accounting_reconciliation](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/cosmosdb_mongo_database) | resource |
| [azurerm_key_vault_access_policy.ad_group_policy](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/key_vault_access_policy) | resource |
| [azurerm_key_vault_access_policy.adgroup_developers_policy](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/key_vault_access_policy) | resource |
| [azurerm_key_vault_access_policy.adgroup_externals_policy](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/key_vault_access_policy) | resource |
| [azurerm_key_vault_access_policy.adgroup_operation_policy](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/key_vault_access_policy) | resource |
| [azurerm_key_vault_access_policy.azdevops_iac_legacy_policies](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/key_vault_access_policy) | resource |
| [azurerm_key_vault_access_policy.azdevops_iac_managed_identities](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/key_vault_access_policy) | resource |
| [azurerm_key_vault_access_policy.azdevops_iac_policy](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/key_vault_access_policy) | resource |
| [azurerm_key_vault_access_policy.gha_iac_managed_identities](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/key_vault_access_policy) | resource |
| [azurerm_key_vault_secret.ai_connection_string](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/key_vault_secret) | resource |
| [azurerm_key_vault_secret.azure_data_explorer_re_application_key](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/key_vault_secret) | resource |
| [azurerm_key_vault_secret.azure_data_explorer_re_client_id](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/key_vault_secret) | resource |
| [azurerm_key_vault_secret.bdi_kpi_ingestion_dl_evt_tx_key](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/key_vault_secret) | resource |
| [azurerm_key_vault_secret.ehub_alert_qi_rx_connection_string](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/key_vault_secret) | resource |
| [azurerm_key_vault_secret.ehub_alert_qi_rx_debug_connection_string](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/key_vault_secret) | resource |
| [azurerm_key_vault_secret.ehub_alert_qi_rx_pdnd_connection_string](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/key_vault_secret) | resource |
| [azurerm_key_vault_secret.ehub_alert_qi_tx_connection_string](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/key_vault_secret) | resource |
| [azurerm_key_vault_secret.elastic_otel_token_header](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/key_vault_secret) | resource |
| [azurerm_key_vault_secret.qi_azurewebjobsstorage](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/key_vault_secret) | resource |
| [azurerm_key_vault_secret.qi_service_principal_client_id](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/key_vault_secret) | resource |
| [azurerm_key_vault_secret.qi_service_principal_client_secret](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/key_vault_secret) | resource |
| [azurerm_private_dns_a_record.ingress](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/private_dns_a_record) | resource |
| [azurerm_resource_group.cosmosdb_qi_rg](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/resource_group) | resource |
| [azurerm_resource_group.qi_evh_resource_group](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/resource_group) | resource |
| [azurerm_resource_group.qi_rg](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/resource_group) | resource |
| [azurerm_resource_group.sec_rg](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/resource_group) | resource |
| [azurerm_role_assignment.qi_monitoring_reader](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/role_assignment) | resource |
| [azurerm_subnet.eventhub_qi_snet](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/subnet) | resource |
| [null_resource.github_runner_app_permissions_to_namespace_cd_01](https://registry.terraform.io/providers/hashicorp/null/3.2.1/docs/resources/resource) | resource |
| [time_rotating.qi_application_time](https://registry.terraform.io/providers/hashicorp/time/latest/docs/resources/rotating) | resource |
| [azuread_group.adgroup_admin](https://registry.terraform.io/providers/hashicorp/azuread/2.38.0/docs/data-sources/group) | data source |
| [azuread_group.adgroup_developers](https://registry.terraform.io/providers/hashicorp/azuread/2.38.0/docs/data-sources/group) | data source |
| [azuread_group.adgroup_externals](https://registry.terraform.io/providers/hashicorp/azuread/2.38.0/docs/data-sources/group) | data source |
| [azuread_group.adgroup_operations](https://registry.terraform.io/providers/hashicorp/azuread/2.38.0/docs/data-sources/group) | data source |
| [azuread_group.adgroup_security](https://registry.terraform.io/providers/hashicorp/azuread/2.38.0/docs/data-sources/group) | data source |
| [azuread_service_principal.iac_deploy_legacy](https://registry.terraform.io/providers/hashicorp/azuread/2.38.0/docs/data-sources/service_principal) | data source |
| [azuread_service_principal.iac_plan_legacy](https://registry.terraform.io/providers/hashicorp/azuread/2.38.0/docs/data-sources/service_principal) | data source |
| [azuread_service_principal.iac_principal](https://registry.terraform.io/providers/hashicorp/azuread/2.38.0/docs/data-sources/service_principal) | data source |
| [azurerm_application_insights.application_insights](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/application_insights) | data source |
| [azurerm_client_config.current](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/client_config) | data source |
| [azurerm_eventhub_authorization_rule.pagopa-evh-ns04_quality-improvement-alerts_pagopa-qi-alert-rx](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/eventhub_authorization_rule) | data source |
| [azurerm_eventhub_authorization_rule.pagopa-evh-ns04_quality-improvement-alerts_pagopa-qi-alert-rx-debug](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/eventhub_authorization_rule) | data source |
| [azurerm_eventhub_authorization_rule.pagopa-evh-ns04_quality-improvement-alerts_pagopa-qi-alert-rx-pdnd](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/eventhub_authorization_rule) | data source |
| [azurerm_eventhub_authorization_rule.pagopa-evh-ns04_quality-improvement-alerts_pagopa-qi-alert-tx](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/eventhub_authorization_rule) | data source |
| [azurerm_key_vault.key_vault](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/key_vault) | data source |
| [azurerm_kubernetes_cluster.aks](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/kubernetes_cluster) | data source |
| [azurerm_log_analytics_workspace.log_analytics](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/log_analytics_workspace) | data source |
| [azurerm_monitor_action_group.email](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/monitor_action_group) | data source |
| [azurerm_monitor_action_group.slack](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/monitor_action_group) | data source |
| [azurerm_private_dns_zone.cosmos](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/private_dns_zone) | data source |
| [azurerm_private_dns_zone.eventhub](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/private_dns_zone) | data source |
| [azurerm_private_dns_zone.internal](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/private_dns_zone) | data source |
| [azurerm_resource_group.identity_rg](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/resource_group) | data source |
| [azurerm_resource_group.monitor_rg](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/resource_group) | data source |
| [azurerm_resource_group.rg_event_private_dns_zone](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/resource_group) | data source |
| [azurerm_resource_group.rg_vnet_italy](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/resource_group) | data source |
| [azurerm_subnet.aks_subnet](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/subnet) | data source |
| [azurerm_subscription.current](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/subscription) | data source |
| [azurerm_user_assigned_identity.iac_federated_azdo](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/user_assigned_identity) | data source |
| [azurerm_virtual_network.vnet](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/virtual_network) | data source |
| [azurerm_virtual_network.vnet_italy](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/virtual_network) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_cidr_subnet_cosmosdb_qi"></a> [cidr\_subnet\_cosmosdb\_qi](#input\_cidr\_subnet\_cosmosdb\_qi) | Cosmos DB address space for qi. | `list(string)` | n/a | yes |
| <a name="input_cidr_subnet_qi_evh"></a> [cidr\_subnet\_qi\_evh](#input\_cidr\_subnet\_qi\_evh) | Address prefixes evh | `list(string)` | n/a | yes |
| <a name="input_cosmos_mongo_db_accounting_reconciliation_params"></a> [cosmos\_mongo\_db\_accounting\_reconciliation\_params](#input\_cosmos\_mongo\_db\_accounting\_reconciliation\_params) | n/a | <pre>object({<br/>    enable_serverless  = bool<br/>    enable_autoscaling = bool<br/>    throughput         = number<br/>    max_throughput     = number<br/>  })</pre> | n/a | yes |
| <a name="input_cosmos_mongo_db_params"></a> [cosmos\_mongo\_db\_params](#input\_cosmos\_mongo\_db\_params) | n/a | <pre>object({<br/>    enabled        = bool<br/>    capabilities   = list(string)<br/>    offer_type     = string<br/>    server_version = string<br/>    kind           = string<br/>    consistency_policy = object({<br/>      consistency_level       = string<br/>      max_interval_in_seconds = number<br/>      max_staleness_prefix    = number<br/>    })<br/>    enable_free_tier                 = bool<br/>    main_geo_location_zone_redundant = bool<br/>    additional_geo_locations = list(object({<br/>      location          = string<br/>      failover_priority = number<br/>      zone_redundant    = bool<br/>    }))<br/>    private_endpoint_enabled                     = bool<br/>    public_network_access_enabled                = bool<br/>    is_virtual_network_filter_enabled            = bool<br/>    backup_continuous_enabled                    = bool<br/>    enable_provisioned_throughput_exceeded_alert = bool<br/>  })</pre> | n/a | yes |
| <a name="input_dns_zone_internal_prefix"></a> [dns\_zone\_internal\_prefix](#input\_dns\_zone\_internal\_prefix) | The dns subdomain. | `string` | `null` | no |
| <a name="input_domain"></a> [domain](#input\_domain) | n/a | `string` | n/a | yes |
| <a name="input_ehns_alerts_enabled"></a> [ehns\_alerts\_enabled](#input\_ehns\_alerts\_enabled) | Event hub alerts enabled? | `bool` | n/a | yes |
| <a name="input_ehns_auto_inflate_enabled"></a> [ehns\_auto\_inflate\_enabled](#input\_ehns\_auto\_inflate\_enabled) | Is Auto Inflate enabled for the EventHub Namespace? | `bool` | n/a | yes |
| <a name="input_ehns_capacity"></a> [ehns\_capacity](#input\_ehns\_capacity) | Specifies the Capacity / Throughput Units for a Standard SKU namespace. | `number` | n/a | yes |
| <a name="input_ehns_maximum_throughput_units"></a> [ehns\_maximum\_throughput\_units](#input\_ehns\_maximum\_throughput\_units) | Specifies the maximum number of throughput units when Auto Inflate is Enabled | `number` | n/a | yes |
| <a name="input_ehns_metric_alerts_qi"></a> [ehns\_metric\_alerts\_qi](#input\_ehns\_metric\_alerts\_qi) | Map of name = criteria objects | <pre>map(object({<br/>    # criteria.*.aggregation to be one of [Average Count Minimum Maximum Total]<br/>    aggregation = string<br/>    metric_name = string<br/>    description = string<br/>    # criteria.0.operator to be one of [Equals NotEquals GreaterThan GreaterThanOrEqual LessThan LessThanOrEqual]<br/>    operator  = string<br/>    threshold = number<br/>    # Possible values are PT1M, PT5M, PT15M, PT30M and PT1H<br/>    frequency = string<br/>    # Possible values are PT1M, PT5M, PT15M, PT30M, PT1H, PT6H, PT12H and P1D.<br/>    window_size = string<br/><br/>    dimension = list(object(<br/>      {<br/>        name     = string<br/>        operator = string<br/>        values   = list(string)<br/>      }<br/>    ))<br/>  }))</pre> | `{}` | no |
| <a name="input_ehns_private_endpoint_is_present"></a> [ehns\_private\_endpoint\_is\_present](#input\_ehns\_private\_endpoint\_is\_present) | (Required) create private endpoint to the event hubs | `bool` | n/a | yes |
| <a name="input_ehns_public_network_access"></a> [ehns\_public\_network\_access](#input\_ehns\_public\_network\_access) | (Required) enables public network access to the event hubs | `bool` | n/a | yes |
| <a name="input_ehns_sku_name"></a> [ehns\_sku\_name](#input\_ehns\_sku\_name) | Defines which tier to use. | `string` | n/a | yes |
| <a name="input_ehns_zone_redundant"></a> [ehns\_zone\_redundant](#input\_ehns\_zone\_redundant) | Specifies if the EventHub Namespace should be Zone Redundant (created across Availability Zones). | `bool` | n/a | yes |
| <a name="input_enable_iac_pipeline"></a> [enable\_iac\_pipeline](#input\_enable\_iac\_pipeline) | If true create the key vault policy to allow used by azure devops iac pipelines. | `bool` | `false` | no |
| <a name="input_env"></a> [env](#input\_env) | n/a | `string` | n/a | yes |
| <a name="input_env_short"></a> [env\_short](#input\_env\_short) | n/a | `string` | n/a | yes |
| <a name="input_eventhubs_bdi"></a> [eventhubs\_bdi](#input\_eventhubs\_bdi) | A list of event hubs to add to namespace. | <pre>list(object({<br/>    name              = string<br/>    partitions        = number<br/>    message_retention = number<br/>    consumers         = list(string)<br/>    keys = list(object({<br/>      name   = string<br/>      listen = bool<br/>      send   = bool<br/>      manage = bool<br/>    }))<br/>  }))</pre> | `[]` | no |
| <a name="input_external_domain"></a> [external\_domain](#input\_external\_domain) | Domain for delegation | `string` | `null` | no |
| <a name="input_ingress_load_balancer_ip"></a> [ingress\_load\_balancer\_ip](#input\_ingress\_load\_balancer\_ip) | n/a | `string` | n/a | yes |
| <a name="input_instance"></a> [instance](#input\_instance) | One of beta, prod01, prod02 | `string` | n/a | yes |
| <a name="input_location"></a> [location](#input\_location) | One of westeurope, northeurope | `string` | n/a | yes |
| <a name="input_location_itn"></a> [location\_itn](#input\_location\_itn) | Default italynorth | `string` | n/a | yes |
| <a name="input_location_short"></a> [location\_short](#input\_location\_short) | One of wue, neu | `string` | n/a | yes |
| <a name="input_location_short_itn"></a> [location\_short\_itn](#input\_location\_short\_itn) | Default itn | `string` | n/a | yes |
| <a name="input_log_analytics_workspace_name"></a> [log\_analytics\_workspace\_name](#input\_log\_analytics\_workspace\_name) | Specifies the name of the Log Analytics Workspace. | `string` | n/a | yes |
| <a name="input_log_analytics_workspace_resource_group_name"></a> [log\_analytics\_workspace\_resource\_group\_name](#input\_log\_analytics\_workspace\_resource\_group\_name) | The name of the resource group in which the Log Analytics workspace is located in. | `string` | n/a | yes |
| <a name="input_monitor_resource_group_name"></a> [monitor\_resource\_group\_name](#input\_monitor\_resource\_group\_name) | Monitor resource group name | `string` | n/a | yes |
| <a name="input_prefix"></a> [prefix](#input\_prefix) | n/a | `string` | n/a | yes |
| <a name="input_qi_storage_params"></a> [qi\_storage\_params](#input\_qi\_storage\_params) | Azure storage DB params for qi function. | <pre>object({<br/>    enabled                       = bool,<br/>    kind                          = string,<br/>    tier                          = string,<br/>    account_replication_type      = string,<br/>    advanced_threat_protection    = bool,<br/>    retention_days                = number,<br/>    public_network_access_enabled = bool,<br/>    access_tier                   = string<br/>  })</pre> | <pre>{<br/>  "access_tier": "Hot",<br/>  "account_replication_type": "LRS",<br/>  "advanced_threat_protection": true,<br/>  "enabled": false,<br/>  "kind": "StorageV2",<br/>  "public_network_access_enabled": false,<br/>  "retention_days": 7,<br/>  "tier": "Standard"<br/>}</pre> | no |

## Outputs

No outputs.
<!-- END_TF_DOCS -->
