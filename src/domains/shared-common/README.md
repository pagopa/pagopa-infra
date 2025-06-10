## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_azuread"></a> [azuread](#requirement\_azuread) | = 2.21.0 |
| <a name="requirement_azurerm"></a> [azurerm](#requirement\_azurerm) | <= 3.84.0 |
| <a name="requirement_github"></a> [github](#requirement\_github) | 5.18.3 |
| <a name="requirement_null"></a> [null](#requirement\_null) | = 3.1.1 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_azuread"></a> [azuread](#provider\_azuread) | 2.21.0 |
| <a name="provider_azurerm"></a> [azurerm](#provider\_azurerm) | 3.84.0 |
| <a name="provider_null"></a> [null](#provider\_null) | 3.1.1 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_authorizer_cosmosdb_account"></a> [authorizer\_cosmosdb\_account](#module\_authorizer\_cosmosdb\_account) | git::https://github.com/pagopa/terraform-azurerm-v3.git//cosmosdb_account | v7.60.0 |
| <a name="module_authorizer_cosmosdb_database"></a> [authorizer\_cosmosdb\_database](#module\_authorizer\_cosmosdb\_database) | git::https://github.com/pagopa/terraform-azurerm-v3.git//cosmosdb_sql_database | v7.60.0 |
| <a name="module_authorizer_cosmosdb_snet"></a> [authorizer\_cosmosdb\_snet](#module\_authorizer\_cosmosdb\_snet) | git::https://github.com/pagopa/terraform-azurerm-v3.git//subnet | v7.60.0 |
| <a name="module_github_runner_environment"></a> [github\_runner\_environment](#module\_github\_runner\_environment) | git::https://github.com/pagopa/terraform-azurerm-v3.git//container_app_environment | v7.60.0 |
| <a name="module_identity_cd_01"></a> [identity\_cd\_01](#module\_identity\_cd\_01) | github.com/pagopa/terraform-azurerm-v3//github_federated_identity | v7.60.0 |
| <a name="module_iuvgenerator_cosmosdb_account"></a> [iuvgenerator\_cosmosdb\_account](#module\_iuvgenerator\_cosmosdb\_account) | git::https://github.com/pagopa/terraform-azurerm-v3.git//cosmosdb_account | v7.60.0 |
| <a name="module_iuvgenerator_cosmosdb_snet"></a> [iuvgenerator\_cosmosdb\_snet](#module\_iuvgenerator\_cosmosdb\_snet) | git::https://github.com/pagopa/terraform-azurerm-v3.git//subnet | v7.60.0 |
| <a name="module_key_vault"></a> [key\_vault](#module\_key\_vault) | git::https://github.com/pagopa/terraform-azurerm-v3.git//key_vault | v7.60.0 |
| <a name="module_poc_reporting_enrollment_sa"></a> [poc\_reporting\_enrollment\_sa](#module\_poc\_reporting\_enrollment\_sa) | git::https://github.com/pagopa/terraform-azurerm-v3.git//storage_account | v7.60.0 |
| <a name="module_taxonomy_sa"></a> [taxonomy\_sa](#module\_taxonomy\_sa) | git::https://github.com/pagopa/terraform-azurerm-v3.git//storage_account | v7.60.0 |
| <a name="module_taxonomy_storage_snet"></a> [taxonomy\_storage\_snet](#module\_taxonomy\_storage\_snet) | git::https://github.com/pagopa/terraform-azurerm-v3.git//subnet | v7.60.0 |
| <a name="module_test_data_sa"></a> [test\_data\_sa](#module\_test\_data\_sa) | git::https://github.com/pagopa/terraform-azurerm-v3.git//storage_account | v7.60.0 |

## Resources

| Name | Type |
|------|------|
| [azurerm_cosmosdb_sql_container.skeydomains_container](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/cosmosdb_sql_container) | resource |
| [azurerm_cosmosdb_table.iuvgenerator_cosmosdb_tables](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/cosmosdb_table) | resource |
| [azurerm_key_vault_access_policy.ad_admin_group_policy](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/key_vault_access_policy) | resource |
| [azurerm_key_vault_access_policy.adgroup_developers_policy](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/key_vault_access_policy) | resource |
| [azurerm_key_vault_access_policy.adgroup_externals_policy](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/key_vault_access_policy) | resource |
| [azurerm_key_vault_access_policy.azdevops_iac_legacy_policies](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/key_vault_access_policy) | resource |
| [azurerm_key_vault_access_policy.azdevops_iac_managed_identities](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/key_vault_access_policy) | resource |
| [azurerm_key_vault_access_policy.azdevops_platform_iac_policy](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/key_vault_access_policy) | resource |
| [azurerm_key_vault_access_policy.gha_iac_managed_identities](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/key_vault_access_policy) | resource |
| [azurerm_key_vault_secret.ai_connection_string](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/key_vault_secret) | resource |
| [azurerm_key_vault_secret.apiconfig_selfcare_integration_subkey](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/key_vault_secret) | resource |
| [azurerm_key_vault_secret.apiconfig_selfcare_integration_url](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/key_vault_secret) | resource |
| [azurerm_key_vault_secret.authorizer_cosmos_connection_string](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/key_vault_secret) | resource |
| [azurerm_key_vault_secret.authorizer_cosmos_key](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/key_vault_secret) | resource |
| [azurerm_key_vault_secret.authorizer_cosmos_uri](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/key_vault_secret) | resource |
| [azurerm_key_vault_secret.authorizer_integrationtest_external_subkey](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/key_vault_secret) | resource |
| [azurerm_key_vault_secret.authorizer_integrationtest_invalid_subkey](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/key_vault_secret) | resource |
| [azurerm_key_vault_secret.authorizer_integrationtest_valid_subkey](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/key_vault_secret) | resource |
| [azurerm_key_vault_secret.authorizer_refresh_configuration_url](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/key_vault_secret) | resource |
| [azurerm_key_vault_secret.elastic_apm_secret_token](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/key_vault_secret) | resource |
| [azurerm_key_vault_secret.elastic_otel_token_header](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/key_vault_secret) | resource |
| [azurerm_key_vault_secret.iuv_generator_cosmos_connection_string](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/key_vault_secret) | resource |
| [azurerm_key_vault_secret.nodo5_slack_webhook_url](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/key_vault_secret) | resource |
| [azurerm_key_vault_secret.pdf_engine_node_perf_test_subkey](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/key_vault_secret) | resource |
| [azurerm_key_vault_secret.pdf_engine_node_subkey](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/key_vault_secret) | resource |
| [azurerm_key_vault_secret.pdf_engine_perf_test_subkey](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/key_vault_secret) | resource |
| [azurerm_key_vault_secret.poc_reporting_enrollment_subscription_key](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/key_vault_secret) | resource |
| [azurerm_key_vault_secret.redis_hostname](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/key_vault_secret) | resource |
| [azurerm_key_vault_secret.redis_password](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/key_vault_secret) | resource |
| [azurerm_key_vault_secret.storage_connection_string](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/key_vault_secret) | resource |
| [azurerm_private_dns_a_record.ingress](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/private_dns_a_record) | resource |
| [azurerm_private_endpoint.taxonomy_blob_private_endpoint](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/private_endpoint) | resource |
| [azurerm_resource_group.github_runner_rg](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/resource_group) | resource |
| [azurerm_resource_group.sec_rg](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/resource_group) | resource |
| [azurerm_resource_group.shared_rg](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/resource_group) | resource |
| [azurerm_resource_group.taxonomy_rg](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/resource_group) | resource |
| [azurerm_resource_group.test_data_rg](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/resource_group) | resource |
| [azurerm_storage_container.taxonomy_input_blob_file](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/storage_container) | resource |
| [azurerm_storage_container.taxonomy_output_blob_file](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/storage_container) | resource |
| [azurerm_storage_table.poc_reporting_enrollment_table](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/storage_table) | resource |
| [azurerm_subnet.github_runner_snet](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/subnet) | resource |
| [null_resource.github_runner_app_permissions_to_namespace_cd_01](https://registry.terraform.io/providers/hashicorp/null/3.1.1/docs/resources/resource) | resource |
| [azuread_group.adgroup_admin](https://registry.terraform.io/providers/hashicorp/azuread/2.21.0/docs/data-sources/group) | data source |
| [azuread_group.adgroup_developers](https://registry.terraform.io/providers/hashicorp/azuread/2.21.0/docs/data-sources/group) | data source |
| [azuread_group.adgroup_externals](https://registry.terraform.io/providers/hashicorp/azuread/2.21.0/docs/data-sources/group) | data source |
| [azuread_group.adgroup_security](https://registry.terraform.io/providers/hashicorp/azuread/2.21.0/docs/data-sources/group) | data source |
| [azuread_service_principal.iac_deploy_legacy](https://registry.terraform.io/providers/hashicorp/azuread/2.21.0/docs/data-sources/service_principal) | data source |
| [azuread_service_principal.iac_plan_legacy](https://registry.terraform.io/providers/hashicorp/azuread/2.21.0/docs/data-sources/service_principal) | data source |
| [azuread_service_principal.platform_iac_sp](https://registry.terraform.io/providers/hashicorp/azuread/2.21.0/docs/data-sources/service_principal) | data source |
| [azurerm_application_insights.application_insights](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/application_insights) | data source |
| [azurerm_client_config.current](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/client_config) | data source |
| [azurerm_kubernetes_cluster.aks](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/kubernetes_cluster) | data source |
| [azurerm_log_analytics_workspace.log_analytics](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/log_analytics_workspace) | data source |
| [azurerm_monitor_action_group.email](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/monitor_action_group) | data source |
| [azurerm_monitor_action_group.slack](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/monitor_action_group) | data source |
| [azurerm_private_dns_zone.cosmos](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/private_dns_zone) | data source |
| [azurerm_private_dns_zone.internal](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/private_dns_zone) | data source |
| [azurerm_private_dns_zone.privatelink_blob_azure_com](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/private_dns_zone) | data source |
| [azurerm_private_dns_zone.storage](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/private_dns_zone) | data source |
| [azurerm_redis_cache.redis_cache](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/redis_cache) | data source |
| [azurerm_redis_cache.redis_cache_ha](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/redis_cache) | data source |
| [azurerm_resource_group.identity_rg](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/resource_group) | data source |
| [azurerm_resource_group.monitor_rg](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/resource_group) | data source |
| [azurerm_subnet.aks_subnet](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/subnet) | data source |
| [azurerm_subscription.current](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/subscription) | data source |
| [azurerm_user_assigned_identity.iac_federated_azdo](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/user_assigned_identity) | data source |
| [azurerm_virtual_network.vnet](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/virtual_network) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_cidr_subnet_taxonomy_storage_account"></a> [cidr\_subnet\_taxonomy\_storage\_account](#input\_cidr\_subnet\_taxonomy\_storage\_account) | Storage account network address space. | `list(string)` | n/a | yes |
| <a name="input_cosmos_authorizer_db_params"></a> [cosmos\_authorizer\_db\_params](#input\_cosmos\_authorizer\_db\_params) | n/a | <pre>object({<br>    kind           = string<br>    capabilities   = list(string)<br>    offer_type     = string<br>    server_version = string<br>    consistency_policy = object({<br>      consistency_level       = string<br>      max_interval_in_seconds = number<br>      max_staleness_prefix    = number<br>    })<br>    main_geo_location_zone_redundant = bool<br>    enable_free_tier                 = bool<br>    additional_geo_locations = list(object({<br>      location          = string<br>      failover_priority = number<br>      zone_redundant    = bool<br>    }))<br>    private_endpoint_enabled          = bool<br>    public_network_access_enabled     = bool<br>    is_virtual_network_filter_enabled = bool<br>    backup_continuous_enabled         = bool<br>  })</pre> | n/a | yes |
| <a name="input_cosmos_iuvgenerator_db_params"></a> [cosmos\_iuvgenerator\_db\_params](#input\_cosmos\_iuvgenerator\_db\_params) | n/a | <pre>object({<br>    kind           = string<br>    capabilities   = list(string)<br>    offer_type     = string<br>    server_version = string<br>    consistency_policy = object({<br>      consistency_level       = string<br>      max_interval_in_seconds = number<br>      max_staleness_prefix    = number<br>    })<br>    main_geo_location_zone_redundant = bool<br>    enable_free_tier                 = bool<br>    additional_geo_locations = list(object({<br>      location          = string<br>      failover_priority = number<br>      zone_redundant    = bool<br>    }))<br>    private_endpoint_enabled          = bool<br>    public_network_access_enabled     = bool<br>    is_virtual_network_filter_enabled = bool<br>    backup_continuous_enabled         = bool<br>  })</pre> | n/a | yes |
| <a name="input_domain"></a> [domain](#input\_domain) | n/a | `string` | n/a | yes |
| <a name="input_env"></a> [env](#input\_env) | n/a | `string` | n/a | yes |
| <a name="input_env_short"></a> [env\_short](#input\_env\_short) | n/a | `string` | n/a | yes |
| <a name="input_ingress_load_balancer_ip"></a> [ingress\_load\_balancer\_ip](#input\_ingress\_load\_balancer\_ip) | n/a | `string` | n/a | yes |
| <a name="input_instance"></a> [instance](#input\_instance) | One of beta, prod01, prod02 | `string` | n/a | yes |
| <a name="input_location"></a> [location](#input\_location) | One of westeurope, northeurope | `string` | n/a | yes |
| <a name="input_location_short"></a> [location\_short](#input\_location\_short) | One of wue, neu | `string` | n/a | yes |
| <a name="input_log_analytics_workspace_name"></a> [log\_analytics\_workspace\_name](#input\_log\_analytics\_workspace\_name) | Specifies the name of the Log Analytics Workspace. | `string` | n/a | yes |
| <a name="input_log_analytics_workspace_resource_group_name"></a> [log\_analytics\_workspace\_resource\_group\_name](#input\_log\_analytics\_workspace\_resource\_group\_name) | The name of the resource group in which the Log Analytics workspace is located in. | `string` | n/a | yes |
| <a name="input_monitor_resource_group_name"></a> [monitor\_resource\_group\_name](#input\_monitor\_resource\_group\_name) | Monitor resource group name | `string` | n/a | yes |
| <a name="input_prefix"></a> [prefix](#input\_prefix) | n/a | `string` | n/a | yes |
| <a name="input_redis_ha_enabled"></a> [redis\_ha\_enabled](#input\_redis\_ha\_enabled) | (Required) If true, enables the usage of HA redis instance | `bool` | n/a | yes |
| <a name="input_taxonomy_storage_account"></a> [taxonomy\_storage\_account](#input\_taxonomy\_storage\_account) | n/a | <pre>object({<br>    account_kind                  = string<br>    account_tier                  = string<br>    account_replication_type      = string<br>    advanced_threat_protection    = bool<br>    blob_versioning_enabled       = bool<br>    public_network_access_enabled = bool<br>    blob_delete_retention_days    = number<br>    enable_low_availability_alert = bool<br>    backup_enabled                = optional(bool, false)<br>    backup_retention              = optional(number, 0)<br>  })</pre> | n/a | yes |
| <a name="input_cidr_subnet_authorizer_cosmosdb"></a> [cidr\_subnet\_authorizer\_cosmosdb](#input\_cidr\_subnet\_authorizer\_cosmosdb) | Cosmos DB address space | `list(string)` | `null` | no |
| <a name="input_cidr_subnet_iuvgenerator_cosmosdb"></a> [cidr\_subnet\_iuvgenerator\_cosmosdb](#input\_cidr\_subnet\_iuvgenerator\_cosmosdb) | Cosmos DB address space | `list(string)` | `null` | no |
| <a name="input_cidr_subnet_loadtest_agent"></a> [cidr\_subnet\_loadtest\_agent](#input\_cidr\_subnet\_loadtest\_agent) | LoadTest Agent Pool address space | `list(string)` | `null` | no |
| <a name="input_cidr_subnet_test_data_storage_account"></a> [cidr\_subnet\_test\_data\_storage\_account](#input\_cidr\_subnet\_test\_data\_storage\_account) | Storage account network address space. | `list(string)` | `null` | no |
| <a name="input_dns_zone_internal_prefix"></a> [dns\_zone\_internal\_prefix](#input\_dns\_zone\_internal\_prefix) | The dns subdomain. | `string` | `null` | no |
| <a name="input_external_domain"></a> [external\_domain](#input\_external\_domain) | Domain for delegation | `string` | `null` | no |
| <a name="input_github_repository_environment"></a> [github\_repository\_environment](#input\_github\_repository\_environment) | GitHub Continuous Integration roles | <pre>object({<br>    protected_branches     = bool<br>    custom_branch_policies = bool<br>    reviewers_teams        = list(string)<br>  })</pre> | <pre>{<br>  "custom_branch_policies": true,<br>  "protected_branches": false,<br>  "reviewers_teams": [<br>    "pagopa-team-core"<br>  ]<br>}</pre> | no |
| <a name="input_github_runner"></a> [github\_runner](#input\_github\_runner) | GitHub runner variables | <pre>object({<br>    subnet_address_prefixes = list(string)<br>  })</pre> | <pre>{<br>  "subnet_address_prefixes": [<br>    "10.1.164.0/23"<br>  ]<br>}</pre> | no |
| <a name="input_k8s_kube_config_path_prefix"></a> [k8s\_kube\_config\_path\_prefix](#input\_k8s\_kube\_config\_path\_prefix) | n/a | `string` | `"~/.kube"` | no |
| <a name="input_poc_advanced_threat_protection"></a> [poc\_advanced\_threat\_protection](#input\_poc\_advanced\_threat\_protection) | Enable contract threat advanced protection | `bool` | `false` | no |
| <a name="input_poc_delete_retention_days"></a> [poc\_delete\_retention\_days](#input\_poc\_delete\_retention\_days) | Number of days to retain deleted. | `number` | `30` | no |
| <a name="input_poc_versioning"></a> [poc\_versioning](#input\_poc\_versioning) | Enable sa versioning | `bool` | `false` | no |
| <a name="input_reporting_storage_public_access_enabled"></a> [reporting\_storage\_public\_access\_enabled](#input\_reporting\_storage\_public\_access\_enabled) | (Optional) Whether the public network access is enabled? | `bool` | `true` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | n/a | `map(any)` | <pre>{<br>  "CreatedBy": "Terraform"<br>}</pre> | no |
| <a name="input_taxonomy_network_rules"></a> [taxonomy\_network\_rules](#input\_taxonomy\_network\_rules) | Network configuration of Taxonomy storage account | <pre>object({<br>    default_action             = string<br>    ip_rules                   = list(string)<br>    virtual_network_subnet_ids = list(string)<br>    bypass                     = set(string)<br>  })</pre> | `null` | no |
| <a name="input_test_data_storage_account"></a> [test\_data\_storage\_account](#input\_test\_data\_storage\_account) | n/a | <pre>object({<br>    account_kind                  = string<br>    account_tier                  = string<br>    account_replication_type      = string<br>    advanced_threat_protection    = bool<br>    blob_versioning_enabled       = bool<br>    public_network_access_enabled = bool<br>    blob_delete_retention_days    = number<br>    enable_low_availability_alert = bool<br>  })</pre> | `null` | no |

## Outputs

No outputs.
<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_azuread"></a> [azuread](#requirement\_azuread) | = 3.0.2 |
| <a name="requirement_azurerm"></a> [azurerm](#requirement\_azurerm) | >= 3.116.0 |
| <a name="requirement_github"></a> [github](#requirement\_github) | 5.18.3 |
| <a name="requirement_null"></a> [null](#requirement\_null) | <= 3.3.2 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module___v3__"></a> [\_\_v3\_\_](#module\_\_\_v3\_\_) | git::https://github.com/pagopa/terraform-azurerm-v3 | 179dddb9c85e412da5e807b430322155f30aeda5 |
| <a name="module_authorizer_cosmosdb_account"></a> [authorizer\_cosmosdb\_account](#module\_authorizer\_cosmosdb\_account) | git::https://github.com/pagopa/terraform-azurerm-v3.git//cosmosdb_account | v8.93.1 |
| <a name="module_authorizer_cosmosdb_database"></a> [authorizer\_cosmosdb\_database](#module\_authorizer\_cosmosdb\_database) | git::https://github.com/pagopa/terraform-azurerm-v3.git//cosmosdb_sql_database | v8.53.0 |
| <a name="module_authorizer_cosmosdb_snet"></a> [authorizer\_cosmosdb\_snet](#module\_authorizer\_cosmosdb\_snet) | git::https://github.com/pagopa/terraform-azurerm-v3.git//subnet | v8.53.0 |
| <a name="module_github_runner_environment"></a> [github\_runner\_environment](#module\_github\_runner\_environment) | git::https://github.com/pagopa/terraform-azurerm-v3.git//container_app_environment_v2 | v8.53.0 |
| <a name="module_github_runner_environment_italy"></a> [github\_runner\_environment\_italy](#module\_github\_runner\_environment\_italy) | git::https://github.com/pagopa/terraform-azurerm-v3.git//container_app_environment_v2 | v8.53.0 |
| <a name="module_identity_cd_01"></a> [identity\_cd\_01](#module\_identity\_cd\_01) | ./.terraform/modules/__v3__/github_federated_identity | n/a |
| <a name="module_iuvgenerator_cosmosdb_account"></a> [iuvgenerator\_cosmosdb\_account](#module\_iuvgenerator\_cosmosdb\_account) | git::https://github.com/pagopa/terraform-azurerm-v3.git//cosmosdb_account | v8.93.1 |
| <a name="module_iuvgenerator_cosmosdb_snet"></a> [iuvgenerator\_cosmosdb\_snet](#module\_iuvgenerator\_cosmosdb\_snet) | git::https://github.com/pagopa/terraform-azurerm-v3.git//subnet | v8.53.0 |
| <a name="module_key_vault"></a> [key\_vault](#module\_key\_vault) | git::https://github.com/pagopa/terraform-azurerm-v3.git//key_vault | v8.53.0 |
| <a name="module_pagopa_wallet_jwt"></a> [pagopa\_wallet\_jwt](#module\_pagopa\_wallet\_jwt) | github.com/pagopa/terraform-azurerm-v3//jwt_keys | v8.21.0 |
| <a name="module_poc_reporting_enrollment_sa"></a> [poc\_reporting\_enrollment\_sa](#module\_poc\_reporting\_enrollment\_sa) | git::https://github.com/pagopa/terraform-azurerm-v3.git//storage_account | v8.53.0 |
| <a name="module_tag_config"></a> [tag\_config](#module\_tag\_config) | ../../tag_config | n/a |
| <a name="module_taxonomy_sa"></a> [taxonomy\_sa](#module\_taxonomy\_sa) | git::https://github.com/pagopa/terraform-azurerm-v3.git//storage_account | v8.53.0 |
| <a name="module_taxonomy_storage_snet"></a> [taxonomy\_storage\_snet](#module\_taxonomy\_storage\_snet) | git::https://github.com/pagopa/terraform-azurerm-v3.git//subnet | v8.53.0 |
| <a name="module_test_data_sa"></a> [test\_data\_sa](#module\_test\_data\_sa) | git::https://github.com/pagopa/terraform-azurerm-v3.git//storage_account | v8.53.0 |
| <a name="module_workload_identity"></a> [workload\_identity](#module\_workload\_identity) | ./.terraform/modules/__v3__/kubernetes_workload_identity_init | n/a |

## Resources

| Name | Type |
|------|------|
| [azurerm_cosmosdb_sql_container.skeydomains_container](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/cosmosdb_sql_container) | resource |
| [azurerm_cosmosdb_table.iuvgenerator_cosmosdb_tables](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/cosmosdb_table) | resource |
| [azurerm_key_vault_access_policy.ad_admin_group_policy](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/key_vault_access_policy) | resource |
| [azurerm_key_vault_access_policy.adgroup_developers_policy](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/key_vault_access_policy) | resource |
| [azurerm_key_vault_access_policy.adgroup_externals_policy](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/key_vault_access_policy) | resource |
| [azurerm_key_vault_access_policy.azdevops_iac_legacy_policies](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/key_vault_access_policy) | resource |
| [azurerm_key_vault_access_policy.azdevops_iac_managed_identities](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/key_vault_access_policy) | resource |
| [azurerm_key_vault_access_policy.azdevops_platform_iac_policy](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/key_vault_access_policy) | resource |
| [azurerm_key_vault_access_policy.gha_iac_managed_identities](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/key_vault_access_policy) | resource |
| [azurerm_key_vault_secret.ai_connection_string](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/key_vault_secret) | resource |
| [azurerm_key_vault_secret.apiconfig_selfcare_integration_subkey](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/key_vault_secret) | resource |
| [azurerm_key_vault_secret.apiconfig_selfcare_integration_url](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/key_vault_secret) | resource |
| [azurerm_key_vault_secret.authorizer_cosmos_connection_string](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/key_vault_secret) | resource |
| [azurerm_key_vault_secret.authorizer_cosmos_key](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/key_vault_secret) | resource |
| [azurerm_key_vault_secret.authorizer_cosmos_uri](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/key_vault_secret) | resource |
| [azurerm_key_vault_secret.authorizer_integrationtest_external_subkey](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/key_vault_secret) | resource |
| [azurerm_key_vault_secret.authorizer_integrationtest_invalid_subkey](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/key_vault_secret) | resource |
| [azurerm_key_vault_secret.authorizer_integrationtest_valid_subkey](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/key_vault_secret) | resource |
| [azurerm_key_vault_secret.authorizer_refresh_configuration_url](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/key_vault_secret) | resource |
| [azurerm_key_vault_secret.elastic_apm_secret_token](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/key_vault_secret) | resource |
| [azurerm_key_vault_secret.elastic_otel_token_header](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/key_vault_secret) | resource |
| [azurerm_key_vault_secret.iuv_generator_cosmos_connection_string](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/key_vault_secret) | resource |
| [azurerm_key_vault_secret.nodo5_slack_webhook_url](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/key_vault_secret) | resource |
| [azurerm_key_vault_secret.pdf_engine_node_perf_test_subkey](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/key_vault_secret) | resource |
| [azurerm_key_vault_secret.pdf_engine_node_subkey](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/key_vault_secret) | resource |
| [azurerm_key_vault_secret.pdf_engine_perf_test_subkey](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/key_vault_secret) | resource |
| [azurerm_key_vault_secret.poc_reporting_enrollment_subscription_key](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/key_vault_secret) | resource |
| [azurerm_key_vault_secret.redis_hostname](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/key_vault_secret) | resource |
| [azurerm_key_vault_secret.redis_password](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/key_vault_secret) | resource |
| [azurerm_key_vault_secret.storage_connection_string](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/key_vault_secret) | resource |
| [azurerm_key_vault_secret.wallet_session_pdv_api_key](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/key_vault_secret) | resource |
| [azurerm_monitor_action_group.slack_channel_pagopa_pagamenti_alert](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/monitor_action_group) | resource |
| [azurerm_private_dns_a_record.ingress](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/private_dns_a_record) | resource |
| [azurerm_private_endpoint.taxonomy_blob_private_endpoint](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/private_endpoint) | resource |
| [azurerm_resource_group.github_runner_rg](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/resource_group) | resource |
| [azurerm_resource_group.github_runner_rg_italy](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/resource_group) | resource |
| [azurerm_resource_group.iuvgenerator_rg](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/resource_group) | resource |
| [azurerm_resource_group.sec_rg](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/resource_group) | resource |
| [azurerm_resource_group.shared_rg](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/resource_group) | resource |
| [azurerm_resource_group.taxonomy_rg](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/resource_group) | resource |
| [azurerm_resource_group.test_data_rg](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/resource_group) | resource |
| [azurerm_storage_container.taxonomy_input_blob_file](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/storage_container) | resource |
| [azurerm_storage_container.taxonomy_output_blob_file](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/storage_container) | resource |
| [azurerm_storage_table.poc_reporting_enrollment_table](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/storage_table) | resource |
| [azurerm_subnet.github_runner_snet](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/subnet) | resource |
| [azurerm_subnet.github_runner_snet_italy](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/subnet) | resource |
| [null_resource.github_runner_app_permissions_to_namespace_cd_01](https://registry.terraform.io/providers/hashicorp/null/latest/docs/resources/resource) | resource |
| [azuread_group.adgroup_admin](https://registry.terraform.io/providers/hashicorp/azuread/3.0.2/docs/data-sources/group) | data source |
| [azuread_group.adgroup_developers](https://registry.terraform.io/providers/hashicorp/azuread/3.0.2/docs/data-sources/group) | data source |
| [azuread_group.adgroup_externals](https://registry.terraform.io/providers/hashicorp/azuread/3.0.2/docs/data-sources/group) | data source |
| [azuread_group.adgroup_security](https://registry.terraform.io/providers/hashicorp/azuread/3.0.2/docs/data-sources/group) | data source |
| [azuread_service_principal.iac_deploy_legacy](https://registry.terraform.io/providers/hashicorp/azuread/3.0.2/docs/data-sources/service_principal) | data source |
| [azuread_service_principal.iac_plan_legacy](https://registry.terraform.io/providers/hashicorp/azuread/3.0.2/docs/data-sources/service_principal) | data source |
| [azuread_service_principal.platform_iac_sp](https://registry.terraform.io/providers/hashicorp/azuread/3.0.2/docs/data-sources/service_principal) | data source |
| [azurerm_application_insights.application_insights](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/application_insights) | data source |
| [azurerm_client_config.current](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/client_config) | data source |
| [azurerm_key_vault_secret.slack_pagopa_pagamenti_alert_email](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/key_vault_secret) | data source |
| [azurerm_kubernetes_cluster.aks](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/kubernetes_cluster) | data source |
| [azurerm_log_analytics_workspace.log_analytics](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/log_analytics_workspace) | data source |
| [azurerm_monitor_action_group.email](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/monitor_action_group) | data source |
| [azurerm_monitor_action_group.slack](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/monitor_action_group) | data source |
| [azurerm_private_dns_zone.cosmos](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/private_dns_zone) | data source |
| [azurerm_private_dns_zone.cosmos_table](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/private_dns_zone) | data source |
| [azurerm_private_dns_zone.internal](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/private_dns_zone) | data source |
| [azurerm_private_dns_zone.privatelink_blob_azure_com](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/private_dns_zone) | data source |
| [azurerm_private_dns_zone.storage](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/private_dns_zone) | data source |
| [azurerm_redis_cache.redis_cache](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/redis_cache) | data source |
| [azurerm_resource_group.identity_rg](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/resource_group) | data source |
| [azurerm_resource_group.monitor_rg](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/resource_group) | data source |
| [azurerm_subnet.aks_subnet](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/subnet) | data source |
| [azurerm_subscription.current](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/subscription) | data source |
| [azurerm_user_assigned_identity.iac_federated_azdo](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/user_assigned_identity) | data source |
| [azurerm_virtual_network.vnet](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/virtual_network) | data source |
| [azurerm_virtual_network.vnet_ita](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/virtual_network) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_cidr_subnet_authorizer_cosmosdb"></a> [cidr\_subnet\_authorizer\_cosmosdb](#input\_cidr\_subnet\_authorizer\_cosmosdb) | Cosmos DB address space | `list(string)` | `null` | no |
| <a name="input_cidr_subnet_iuvgenerator_cosmosdb"></a> [cidr\_subnet\_iuvgenerator\_cosmosdb](#input\_cidr\_subnet\_iuvgenerator\_cosmosdb) | Cosmos DB address space | `list(string)` | `null` | no |
| <a name="input_cidr_subnet_loadtest_agent"></a> [cidr\_subnet\_loadtest\_agent](#input\_cidr\_subnet\_loadtest\_agent) | LoadTest Agent Pool address space | `list(string)` | `null` | no |
| <a name="input_cidr_subnet_taxonomy_storage_account"></a> [cidr\_subnet\_taxonomy\_storage\_account](#input\_cidr\_subnet\_taxonomy\_storage\_account) | Storage account network address space. | `list(string)` | n/a | yes |
| <a name="input_cidr_subnet_test_data_storage_account"></a> [cidr\_subnet\_test\_data\_storage\_account](#input\_cidr\_subnet\_test\_data\_storage\_account) | Storage account network address space. | `list(string)` | `null` | no |
| <a name="input_cosmos_authorizer_db_params"></a> [cosmos\_authorizer\_db\_params](#input\_cosmos\_authorizer\_db\_params) | n/a | <pre>object({<br/>    kind           = string<br/>    capabilities   = list(string)<br/>    offer_type     = string<br/>    server_version = string<br/>    consistency_policy = object({<br/>      consistency_level       = string<br/>      max_interval_in_seconds = number<br/>      max_staleness_prefix    = number<br/>    })<br/>    main_geo_location_zone_redundant = bool<br/>    enable_free_tier                 = bool<br/>    additional_geo_locations = list(object({<br/>      location          = string<br/>      failover_priority = number<br/>      zone_redundant    = bool<br/>    }))<br/>    private_endpoint_enabled          = bool<br/>    public_network_access_enabled     = bool<br/>    is_virtual_network_filter_enabled = bool<br/>    backup_continuous_enabled         = bool<br/>  })</pre> | n/a | yes |
| <a name="input_cosmos_iuvgenerator_db_params"></a> [cosmos\_iuvgenerator\_db\_params](#input\_cosmos\_iuvgenerator\_db\_params) | n/a | <pre>object({<br/>    kind           = string<br/>    capabilities   = list(string)<br/>    offer_type     = string<br/>    server_version = string<br/>    consistency_policy = object({<br/>      consistency_level       = string<br/>      max_interval_in_seconds = number<br/>      max_staleness_prefix    = number<br/>    })<br/>    main_geo_location_zone_redundant = bool<br/>    enable_free_tier                 = bool<br/>    additional_geo_locations = list(object({<br/>      location          = string<br/>      failover_priority = number<br/>      zone_redundant    = bool<br/>    }))<br/>    private_endpoint_enabled          = bool<br/>    public_network_access_enabled     = bool<br/>    is_virtual_network_filter_enabled = bool<br/>    backup_continuous_enabled         = bool<br/>  })</pre> | n/a | yes |
| <a name="input_dns_zone_internal_prefix"></a> [dns\_zone\_internal\_prefix](#input\_dns\_zone\_internal\_prefix) | The dns subdomain. | `string` | `null` | no |
| <a name="input_domain"></a> [domain](#input\_domain) | n/a | `string` | n/a | yes |
| <a name="input_env"></a> [env](#input\_env) | n/a | `string` | n/a | yes |
| <a name="input_env_short"></a> [env\_short](#input\_env\_short) | n/a | `string` | n/a | yes |
| <a name="input_external_domain"></a> [external\_domain](#input\_external\_domain) | Domain for delegation | `string` | `null` | no |
| <a name="input_github_repository_environment"></a> [github\_repository\_environment](#input\_github\_repository\_environment) | GitHub Continuous Integration roles | <pre>object({<br/>    protected_branches     = bool<br/>    custom_branch_policies = bool<br/>    reviewers_teams        = list(string)<br/>  })</pre> | <pre>{<br/>  "custom_branch_policies": true,<br/>  "protected_branches": false,<br/>  "reviewers_teams": [<br/>    "pagopa-team-core"<br/>  ]<br/>}</pre> | no |
| <a name="input_github_runner"></a> [github\_runner](#input\_github\_runner) | GitHub runner variables | <pre>object({<br/>    subnet_address_prefixes = list(string)<br/>  })</pre> | <pre>{<br/>  "subnet_address_prefixes": [<br/>    "10.1.164.0/23"<br/>  ]<br/>}</pre> | no |
| <a name="input_github_runner_ita_enabled"></a> [github\_runner\_ita\_enabled](#input\_github\_runner\_ita\_enabled) | Enable github runner ita | `bool` | `false` | no |
| <a name="input_github_runner_italy"></a> [github\_runner\_italy](#input\_github\_runner\_italy) | GitHub runner variables | <pre>object({<br/>    subnet_address_prefixes = list(string)<br/>  })</pre> | <pre>{<br/>  "subnet_address_prefixes": [<br/>    "10.3.16.0/23"<br/>  ]<br/>}</pre> | no |
| <a name="input_ingress_load_balancer_ip"></a> [ingress\_load\_balancer\_ip](#input\_ingress\_load\_balancer\_ip) | n/a | `string` | n/a | yes |
| <a name="input_instance"></a> [instance](#input\_instance) | One of beta, prod01, prod02 | `string` | n/a | yes |
| <a name="input_k8s_kube_config_path_prefix"></a> [k8s\_kube\_config\_path\_prefix](#input\_k8s\_kube\_config\_path\_prefix) | n/a | `string` | `"~/.kube"` | no |
| <a name="input_location"></a> [location](#input\_location) | One of westeurope, northeurope | `string` | n/a | yes |
| <a name="input_location_italy"></a> [location\_italy](#input\_location\_italy) | italy north | `string` | n/a | yes |
| <a name="input_location_short"></a> [location\_short](#input\_location\_short) | One of wue, neu | `string` | n/a | yes |
| <a name="input_location_short_italy"></a> [location\_short\_italy](#input\_location\_short\_italy) | italy itn | `string` | n/a | yes |
| <a name="input_log_analytics_workspace_name"></a> [log\_analytics\_workspace\_name](#input\_log\_analytics\_workspace\_name) | Specifies the name of the Log Analytics Workspace. | `string` | n/a | yes |
| <a name="input_log_analytics_workspace_resource_group_name"></a> [log\_analytics\_workspace\_resource\_group\_name](#input\_log\_analytics\_workspace\_resource\_group\_name) | The name of the resource group in which the Log Analytics workspace is located in. | `string` | n/a | yes |
| <a name="input_monitor_resource_group_name"></a> [monitor\_resource\_group\_name](#input\_monitor\_resource\_group\_name) | Monitor resource group name | `string` | n/a | yes |
| <a name="input_poc_advanced_threat_protection"></a> [poc\_advanced\_threat\_protection](#input\_poc\_advanced\_threat\_protection) | Enable contract threat advanced protection | `bool` | `false` | no |
| <a name="input_poc_delete_retention_days"></a> [poc\_delete\_retention\_days](#input\_poc\_delete\_retention\_days) | Number of days to retain deleted. | `number` | `30` | no |
| <a name="input_poc_versioning"></a> [poc\_versioning](#input\_poc\_versioning) | Enable sa versioning | `bool` | `false` | no |
| <a name="input_prefix"></a> [prefix](#input\_prefix) | n/a | `string` | n/a | yes |
| <a name="input_redis_ha_enabled"></a> [redis\_ha\_enabled](#input\_redis\_ha\_enabled) | (Required) If true, enables the usage of HA redis instance | `bool` | n/a | yes |
| <a name="input_reporting_storage_public_access_enabled"></a> [reporting\_storage\_public\_access\_enabled](#input\_reporting\_storage\_public\_access\_enabled) | (Optional) Whether the public network access is enabled? | `bool` | `true` | no |
| <a name="input_taxonomy_network_rules"></a> [taxonomy\_network\_rules](#input\_taxonomy\_network\_rules) | Network configuration of Taxonomy storage account | <pre>object({<br/>    default_action             = string<br/>    ip_rules                   = list(string)<br/>    virtual_network_subnet_ids = list(string)<br/>    bypass                     = set(string)<br/>  })</pre> | `null` | no |
| <a name="input_taxonomy_storage_account"></a> [taxonomy\_storage\_account](#input\_taxonomy\_storage\_account) | n/a | <pre>object({<br/>    account_kind                  = string<br/>    account_tier                  = string<br/>    account_replication_type      = string<br/>    advanced_threat_protection    = bool<br/>    blob_versioning_enabled       = bool<br/>    public_network_access_enabled = bool<br/>    blob_delete_retention_days    = number<br/>    enable_low_availability_alert = bool<br/>    backup_enabled                = optional(bool, false)<br/>    backup_retention              = optional(number, 0)<br/>  })</pre> | n/a | yes |
| <a name="input_test_data_storage_account"></a> [test\_data\_storage\_account](#input\_test\_data\_storage\_account) | n/a | <pre>object({<br/>    account_kind                  = string<br/>    account_tier                  = string<br/>    account_replication_type      = string<br/>    advanced_threat_protection    = bool<br/>    blob_versioning_enabled       = bool<br/>    public_network_access_enabled = bool<br/>    blob_delete_retention_days    = number<br/>    enable_low_availability_alert = bool<br/>  })</pre> | `null` | no |

## Outputs

No outputs.
<!-- END_TF_DOCS -->
