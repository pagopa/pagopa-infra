<!-- markdownlint-disable -->
<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_azuread"></a> [azuread](#requirement\_azuread) | <= 3.0.2 |
| <a name="requirement_azurerm"></a> [azurerm](#requirement\_azurerm) | = 3.116.0 |
| <a name="requirement_null"></a> [null](#requirement\_null) | <= 3.3.2 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module___v3__"></a> [\_\_v3\_\_](#module\_\_\_v3\_\_) | git::https://github.com/pagopa/terraform-azurerm-v3 | 179dddb9c85e412da5e807b430322155f30aeda5 |
| <a name="module_bopagopa_cosmosdb_mongo_account"></a> [bopagopa\_cosmosdb\_mongo\_account](#module\_bopagopa\_cosmosdb\_mongo\_account) | ./.terraform/modules/__v3__/cosmosdb_account | n/a |
| <a name="module_bopagopa_cosmosdb_mongodb_snet"></a> [bopagopa\_cosmosdb\_mongodb\_snet](#module\_bopagopa\_cosmosdb\_mongodb\_snet) | ./.terraform/modules/__v3__/subnet | n/a |
| <a name="module_identity_cd_01"></a> [identity\_cd\_01](#module\_identity\_cd\_01) | ./.terraform/modules/__v3__/github_federated_identity | n/a |
| <a name="module_identity_pr_01"></a> [identity\_pr\_01](#module\_identity\_pr\_01) | github.com/pagopa/terraform-azurerm-v3//github_federated_identity | v8.18.0 |
| <a name="module_mongdb_collection_brokeribans"></a> [mongdb\_collection\_brokeribans](#module\_mongdb\_collection\_brokeribans) | ./.terraform/modules/__v3__/cosmosdb_mongodb_collection | n/a |
| <a name="module_mongdb_collection_brokerinstitutions"></a> [mongdb\_collection\_brokerinstitutions](#module\_mongdb\_collection\_brokerinstitutions) | ./.terraform/modules/__v3__/cosmosdb_mongodb_collection | n/a |
| <a name="module_mongdb_collection_iban_deletion_requests"></a> [mongdb\_collection\_iban\_deletion\_requests](#module\_mongdb\_collection\_iban\_deletion\_requests) | ./.terraform/modules/__v3__/cosmosdb_mongodb_collection | n/a |
| <a name="module_mongdb_collection_maintenance"></a> [mongdb\_collection\_maintenance](#module\_mongdb\_collection\_maintenance) | ./.terraform/modules/__v3__/cosmosdb_mongodb_collection | n/a |
| <a name="module_mongdb_collection_products"></a> [mongdb\_collection\_products](#module\_mongdb\_collection\_products) | ./.terraform/modules/__v3__/cosmosdb_mongodb_collection | n/a |
| <a name="module_tag_config"></a> [tag\_config](#module\_tag\_config) | ../../tag_config | n/a |
| <a name="module_workload_identity"></a> [workload\_identity](#module\_workload\_identity) | ./.terraform/modules/__v3__/kubernetes_workload_identity_init | n/a |

## Resources

| Name | Type |
|------|------|
| [azuread_application.selfcare](https://registry.terraform.io/providers/hashicorp/azuread/latest/docs/resources/application) | resource |
| [azuread_application_password.selfcare](https://registry.terraform.io/providers/hashicorp/azuread/latest/docs/resources/application_password) | resource |
| [azuread_service_principal.selfcare](https://registry.terraform.io/providers/hashicorp/azuread/latest/docs/resources/service_principal) | resource |
| [azurerm_app_configuration.selfcare_appconf](https://registry.terraform.io/providers/hashicorp/azurerm/3.116.0/docs/resources/app_configuration) | resource |
| [azurerm_app_configuration_feature.commission_bundles_flag](https://registry.terraform.io/providers/hashicorp/azurerm/3.116.0/docs/resources/app_configuration_feature) | resource |
| [azurerm_app_configuration_feature.commission_bundles_private_flag](https://registry.terraform.io/providers/hashicorp/azurerm/3.116.0/docs/resources/app_configuration_feature) | resource |
| [azurerm_app_configuration_feature.commission_bundles_public_flag](https://registry.terraform.io/providers/hashicorp/azurerm/3.116.0/docs/resources/app_configuration_feature) | resource |
| [azurerm_app_configuration_feature.delegations_list_flag](https://registry.terraform.io/providers/hashicorp/azurerm/3.116.0/docs/resources/app_configuration_feature) | resource |
| [azurerm_app_configuration_feature.is_operation_flag](https://registry.terraform.io/providers/hashicorp/azurerm/3.116.0/docs/resources/app_configuration_feature) | resource |
| [azurerm_app_configuration_feature.maintenance_banner_flag](https://registry.terraform.io/providers/hashicorp/azurerm/3.116.0/docs/resources/app_configuration_feature) | resource |
| [azurerm_app_configuration_feature.maintenance_flag](https://registry.terraform.io/providers/hashicorp/azurerm/3.116.0/docs/resources/app_configuration_feature) | resource |
| [azurerm_app_configuration_feature.payment_notices_flag](https://registry.terraform.io/providers/hashicorp/azurerm/3.116.0/docs/resources/app_configuration_feature) | resource |
| [azurerm_app_configuration_feature.payments_receipts_flag](https://registry.terraform.io/providers/hashicorp/azurerm/3.116.0/docs/resources/app_configuration_feature) | resource |
| [azurerm_app_configuration_feature.quicksight_dashboard_flag](https://registry.terraform.io/providers/hashicorp/azurerm/3.116.0/docs/resources/app_configuration_feature) | resource |
| [azurerm_app_configuration_feature.quicksight_product_free_trial](https://registry.terraform.io/providers/hashicorp/azurerm/3.116.0/docs/resources/app_configuration_feature) | resource |
| [azurerm_app_configuration_feature.station-odp-service](https://registry.terraform.io/providers/hashicorp/azurerm/3.116.0/docs/resources/app_configuration_feature) | resource |
| [azurerm_app_configuration_feature.station-rest-section](https://registry.terraform.io/providers/hashicorp/azurerm/3.116.0/docs/resources/app_configuration_feature) | resource |
| [azurerm_app_configuration_feature.station_maintenances_flag](https://registry.terraform.io/providers/hashicorp/azurerm/3.116.0/docs/resources/app_configuration_feature) | resource |
| [azurerm_app_configuration_feature.test_stations_flag](https://registry.terraform.io/providers/hashicorp/azurerm/3.116.0/docs/resources/app_configuration_feature) | resource |
| [azurerm_cosmosdb_mongo_database.pagopa_backoffice](https://registry.terraform.io/providers/hashicorp/azurerm/3.116.0/docs/resources/cosmosdb_mongo_database) | resource |
| [azurerm_key_vault_access_policy.gha_iac_managed_identities](https://registry.terraform.io/providers/hashicorp/azurerm/3.116.0/docs/resources/key_vault_access_policy) | resource |
| [azurerm_key_vault_access_policy.gha_pr_iac_managed_identities](https://registry.terraform.io/providers/hashicorp/azurerm/3.116.0/docs/resources/key_vault_access_policy) | resource |
| [azurerm_key_vault_secret.ai_connection_string](https://registry.terraform.io/providers/hashicorp/azurerm/3.116.0/docs/resources/key_vault_secret) | resource |
| [azurerm_key_vault_secret.cosmodb_mongo_bopagopa_connection_string](https://registry.terraform.io/providers/hashicorp/azurerm/3.116.0/docs/resources/key_vault_secret) | resource |
| [azurerm_key_vault_secret.cosmodb_mongo_bopagopa_key](https://registry.terraform.io/providers/hashicorp/azurerm/3.116.0/docs/resources/key_vault_secret) | resource |
| [azurerm_key_vault_secret.selfcare_service_principal_client_id](https://registry.terraform.io/providers/hashicorp/azurerm/3.116.0/docs/resources/key_vault_secret) | resource |
| [azurerm_key_vault_secret.selfcare_service_principal_client_secret](https://registry.terraform.io/providers/hashicorp/azurerm/3.116.0/docs/resources/key_vault_secret) | resource |
| [azurerm_management_lock.mongodb_pagopa_backoffice](https://registry.terraform.io/providers/hashicorp/azurerm/3.116.0/docs/resources/management_lock) | resource |
| [azurerm_private_dns_a_record.ingress](https://registry.terraform.io/providers/hashicorp/azurerm/3.116.0/docs/resources/private_dns_a_record) | resource |
| [azurerm_resource_group.bopagopa_rg](https://registry.terraform.io/providers/hashicorp/azurerm/3.116.0/docs/resources/resource_group) | resource |
| [azurerm_role_assignment.selfcare_apim_contributor](https://registry.terraform.io/providers/hashicorp/azurerm/3.116.0/docs/resources/role_assignment) | resource |
| [azurerm_role_assignment.selfcare_appconf_dataowner](https://registry.terraform.io/providers/hashicorp/azurerm/3.116.0/docs/resources/role_assignment) | resource |
| [azurerm_role_assignment.selfcare_appconf_dataowner_sp](https://registry.terraform.io/providers/hashicorp/azurerm/3.116.0/docs/resources/role_assignment) | resource |
| [null_resource.github_runner_app_permissions_to_namespace_cd_01](https://registry.terraform.io/providers/hashicorp/null/latest/docs/resources/resource) | resource |
| [time_rotating.selfcare_application](https://registry.terraform.io/providers/hashicorp/time/latest/docs/resources/rotating) | resource |
| [azurerm_api_management.apim](https://registry.terraform.io/providers/hashicorp/azurerm/3.116.0/docs/data-sources/api_management) | data source |
| [azurerm_application_insights.application_insights](https://registry.terraform.io/providers/hashicorp/azurerm/3.116.0/docs/data-sources/application_insights) | data source |
| [azurerm_client_config.current](https://registry.terraform.io/providers/hashicorp/azurerm/3.116.0/docs/data-sources/client_config) | data source |
| [azurerm_key_vault.key_vault](https://registry.terraform.io/providers/hashicorp/azurerm/3.116.0/docs/data-sources/key_vault) | data source |
| [azurerm_kubernetes_cluster.aks](https://registry.terraform.io/providers/hashicorp/azurerm/3.116.0/docs/data-sources/kubernetes_cluster) | data source |
| [azurerm_log_analytics_workspace.log_analytics](https://registry.terraform.io/providers/hashicorp/azurerm/3.116.0/docs/data-sources/log_analytics_workspace) | data source |
| [azurerm_monitor_action_group.email](https://registry.terraform.io/providers/hashicorp/azurerm/3.116.0/docs/data-sources/monitor_action_group) | data source |
| [azurerm_monitor_action_group.slack](https://registry.terraform.io/providers/hashicorp/azurerm/3.116.0/docs/data-sources/monitor_action_group) | data source |
| [azurerm_private_dns_zone.cosmos](https://registry.terraform.io/providers/hashicorp/azurerm/3.116.0/docs/data-sources/private_dns_zone) | data source |
| [azurerm_private_dns_zone.internal](https://registry.terraform.io/providers/hashicorp/azurerm/3.116.0/docs/data-sources/private_dns_zone) | data source |
| [azurerm_resource_group.identity_rg](https://registry.terraform.io/providers/hashicorp/azurerm/3.116.0/docs/data-sources/resource_group) | data source |
| [azurerm_resource_group.monitor_rg](https://registry.terraform.io/providers/hashicorp/azurerm/3.116.0/docs/data-sources/resource_group) | data source |
| [azurerm_resource_group.sec_rg](https://registry.terraform.io/providers/hashicorp/azurerm/3.116.0/docs/data-sources/resource_group) | data source |
| [azurerm_subnet.aks_subnet](https://registry.terraform.io/providers/hashicorp/azurerm/3.116.0/docs/data-sources/subnet) | data source |
| [azurerm_subscription.current](https://registry.terraform.io/providers/hashicorp/azurerm/3.116.0/docs/data-sources/subscription) | data source |
| [azurerm_virtual_network.vnet](https://registry.terraform.io/providers/hashicorp/azurerm/3.116.0/docs/data-sources/virtual_network) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_application_insights_name"></a> [application\_insights\_name](#input\_application\_insights\_name) | Specifies the name of the Application Insights. | `string` | n/a | yes |
| <a name="input_bopagopa_datastore_cosmos_db_params"></a> [bopagopa\_datastore\_cosmos\_db\_params](#input\_bopagopa\_datastore\_cosmos\_db\_params) | n/a | <pre>object({<br/>    kind           = string<br/>    capabilities   = list(string)<br/>    offer_type     = string<br/>    server_version = string<br/>    consistency_policy = object({<br/>      consistency_level       = string<br/>      max_interval_in_seconds = number<br/>      max_staleness_prefix    = number<br/>    })<br/>    main_geo_location_zone_redundant = bool<br/>    enable_free_tier                 = bool<br/>    additional_geo_locations = list(object({<br/>      location          = string<br/>      failover_priority = number<br/>      zone_redundant    = bool<br/>    }))<br/>    private_endpoint_enabled          = bool<br/>    public_network_access_enabled     = bool<br/>    is_virtual_network_filter_enabled = bool<br/>    backup_continuous_enabled         = bool<br/>    container_default_ttl             = number<br/>  })</pre> | n/a | yes |
| <a name="input_cidr_subnet_cosmosdb_mongodb"></a> [cidr\_subnet\_cosmosdb\_mongodb](#input\_cidr\_subnet\_cosmosdb\_mongodb) | Cosmos DB address space | `list(string)` | `null` | no |
| <a name="input_cosmosdb_mongodb_enable_autoscaling"></a> [cosmosdb\_mongodb\_enable\_autoscaling](#input\_cosmosdb\_mongodb\_enable\_autoscaling) | It will enable autoscaling mode. If true, cosmosdb\_mongodb\_throughput must be unset | `bool` | `true` | no |
| <a name="input_cosmosdb_mongodb_extra_capabilities"></a> [cosmosdb\_mongodb\_extra\_capabilities](#input\_cosmosdb\_mongodb\_extra\_capabilities) | Enable cosmosdb extra capabilities | `list(string)` | `[]` | no |
| <a name="input_cosmosdb_mongodb_max_throughput"></a> [cosmosdb\_mongodb\_max\_throughput](#input\_cosmosdb\_mongodb\_max\_throughput) | The maximum throughput of the MongoDB database (RU/s). Must be between 4,000 and 1,000,000. Must be set in increments of 1,000. Conflicts with throughput | `number` | `5000` | no |
| <a name="input_cosmosdb_mongodb_throughput"></a> [cosmosdb\_mongodb\_throughput](#input\_cosmosdb\_mongodb\_throughput) | The throughput of the MongoDB database (RU/s). Must be set in increments of 100. The minimum value is 400. This must be set upon database creation otherwise it cannot be updated without a manual terraform destroy-apply. | `number` | `400` | no |
| <a name="input_dns_zone_internal_prefix"></a> [dns\_zone\_internal\_prefix](#input\_dns\_zone\_internal\_prefix) | The dns subdomain. | `string` | `null` | no |
| <a name="input_domain"></a> [domain](#input\_domain) | n/a | `string` | n/a | yes |
| <a name="input_enable_iac_pipeline"></a> [enable\_iac\_pipeline](#input\_enable\_iac\_pipeline) | If true create the key vault policy to allow used by azure devops iac pipelines. | `bool` | `false` | no |
| <a name="input_env"></a> [env](#input\_env) | n/a | `string` | n/a | yes |
| <a name="input_env_capital"></a> [env\_capital](#input\_env\_capital) | n/a | `string` | n/a | yes |
| <a name="input_env_short"></a> [env\_short](#input\_env\_short) | n/a | `string` | n/a | yes |
| <a name="input_external_domain"></a> [external\_domain](#input\_external\_domain) | Domain for delegation | `string` | `null` | no |
| <a name="input_ingress_load_balancer_ip"></a> [ingress\_load\_balancer\_ip](#input\_ingress\_load\_balancer\_ip) | n/a | `string` | n/a | yes |
| <a name="input_instance"></a> [instance](#input\_instance) | One of beta, prod01, prod02 | `string` | n/a | yes |
| <a name="input_k8s_kube_config_path_prefix"></a> [k8s\_kube\_config\_path\_prefix](#input\_k8s\_kube\_config\_path\_prefix) | n/a | `string` | `"~/.kube"` | no |
| <a name="input_location"></a> [location](#input\_location) | One of westeurope, northeurope | `string` | n/a | yes |
| <a name="input_location_short"></a> [location\_short](#input\_location\_short) | One of wue, neu | `string` | n/a | yes |
| <a name="input_log_analytics_workspace_name"></a> [log\_analytics\_workspace\_name](#input\_log\_analytics\_workspace\_name) | Specifies the name of the Log Analytics Workspace. | `string` | n/a | yes |
| <a name="input_log_analytics_workspace_resource_group_name"></a> [log\_analytics\_workspace\_resource\_group\_name](#input\_log\_analytics\_workspace\_resource\_group\_name) | The name of the resource group in which the Log Analytics workspace is located in. | `string` | n/a | yes |
| <a name="input_monitor_resource_group_name"></a> [monitor\_resource\_group\_name](#input\_monitor\_resource\_group\_name) | Monitor resource group name | `string` | n/a | yes |
| <a name="input_prefix"></a> [prefix](#input\_prefix) | n/a | `string` | n/a | yes |

## Outputs

No outputs.
<!-- END_TF_DOCS -->
