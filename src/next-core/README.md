<!-- markdownlint-disable -->
<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_azuread"></a> [azuread](#requirement\_azuread) | = 2.21.0 |
| <a name="requirement_azurerm"></a> [azurerm](#requirement\_azurerm) | <= 3.75.0 |
| <a name="requirement_helm"></a> [helm](#requirement\_helm) | = 2.5.1 |
| <a name="requirement_kubernetes"></a> [kubernetes](#requirement\_kubernetes) | = 2.11.0 |
| <a name="requirement_null"></a> [null](#requirement\_null) | = 3.1.1 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_dns_forwarder_backup_snet"></a> [dns\_forwarder\_backup\_snet](#module\_dns\_forwarder\_backup\_snet) | git::https://github.com/pagopa/terraform-azurerm-v3.git//subnet | v7.11.0 |
| <a name="module_dns_forwarder_backup_vmss_li"></a> [dns\_forwarder\_backup\_vmss\_li](#module\_dns\_forwarder\_backup\_vmss\_li) | git::https://github.com/pagopa/terraform-azurerm-v3.git//dns_forwarder_scale_set_vm | v7.20.0 |
| <a name="module_logos_donation_flows_sa"></a> [logos\_donation\_flows\_sa](#module\_logos\_donation\_flows\_sa) | git::https://github.com/pagopa/terraform-azurerm-v3.git//storage_account | v7.30.0 |
| <a name="module_vnet_peering"></a> [vnet\_peering](#module\_vnet\_peering) | git::https://github.com/pagopa/terraform-azurerm-v3.git//virtual_network_peering | v7.33.0 |
| <a name="module_vnet_replica"></a> [vnet\_replica](#module\_vnet\_replica) | git::https://github.com/pagopa/terraform-azurerm-v3.git//virtual_network | v7.18.0 |

## Resources

| Name | Type |
|------|------|
| [azurerm_private_dns_zone.private_db_dns_zone](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/private_dns_zone) | resource |
| [azurerm_private_dns_zone_virtual_network_link.private_db_zone_to_core_vnet](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/private_dns_zone_virtual_network_link) | resource |
| [azurerm_role_assignment.data_contributor_role_donations](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/role_assignment) | resource |
| [azurerm_storage_blob.donation_logo10](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/storage_blob) | resource |
| [azurerm_storage_blob.donation_logo7](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/storage_blob) | resource |
| [azurerm_storage_blob.donation_logo8](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/storage_blob) | resource |
| [azurerm_storage_blob.donation_logo9](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/storage_blob) | resource |
| [azurerm_storage_container.donation_logo10](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/storage_container) | resource |
| [azurerm_storage_container.donation_logo7](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/storage_container) | resource |
| [azurerm_storage_container.donation_logo8](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/storage_container) | resource |
| [azurerm_storage_container.donation_logo9](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/storage_container) | resource |
| [null_resource.change_auth_donations_blob_container_logo10](https://registry.terraform.io/providers/hashicorp/null/3.1.1/docs/resources/resource) | resource |
| [null_resource.change_auth_donations_blob_container_logo7](https://registry.terraform.io/providers/hashicorp/null/3.1.1/docs/resources/resource) | resource |
| [null_resource.change_auth_donations_blob_container_logo8](https://registry.terraform.io/providers/hashicorp/null/3.1.1/docs/resources/resource) | resource |
| [null_resource.change_auth_donations_blob_container_logo9](https://registry.terraform.io/providers/hashicorp/null/3.1.1/docs/resources/resource) | resource |
| [azuread_group.adgroup_admin](https://registry.terraform.io/providers/hashicorp/azuread/2.21.0/docs/data-sources/group) | data source |
| [azuread_group.adgroup_developers](https://registry.terraform.io/providers/hashicorp/azuread/2.21.0/docs/data-sources/group) | data source |
| [azuread_group.adgroup_externals](https://registry.terraform.io/providers/hashicorp/azuread/2.21.0/docs/data-sources/group) | data source |
| [azuread_group.adgroup_security](https://registry.terraform.io/providers/hashicorp/azuread/2.21.0/docs/data-sources/group) | data source |
| [azurerm_api_management.apim](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/api_management) | data source |
| [azurerm_application_insights.application_insights](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/application_insights) | data source |
| [azurerm_client_config.current](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/client_config) | data source |
| [azurerm_log_analytics_workspace.log_analytics](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/log_analytics_workspace) | data source |
| [azurerm_monitor_action_group.email](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/monitor_action_group) | data source |
| [azurerm_monitor_action_group.slack](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/monitor_action_group) | data source |
| [azurerm_resource_group.data](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/resource_group) | data source |
| [azurerm_resource_group.monitor_rg](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/resource_group) | data source |
| [azurerm_resource_group.rg_vnet_core](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/resource_group) | data source |
| [azurerm_resource_group.rg_vnet_integration](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/resource_group) | data source |
| [azurerm_subscription.current](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/subscription) | data source |
| [azurerm_virtual_network.vnet_core](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/virtual_network) | data source |
| [azurerm_virtual_network.vnet_integration](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/virtual_network) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_cidr_subnet_dns_forwarder_backup"></a> [cidr\_subnet\_dns\_forwarder\_backup](#input\_cidr\_subnet\_dns\_forwarder\_backup) | Address prefixes subnet dns forwarder backup. | `list(string)` | `null` | no |
| <a name="input_dns_forwarder_backup_is_enabled"></a> [dns\_forwarder\_backup\_is\_enabled](#input\_dns\_forwarder\_backup\_is\_enabled) | Allow to enable or disable dns forwarder backup | `bool` | n/a | yes |
| <a name="input_dns_forwarder_vm_image_name"></a> [dns\_forwarder\_vm\_image\_name](#input\_dns\_forwarder\_vm\_image\_name) | Image name for dns forwarder | `string` | `null` | no |
| <a name="input_dns_zone_internal_prefix"></a> [dns\_zone\_internal\_prefix](#input\_dns\_zone\_internal\_prefix) | The dns subdomain. | `string` | `null` | no |
| <a name="input_domain"></a> [domain](#input\_domain) | n/a | `string` | n/a | yes |
| <a name="input_enable_logos_backup"></a> [enable\_logos\_backup](#input\_enable\_logos\_backup) | (Optional) Enables nodo sftp storage account backup | `bool` | `true` | no |
| <a name="input_env"></a> [env](#input\_env) | n/a | `string` | n/a | yes |
| <a name="input_env_short"></a> [env\_short](#input\_env\_short) | n/a | `string` | n/a | yes |
| <a name="input_external_domain"></a> [external\_domain](#input\_external\_domain) | Domain for delegation | `string` | `"pagopa.it"` | no |
| <a name="input_geo_replica_cidr_vnet"></a> [geo\_replica\_cidr\_vnet](#input\_geo\_replica\_cidr\_vnet) | (Required) Cidr block for replica vnet address space | `list(string)` | `null` | no |
| <a name="input_geo_replica_ddos_protection_plan"></a> [geo\_replica\_ddos\_protection\_plan](#input\_geo\_replica\_ddos\_protection\_plan) | n/a | <pre>object({<br>    id     = string<br>    enable = bool<br>  })</pre> | `null` | no |
| <a name="input_geo_replica_enabled"></a> [geo\_replica\_enabled](#input\_geo\_replica\_enabled) | (Optional) True if geo replica should be active for key data components i.e. PostgreSQL Flexible servers | `bool` | `false` | no |
| <a name="input_geo_replica_location"></a> [geo\_replica\_location](#input\_geo\_replica\_location) | (Optional) Location of the geo replica | `string` | `"northeurope"` | no |
| <a name="input_geo_replica_location_short"></a> [geo\_replica\_location\_short](#input\_geo\_replica\_location\_short) | (Optional) Short Location of the geo replica | `string` | `"neu"` | no |
| <a name="input_instance"></a> [instance](#input\_instance) | One of beta, prod01, prod02 | `string` | n/a | yes |
| <a name="input_location"></a> [location](#input\_location) | One of westeurope, northeurope | `string` | n/a | yes |
| <a name="input_location_short"></a> [location\_short](#input\_location\_short) | One of wue, neu | `string` | n/a | yes |
| <a name="input_lock_enable"></a> [lock\_enable](#input\_lock\_enable) | Apply locks to block accedentaly deletions. | `bool` | `false` | no |
| <a name="input_log_analytics_workspace_name"></a> [log\_analytics\_workspace\_name](#input\_log\_analytics\_workspace\_name) | Specifies the name of the Log Analytics Workspace. | `string` | n/a | yes |
| <a name="input_log_analytics_workspace_resource_group_name"></a> [log\_analytics\_workspace\_resource\_group\_name](#input\_log\_analytics\_workspace\_resource\_group\_name) | The name of the resource group in which the Log Analytics workspace is located in. | `string` | n/a | yes |
| <a name="input_logos_backup_retention"></a> [logos\_backup\_retention](#input\_logos\_backup\_retention) | (Optional) Blob backup retention | `number` | `7` | no |
| <a name="input_logos_donations_storage_account_replication_type"></a> [logos\_donations\_storage\_account\_replication\_type](#input\_logos\_donations\_storage\_account\_replication\_type) | (Optional) Logos donations storage account replication type | `string` | `"LRS"` | no |
| <a name="input_monitor_resource_group_name"></a> [monitor\_resource\_group\_name](#input\_monitor\_resource\_group\_name) | Monitor resource group name | `string` | n/a | yes |
| <a name="input_postgres_private_dns_enabled"></a> [postgres\_private\_dns\_enabled](#input\_postgres\_private\_dns\_enabled) | (Optional) If true creates a private dns that can be used to access the postgres databases | `bool` | `false` | no |
| <a name="input_prefix"></a> [prefix](#input\_prefix) | n/a | `string` | n/a | yes |
| <a name="input_tags"></a> [tags](#input\_tags) | n/a | `map(any)` | <pre>{<br>  "CreatedBy": "Terraform"<br>}</pre> | no |

## Outputs

No outputs.
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
