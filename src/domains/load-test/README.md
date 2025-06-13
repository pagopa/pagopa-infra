# load-test

<!-- markdownlint-disable -->
<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_azuread"></a> [azuread](#requirement\_azuread) | = 2.28.1 |
| <a name="requirement_azurerm"></a> [azurerm](#requirement\_azurerm) | = 3.24.0 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_grafana_managed"></a> [grafana\_managed](#module\_grafana\_managed) | git::https://github.com/pagopa/terraform-azurerm-v3.git//grafana | v3.4.3 |
| <a name="module_tag_config"></a> [tag\_config](#module\_tag\_config) | ../../tag_config | n/a |

## Resources

| Name | Type |
|------|------|
| [azurerm_dns_cname_record.grafana](https://registry.terraform.io/providers/hashicorp/azurerm/3.24.0/docs/resources/dns_cname_record) | resource |
| [azurerm_resource_group.load_test](https://registry.terraform.io/providers/hashicorp/azurerm/3.24.0/docs/resources/resource_group) | resource |
| [azurerm_role_assignment.adgroup_devevelopers_to_grafana_admin](https://registry.terraform.io/providers/hashicorp/azurerm/3.24.0/docs/resources/role_assignment) | resource |
| [azurerm_role_assignment.adgroup_devevelopers_to_grafana_editor](https://registry.terraform.io/providers/hashicorp/azurerm/3.24.0/docs/resources/role_assignment) | resource |
| [azurerm_role_assignment.adgroup_devevelopers_to_grafana_viewer](https://registry.terraform.io/providers/hashicorp/azurerm/3.24.0/docs/resources/role_assignment) | resource |
| [azuread_group.adgroup_developers](https://registry.terraform.io/providers/hashicorp/azuread/2.28.1/docs/data-sources/group) | data source |
| [azuread_group.adgroup_externals](https://registry.terraform.io/providers/hashicorp/azuread/2.28.1/docs/data-sources/group) | data source |
| [azuread_group.adgroup_operations](https://registry.terraform.io/providers/hashicorp/azuread/2.28.1/docs/data-sources/group) | data source |
| [azuread_group.adgroup_technical_project_managers](https://registry.terraform.io/providers/hashicorp/azuread/2.28.1/docs/data-sources/group) | data source |
| [azurerm_client_config.current](https://registry.terraform.io/providers/hashicorp/azurerm/3.24.0/docs/data-sources/client_config) | data source |
| [azurerm_subscription.current](https://registry.terraform.io/providers/hashicorp/azurerm/3.24.0/docs/data-sources/subscription) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_dns_zone_prefix"></a> [dns\_zone\_prefix](#input\_dns\_zone\_prefix) | The dns subdomain. | `string` | `null` | no |
| <a name="input_domain"></a> [domain](#input\_domain) | n/a | `string` | n/a | yes |
| <a name="input_env"></a> [env](#input\_env) | n/a | `string` | n/a | yes |
| <a name="input_env_short"></a> [env\_short](#input\_env\_short) | n/a | `string` | n/a | yes |
| <a name="input_external_domain"></a> [external\_domain](#input\_external\_domain) | Domain for delegation | `string` | `null` | no |
| <a name="input_instance"></a> [instance](#input\_instance) | One of beta, prod01, prod02 | `string` | n/a | yes |
| <a name="input_location"></a> [location](#input\_location) | One of westeurope, northeurope | `string` | n/a | yes |
| <a name="input_location_short"></a> [location\_short](#input\_location\_short) | One of wue, neu | `string` | n/a | yes |
| <a name="input_prefix"></a> [prefix](#input\_prefix) | n/a | `string` | n/a | yes |

## Outputs

No outputs.
<!-- END_TF_DOCS -->
