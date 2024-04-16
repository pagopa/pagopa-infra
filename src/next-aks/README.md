<!-- markdownlint-disable -->
<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_azuread"></a> [azuread](#requirement\_azuread) | = 2.21.0 |
| <a name="requirement_azurerm"></a> [azurerm](#requirement\_azurerm) | >= 3.40.0 |
| <a name="requirement_kubernetes"></a> [kubernetes](#requirement\_kubernetes) | <= 2.25.1 |
| <a name="requirement_local"></a> [local](#requirement\_local) | = 2.2.3 |
| <a name="requirement_null"></a> [null](#requirement\_null) | = 3.1.1 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_aks_namespace_backup"></a> [aks\_namespace\_backup](#module\_aks\_namespace\_backup) | git::https://github.com/pagopa/terraform-azurerm-v3.git//kubernetes_velero_backup | v7.68.0 |
| <a name="module_aks_single_namespace_backup"></a> [aks\_single\_namespace\_backup](#module\_aks\_single\_namespace\_backup) | git::https://github.com/pagopa/terraform-azurerm-v3.git//kubernetes_velero_backup | v7.68.0 |
| <a name="module_velero"></a> [velero](#module\_velero) | git::https://github.com/pagopa/terraform-azurerm-v3.git//kubernetes_cluster_velero | v7.31.0 |

## Resources

| Name | Type |
|------|------|
| [azurerm_resource_group.rg_velero_backup](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/resource_group) | resource |
| [azurerm_client_config.current](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/client_config) | data source |
| [azurerm_kubernetes_cluster.weu_aks](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/kubernetes_cluster) | data source |
| [azurerm_monitor_action_group.email](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/monitor_action_group) | data source |
| [azurerm_monitor_action_group.slack](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/monitor_action_group) | data source |
| [azurerm_private_dns_zone.storage_account_private_dns_zone](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/private_dns_zone) | data source |
| [azurerm_resource_group.aks_rg](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/resource_group) | data source |
| [azurerm_resource_group.monitor_rg](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/resource_group) | data source |
| [azurerm_resource_group.vnet_core_rg](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/resource_group) | data source |
| [azurerm_subnet.private_endpoint_subnet](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/subnet) | data source |
| [azurerm_subscription.current](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/subscription) | data source |
| [azurerm_virtual_network.vnet](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/virtual_network) | data source |
| [kubernetes_all_namespaces.all_ns](https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/data-sources/all_namespaces) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_domain"></a> [domain](#input\_domain) | n/a | `string` | n/a | yes |
| <a name="input_enable_velero_backup"></a> [enable\_velero\_backup](#input\_enable\_velero\_backup) | (Optional) If true, installs velero on the aks cluster and schedules the automatic backups | `bool` | `false` | no |
| <a name="input_env"></a> [env](#input\_env) | n/a | `string` | n/a | yes |
| <a name="input_env_short"></a> [env\_short](#input\_env\_short) | n/a | `string` | n/a | yes |
| <a name="input_k8s_kube_config_path_prefix"></a> [k8s\_kube\_config\_path\_prefix](#input\_k8s\_kube\_config\_path\_prefix) | n/a | `string` | `"~/.kube"` | no |
| <a name="input_location"></a> [location](#input\_location) | One of westeurope, northeurope | `string` | n/a | yes |
| <a name="input_location_short"></a> [location\_short](#input\_location\_short) | One of wue, neu | `string` | n/a | yes |
| <a name="input_prefix"></a> [prefix](#input\_prefix) | n/a | `string` | n/a | yes |
| <a name="input_tags"></a> [tags](#input\_tags) | n/a | `map(any)` | <pre>{<br>  "CreatedBy": "Terraform"<br>}</pre> | no |
| <a name="input_velero_backup_sa_replication_type"></a> [velero\_backup\_sa\_replication\_type](#input\_velero\_backup\_sa\_replication\_type) | (Optional) backup storage account replication type | `string` | `"GZRS"` | no |
| <a name="input_velero_backup_schedule"></a> [velero\_backup\_schedule](#input\_velero\_backup\_schedule) | (Optional) cron expression defining when to run the backups, expressed in UTC | `string` | `"0 3 * * *"` | no |
| <a name="input_velero_backup_single_namespace_schedule"></a> [velero\_backup\_single\_namespace\_schedule](#input\_velero\_backup\_single\_namespace\_schedule) | (Optional) cron expression defining when to run the backups, expressed in UTC | `string` | `"0 2 * * *"` | no |
| <a name="input_velero_backup_ttl"></a> [velero\_backup\_ttl](#input\_velero\_backup\_ttl) | (Optional) TTL for velero backups. defaults to 30 days | `string` | `"720h0m0s"` | no |
| <a name="input_velero_sa_backup_enabled"></a> [velero\_sa\_backup\_enabled](#input\_velero\_sa\_backup\_enabled) | (Optional) enables storage account point in time recovery | `bool` | `false` | no |
| <a name="input_velero_sa_backup_retention_days"></a> [velero\_sa\_backup\_retention\_days](#input\_velero\_sa\_backup\_retention\_days) | (Optional) number of days for which the storage account is available for point in time recovery | `number` | `0` | no |

## Outputs

No outputs.
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
