# mock-common

<!-- markdownlint-disable -->
<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_azuread"></a> [azuread](#requirement\_azuread) | ~> 2.53 |
| <a name="requirement_azurerm"></a> [azurerm](#requirement\_azurerm) | ~> 3.117 |
| <a name="requirement_null"></a> [null](#requirement\_null) | ~> 3.2 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module___v3__"></a> [\_\_v3\_\_](#module\_\_\_v3\_\_) | git::https://github.com/pagopa/terraform-azurerm-v3 | 745f8cf8faa1a53878939fc3b0fd944eef257f8e |
| <a name="module_identity_cd_01"></a> [identity\_cd\_01](#module\_identity\_cd\_01) | ./.terraform/modules/__v3__/github_federated_identity | n/a |
| <a name="module_key_vault"></a> [key\_vault](#module\_key\_vault) | ./.terraform/modules/__v3__/key_vault | n/a |
| <a name="module_mock_ec"></a> [mock\_ec](#module\_mock\_ec) | ./.terraform/modules/__v3__/app_service | n/a |
| <a name="module_mock_ec_snet"></a> [mock\_ec\_snet](#module\_mock\_ec\_snet) | ./.terraform/modules/__v3__/subnet | n/a |
| <a name="module_mock_payment_gateway"></a> [mock\_payment\_gateway](#module\_mock\_payment\_gateway) | ./.terraform/modules/__v3__/app_service | n/a |
| <a name="module_mock_payment_gateway_snet"></a> [mock\_payment\_gateway\_snet](#module\_mock\_payment\_gateway\_snet) | ./.terraform/modules/__v3__/subnet | n/a |
| <a name="module_mocker_cosmosdb_account"></a> [mocker\_cosmosdb\_account](#module\_mocker\_cosmosdb\_account) | ./.terraform/modules/__v3__/cosmosdb_account | n/a |
| <a name="module_mocker_cosmosdb_snet"></a> [mocker\_cosmosdb\_snet](#module\_mocker\_cosmosdb\_snet) | ./.terraform/modules/__v3__/subnet | n/a |
| <a name="module_tag_config"></a> [tag\_config](#module\_tag\_config) | ../../tag_config | n/a |
| <a name="module_workload_identity_init"></a> [workload\_identity\_init](#module\_workload\_identity\_init) | ./.terraform/modules/__v3__/kubernetes_workload_identity_init | n/a |

## Resources

| Name | Type |
|------|------|
| [azurerm_cosmosdb_mongo_database.mocker](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/cosmosdb_mongo_database) | resource |
| [azurerm_key_vault_access_policy.ad_group_policy](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/key_vault_access_policy) | resource |
| [azurerm_key_vault_access_policy.adgroup_developers_policy](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/key_vault_access_policy) | resource |
| [azurerm_key_vault_access_policy.azdevops_iac_legacy_policies](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/key_vault_access_policy) | resource |
| [azurerm_key_vault_access_policy.azdevops_iac_managed_identities](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/key_vault_access_policy) | resource |
| [azurerm_key_vault_access_policy.azdevops_iac_policy](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/key_vault_access_policy) | resource |
| [azurerm_key_vault_secret.ai_connection_string](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/key_vault_secret) | resource |
| [azurerm_key_vault_secret.mocker_cosmosdb_connection_string](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/key_vault_secret) | resource |
| [azurerm_key_vault_secret.redis_hostname](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/key_vault_secret) | resource |
| [azurerm_key_vault_secret.redis_password](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/key_vault_secret) | resource |
| [azurerm_private_dns_a_record.ingress](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/private_dns_a_record) | resource |
| [azurerm_resource_group.mock_ec_rg](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/resource_group) | resource |
| [azurerm_resource_group.mock_payment_gateway_rg](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/resource_group) | resource |
| [azurerm_resource_group.mock_rg](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/resource_group) | resource |
| [azurerm_resource_group.sec_rg](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/resource_group) | resource |
| [null_resource.github_runner_app_permissions_to_namespace_cd_01](https://registry.terraform.io/providers/hashicorp/null/latest/docs/resources/resource) | resource |
| [azuread_group.adgroup_admin](https://registry.terraform.io/providers/hashicorp/azuread/latest/docs/data-sources/group) | data source |
| [azuread_group.adgroup_developers](https://registry.terraform.io/providers/hashicorp/azuread/latest/docs/data-sources/group) | data source |
| [azuread_group.adgroup_externals](https://registry.terraform.io/providers/hashicorp/azuread/latest/docs/data-sources/group) | data source |
| [azuread_group.adgroup_security](https://registry.terraform.io/providers/hashicorp/azuread/latest/docs/data-sources/group) | data source |
| [azuread_service_principal.iac_deploy_legacy](https://registry.terraform.io/providers/hashicorp/azuread/latest/docs/data-sources/service_principal) | data source |
| [azuread_service_principal.iac_plan_legacy](https://registry.terraform.io/providers/hashicorp/azuread/latest/docs/data-sources/service_principal) | data source |
| [azuread_service_principal.iac_principal](https://registry.terraform.io/providers/hashicorp/azuread/latest/docs/data-sources/service_principal) | data source |
| [azurerm_application_insights.application_insights](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/application_insights) | data source |
| [azurerm_client_config.current](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/client_config) | data source |
| [azurerm_key_vault.kv](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/key_vault) | data source |
| [azurerm_key_vault_secret.mock_pgs_xpay_apikey_alias](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/key_vault_secret) | data source |
| [azurerm_key_vault_secret.mock_pgs_xpay_secret_key](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/key_vault_secret) | data source |
| [azurerm_kubernetes_cluster.aks](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/kubernetes_cluster) | data source |
| [azurerm_log_analytics_workspace.log_analytics](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/log_analytics_workspace) | data source |
| [azurerm_monitor_action_group.email](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/monitor_action_group) | data source |
| [azurerm_monitor_action_group.slack](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/monitor_action_group) | data source |
| [azurerm_private_dns_zone.cosmos](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/private_dns_zone) | data source |
| [azurerm_private_dns_zone.internal](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/private_dns_zone) | data source |
| [azurerm_redis_cache.redis_cache](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/redis_cache) | data source |
| [azurerm_resource_group.identity_rg](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/resource_group) | data source |
| [azurerm_resource_group.monitor_rg](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/resource_group) | data source |
| [azurerm_subnet.aks_subnet](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/subnet) | data source |
| [azurerm_subnet.apim_snet](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/subnet) | data source |
| [azurerm_subscription.current](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/subscription) | data source |
| [azurerm_user_assigned_identity.iac_federated_azdo](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/user_assigned_identity) | data source |
| [azurerm_virtual_network.vnet](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/virtual_network) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_application_insights_name"></a> [application\_insights\_name](#input\_application\_insights\_name) | Specifies the name of the Application Insights. | `string` | n/a | yes |
| <a name="input_cidr_subnet_mock_ec"></a> [cidr\_subnet\_mock\_ec](#input\_cidr\_subnet\_mock\_ec) | Address prefixes subnet mock ec | `list(string)` | `null` | no |
| <a name="input_cidr_subnet_mock_payment_gateway"></a> [cidr\_subnet\_mock\_payment\_gateway](#input\_cidr\_subnet\_mock\_payment\_gateway) | Address prefixes subnet mock payment\_gateway | `list(string)` | `null` | no |
| <a name="input_cidr_subnet_mocker_cosmosdb"></a> [cidr\_subnet\_mocker\_cosmosdb](#input\_cidr\_subnet\_mocker\_cosmosdb) | Cosmos DB address space | `list(string)` | `null` | no |
| <a name="input_cosmosdb_mongodb_enable_autoscaling"></a> [cosmosdb\_mongodb\_enable\_autoscaling](#input\_cosmosdb\_mongodb\_enable\_autoscaling) | It will enable autoscaling mode. If true, cosmosdb\_mongodb\_throughput must be unset | `bool` | `true` | no |
| <a name="input_cosmosdb_mongodb_extra_capabilities"></a> [cosmosdb\_mongodb\_extra\_capabilities](#input\_cosmosdb\_mongodb\_extra\_capabilities) | Enable cosmosdb extra capabilities | `list(string)` | `[]` | no |
| <a name="input_cosmosdb_mongodb_max_throughput"></a> [cosmosdb\_mongodb\_max\_throughput](#input\_cosmosdb\_mongodb\_max\_throughput) | The maximum throughput of the MongoDB database (RU/s). Must be between 4,000 and 1,000,000. Must be set in increments of 1,000. Conflicts with throughput | `number` | `5000` | no |
| <a name="input_cosmosdb_mongodb_throughput"></a> [cosmosdb\_mongodb\_throughput](#input\_cosmosdb\_mongodb\_throughput) | The throughput of the MongoDB database (RU/s). Must be set in increments of 100. The minimum value is 400. This must be set upon database creation otherwise it cannot be updated without a manual terraform destroy-apply. | `number` | `400` | no |
| <a name="input_dns_zone_internal_prefix"></a> [dns\_zone\_internal\_prefix](#input\_dns\_zone\_internal\_prefix) | The dns subdomain. | `string` | `null` | no |
| <a name="input_dns_zone_prefix"></a> [dns\_zone\_prefix](#input\_dns\_zone\_prefix) | The dns subdomain. | `string` | `null` | no |
| <a name="input_domain"></a> [domain](#input\_domain) | n/a | `string` | n/a | yes |
| <a name="input_enable_iac_pipeline"></a> [enable\_iac\_pipeline](#input\_enable\_iac\_pipeline) | If true create the key vault policy to allow used by azure devops iac pipelines. | `bool` | `false` | no |
| <a name="input_env"></a> [env](#input\_env) | n/a | `string` | n/a | yes |
| <a name="input_env_short"></a> [env\_short](#input\_env\_short) | n/a | `string` | n/a | yes |
| <a name="input_external_domain"></a> [external\_domain](#input\_external\_domain) | Domain for delegation | `string` | `null` | no |
| <a name="input_ingress_load_balancer_ip"></a> [ingress\_load\_balancer\_ip](#input\_ingress\_load\_balancer\_ip) | n/a | `string` | n/a | yes |
| <a name="input_instance"></a> [instance](#input\_instance) | One of beta, prod01, prod02 | `string` | n/a | yes |
| <a name="input_location"></a> [location](#input\_location) | One of westeurope, northeurope | `string` | n/a | yes |
| <a name="input_location_short"></a> [location\_short](#input\_location\_short) | One of wue, neu | `string` | n/a | yes |
| <a name="input_log_analytics_workspace_name"></a> [log\_analytics\_workspace\_name](#input\_log\_analytics\_workspace\_name) | Specifies the name of the Log Analytics Workspace. | `string` | n/a | yes |
| <a name="input_log_analytics_workspace_resource_group_name"></a> [log\_analytics\_workspace\_resource\_group\_name](#input\_log\_analytics\_workspace\_resource\_group\_name) | The name of the resource group in which the Log Analytics workspace is located in. | `string` | n/a | yes |
| <a name="input_mock_ec_always_on"></a> [mock\_ec\_always\_on](#input\_mock\_ec\_always\_on) | Mock EC always on property | `bool` | `false` | no |
| <a name="input_mock_ec_enabled"></a> [mock\_ec\_enabled](#input\_mock\_ec\_enabled) | Mock EC enabled | `bool` | `false` | no |
| <a name="input_mock_ec_secondary_enabled"></a> [mock\_ec\_secondary\_enabled](#input\_mock\_ec\_secondary\_enabled) | Mock Secondary EC enabled | `bool` | `false` | no |
| <a name="input_mock_ec_size"></a> [mock\_ec\_size](#input\_mock\_ec\_size) | Mock EC Plan size | `string` | `"S1"` | no |
| <a name="input_mock_ec_tier"></a> [mock\_ec\_tier](#input\_mock\_ec\_tier) | Mock EC Plan tier | `string` | `"Standard"` | no |
| <a name="input_mock_payment_gateway_always_on"></a> [mock\_payment\_gateway\_always\_on](#input\_mock\_payment\_gateway\_always\_on) | Mock payment gateway always on property | `bool` | `false` | no |
| <a name="input_mock_payment_gateway_enabled"></a> [mock\_payment\_gateway\_enabled](#input\_mock\_payment\_gateway\_enabled) | Mock payment gateway enabled | `bool` | `false` | no |
| <a name="input_mock_payment_gateway_size"></a> [mock\_payment\_gateway\_size](#input\_mock\_payment\_gateway\_size) | Mock payment gateway Plan size | `string` | `"S1"` | no |
| <a name="input_mock_payment_gateway_tier"></a> [mock\_payment\_gateway\_tier](#input\_mock\_payment\_gateway\_tier) | Mock payment gateway Plan tier | `string` | `"Standard"` | no |
| <a name="input_mocker_cosmosdb_params"></a> [mocker\_cosmosdb\_params](#input\_mocker\_cosmosdb\_params) | n/a | <pre>object({<br/>    kind           = string<br/>    capabilities   = list(string)<br/>    offer_type     = string<br/>    server_version = string<br/>    consistency_policy = object({<br/>      consistency_level       = string<br/>      max_interval_in_seconds = number<br/>      max_staleness_prefix    = number<br/>    })<br/>    main_geo_location_zone_redundant = bool<br/>    enable_free_tier                 = bool<br/>    additional_geo_locations = list(object({<br/>      location          = string<br/>      failover_priority = number<br/>      zone_redundant    = bool<br/>    }))<br/>    private_endpoint_enabled          = bool<br/>    public_network_access_enabled     = bool<br/>    is_virtual_network_filter_enabled = bool<br/>    backup_continuous_enabled         = bool<br/>    container_default_ttl             = number<br/>  })</pre> | n/a | yes |
| <a name="input_monitor_resource_group_name"></a> [monitor\_resource\_group\_name](#input\_monitor\_resource\_group\_name) | Monitor resource group name | `string` | n/a | yes |
| <a name="input_prefix"></a> [prefix](#input\_prefix) | n/a | `string` | n/a | yes |
| <a name="input_redis_ha_enabled"></a> [redis\_ha\_enabled](#input\_redis\_ha\_enabled) | (Required) If true, enables the usage of HA redis instance | `bool` | `false` | no |

## Outputs

No outputs.
<!-- END_TF_DOCS -->
