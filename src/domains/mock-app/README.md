# mock-common

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_azuread"></a> [azuread](#requirement\_azuread) | = 2.21.0 |
| <a name="requirement_azurerm"></a> [azurerm](#requirement\_azurerm) | >= 3.30.0, <= 3.53.0 |
| <a name="requirement_null"></a> [null](#requirement\_null) | = 3.1.1 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_apim_mock_ec_api"></a> [apim\_mock\_ec\_api](#module\_apim\_mock\_ec\_api) | git::https://github.com/pagopa/azurerm.git//api_management_api | v1.0.90 |
| <a name="module_apim_mock_ec_forwarder_api"></a> [apim\_mock\_ec\_forwarder\_api](#module\_apim\_mock\_ec\_forwarder\_api) | git::https://github.com/pagopa/azurerm.git//api_management_api | v2.1.13 |
| <a name="module_apim_mock_ec_nexi_api"></a> [apim\_mock\_ec\_nexi\_api](#module\_apim\_mock\_ec\_nexi\_api) | git::https://github.com/pagopa/azurerm.git//api_management_api | v1.0.90 |
| <a name="module_apim_mock_ec_nexi_product"></a> [apim\_mock\_ec\_nexi\_product](#module\_apim\_mock\_ec\_nexi\_product) | git::https://github.com/pagopa/azurerm.git//api_management_product | v1.0.90 |
| <a name="module_apim_mock_ec_product"></a> [apim\_mock\_ec\_product](#module\_apim\_mock\_ec\_product) | git::https://github.com/pagopa/azurerm.git//api_management_product | v1.0.90 |
| <a name="module_apim_mock_payment_gateway_api"></a> [apim\_mock\_payment\_gateway\_api](#module\_apim\_mock\_payment\_gateway\_api) | git::https://github.com/pagopa/azurerm.git//api_management_api | v1.0.90 |
| <a name="module_apim_mock_payment_gateway_mng_api"></a> [apim\_mock\_payment\_gateway\_mng\_api](#module\_apim\_mock\_payment\_gateway\_mng\_api) | git::https://github.com/pagopa/azurerm.git//api_management_api | v1.0.90 |
| <a name="module_apim_mock_payment_gateway_product"></a> [apim\_mock\_payment\_gateway\_product](#module\_apim\_mock\_payment\_gateway\_product) | git::https://github.com/pagopa/azurerm.git//api_management_product | v1.0.90 |
| <a name="module_apim_mock_pm_nexi_api"></a> [apim\_mock\_pm\_nexi\_api](#module\_apim\_mock\_pm\_nexi\_api) | git::https://github.com/pagopa/azurerm.git//api_management_api | v1.0.90 |
| <a name="module_apim_mock_pm_nexi_product"></a> [apim\_mock\_pm\_nexi\_product](#module\_apim\_mock\_pm\_nexi\_product) | git::https://github.com/pagopa/azurerm.git//api_management_product | v1.0.90 |
| <a name="module_apim_mock_psp_nexi_api"></a> [apim\_mock\_psp\_nexi\_api](#module\_apim\_mock\_psp\_nexi\_api) | git::https://github.com/pagopa/azurerm.git//api_management_api | v1.0.90 |
| <a name="module_apim_mock_psp_nexi_product"></a> [apim\_mock\_psp\_nexi\_product](#module\_apim\_mock\_psp\_nexi\_product) | git::https://github.com/pagopa/azurerm.git//api_management_product | v1.0.90 |
| <a name="module_apim_mock_psp_service_api"></a> [apim\_mock\_psp\_service\_api](#module\_apim\_mock\_psp\_service\_api) | git::https://github.com/pagopa/azurerm.git//api_management_api | v1.0.90 |
| <a name="module_apim_mock_psp_service_api_secondary"></a> [apim\_mock\_psp\_service\_api\_secondary](#module\_apim\_mock\_psp\_service\_api\_secondary) | git::https://github.com/pagopa/azurerm.git//api_management_api | v1.0.90 |
| <a name="module_apim_mock_psp_service_product"></a> [apim\_mock\_psp\_service\_product](#module\_apim\_mock\_psp\_service\_product) | git::https://github.com/pagopa/azurerm.git//api_management_product | v1.0.90 |
| <a name="module_apim_mock_psp_service_product_secondary"></a> [apim\_mock\_psp\_service\_product\_secondary](#module\_apim\_mock\_psp\_service\_product\_secondary) | git::https://github.com/pagopa/azurerm.git//api_management_product | v1.0.90 |
| <a name="module_apim_secondary_mock_ec_api"></a> [apim\_secondary\_mock\_ec\_api](#module\_apim\_secondary\_mock\_ec\_api) | git::https://github.com/pagopa/azurerm.git//api_management_api | v1.0.90 |
| <a name="module_apim_secondary_mock_ec_product"></a> [apim\_secondary\_mock\_ec\_product](#module\_apim\_secondary\_mock\_ec\_product) | git::https://github.com/pagopa/azurerm.git//api_management_product | v1.0.90 |

## Resources

| Name | Type |
|------|------|
| [azurerm_api_management_api_operation_policy.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/api_management_api_operation_policy) | resource |
| [azurerm_api_management_api_version_set.mock_ec_api](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/api_management_api_version_set) | resource |
| [azurerm_api_management_api_version_set.mock_ec_nexi_api](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/api_management_api_version_set) | resource |
| [azurerm_api_management_api_version_set.mock_pm_nexi_api](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/api_management_api_version_set) | resource |
| [azurerm_api_management_api_version_set.mock_psp_nexi_api](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/api_management_api_version_set) | resource |
| [azurerm_api_management_api_version_set.mock_psp_service_api](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/api_management_api_version_set) | resource |
| [azurerm_api_management_api_version_set.mock_psp_service_api_secondary](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/api_management_api_version_set) | resource |
| [azurerm_api_management_api_version_set.secondary_mock_ec_api](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/api_management_api_version_set) | resource |
| [azurerm_api_management_api_version_set.secondary_mock_ec_forwarder_api](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/api_management_api_version_set) | resource |
| [azurerm_application_insights.application_insights](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/application_insights) | data source |
| [azurerm_client_config.current](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/client_config) | data source |
| [azurerm_key_vault.kv](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/key_vault) | data source |
| [azurerm_resource_group.monitor_rg](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/resource_group) | data source |
| [azurerm_subnet.apim_snet](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/subnet) | data source |
| [azurerm_subscription.current](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/subscription) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_cidr_subnet_mock_ec"></a> [cidr\_subnet\_mock\_ec](#input\_cidr\_subnet\_mock\_ec) | Address prefixes subnet mock ec | `list(string)` | `null` | no |
| <a name="input_cidr_subnet_mock_payment_gateway"></a> [cidr\_subnet\_mock\_payment\_gateway](#input\_cidr\_subnet\_mock\_payment\_gateway) | Address prefixes subnet mock payment\_gateway | `list(string)` | `null` | no |
| <a name="input_dns_zone_prefix"></a> [dns\_zone\_prefix](#input\_dns\_zone\_prefix) | The dns subdomain. | `string` | `null` | no |
| <a name="input_domain"></a> [domain](#input\_domain) | n/a | `string` | n/a | yes |
| <a name="input_env"></a> [env](#input\_env) | n/a | `string` | n/a | yes |
| <a name="input_env_short"></a> [env\_short](#input\_env\_short) | n/a | `string` | n/a | yes |
| <a name="input_external_domain"></a> [external\_domain](#input\_external\_domain) | Domain for delegation | `string` | `null` | no |
| <a name="input_instance"></a> [instance](#input\_instance) | One of beta, prod01, prod02 | `string` | n/a | yes |
| <a name="input_lb_aks"></a> [lb\_aks](#input\_lb\_aks) | IP load balancer AKS Nexi/SIA | `string` | `"0.0.0.0"` | no |
| <a name="input_location"></a> [location](#input\_location) | One of westeurope, northeurope | `string` | n/a | yes |
| <a name="input_location_short"></a> [location\_short](#input\_location\_short) | One of wue, neu | `string` | n/a | yes |
| <a name="input_mock_ec_always_on"></a> [mock\_ec\_always\_on](#input\_mock\_ec\_always\_on) | Mock EC always on property | `bool` | `false` | no |
| <a name="input_mock_ec_enabled"></a> [mock\_ec\_enabled](#input\_mock\_ec\_enabled) | Mock EC enabled | `bool` | `false` | no |
| <a name="input_mock_ec_secondary_enabled"></a> [mock\_ec\_secondary\_enabled](#input\_mock\_ec\_secondary\_enabled) | Mock Secondary EC enabled | `bool` | `false` | no |
| <a name="input_mock_ec_size"></a> [mock\_ec\_size](#input\_mock\_ec\_size) | Mock EC Plan size | `string` | `"S1"` | no |
| <a name="input_mock_ec_tier"></a> [mock\_ec\_tier](#input\_mock\_ec\_tier) | Mock EC Plan tier | `string` | `"Standard"` | no |
| <a name="input_mock_payment_gateway_always_on"></a> [mock\_payment\_gateway\_always\_on](#input\_mock\_payment\_gateway\_always\_on) | Mock payment gateway always on property | `bool` | `false` | no |
| <a name="input_mock_payment_gateway_enabled"></a> [mock\_payment\_gateway\_enabled](#input\_mock\_payment\_gateway\_enabled) | Mock payment gateway enabled | `bool` | `false` | no |
| <a name="input_mock_payment_gateway_size"></a> [mock\_payment\_gateway\_size](#input\_mock\_payment\_gateway\_size) | Mock payment gateway Plan size | `string` | `"S1"` | no |
| <a name="input_mock_payment_gateway_tier"></a> [mock\_payment\_gateway\_tier](#input\_mock\_payment\_gateway\_tier) | Mock payment gateway Plan tier | `string` | `"Standard"` | no |
| <a name="input_mock_psp_secondary_service_enabled"></a> [mock\_psp\_secondary\_service\_enabled](#input\_mock\_psp\_secondary\_service\_enabled) | Mock Secondary PSP service Nexi | `bool` | `false` | no |
| <a name="input_mock_psp_service_enabled"></a> [mock\_psp\_service\_enabled](#input\_mock\_psp\_service\_enabled) | Mock PSP service Nexi | `bool` | `false` | no |
| <a name="input_monitor_resource_group_name"></a> [monitor\_resource\_group\_name](#input\_monitor\_resource\_group\_name) | Monitor resource group name | `string` | n/a | yes |
| <a name="input_prefix"></a> [prefix](#input\_prefix) | n/a | `string` | n/a | yes |
| <a name="input_tags"></a> [tags](#input\_tags) | n/a | `map(any)` | <pre>{<br>  "CreatedBy": "Terraform"<br>}</pre> | no |

## Outputs

No outputs.
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
