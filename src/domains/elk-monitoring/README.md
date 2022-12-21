# elk-monitoring

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_azuread"></a> [azuread](#requirement\_azuread) | = 2.21.0 |
| <a name="requirement_azurerm"></a> [azurerm](#requirement\_azurerm) | = 2.99.0 |
| <a name="requirement_helm"></a> [helm](#requirement\_helm) | = 2.5.1 |
| <a name="requirement_kubernetes"></a> [kubernetes](#requirement\_kubernetes) | = 2.11.0 |
| <a name="requirement_null"></a> [null](#requirement\_null) | = 3.1.1 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_key_vault"></a> [key\_vault](#module\_key\_vault) | git::https://github.com/pagopa/azurerm.git//key_vault | v2.13.1 |
| <a name="module_letsencrypt_dev_elk"></a> [letsencrypt\_dev\_elk](#module\_letsencrypt\_dev\_elk) | git::https://github.com/pagopa/azurerm.git//letsencrypt_credential | v3.8.1 |
| <a name="module_pod_identity"></a> [pod\_identity](#module\_pod\_identity) | git::https://github.com/pagopa/azurerm.git//kubernetes_pod_identity | v2.13.1 |
| <a name="module_tls_checker"></a> [tls\_checker](#module\_tls\_checker) | git::https://github.com/pagopa/azurerm.git//tls_checker | v2.19.0 |

## Resources

| Name | Type |
|------|------|
| [azurerm_key_vault_access_policy.ad_group_policy](https://registry.terraform.io/providers/hashicorp/azurerm/2.99.0/docs/resources/key_vault_access_policy) | resource |
| [azurerm_key_vault_access_policy.adgroup_developers_policy](https://registry.terraform.io/providers/hashicorp/azurerm/2.99.0/docs/resources/key_vault_access_policy) | resource |
| [azurerm_key_vault_access_policy.azdevops_iac_policy](https://registry.terraform.io/providers/hashicorp/azurerm/2.99.0/docs/resources/key_vault_access_policy) | resource |
| [azurerm_key_vault_secret.aks_apiserver_url](https://registry.terraform.io/providers/hashicorp/azurerm/2.99.0/docs/resources/key_vault_secret) | resource |
| [azurerm_kubernetes_cluster_node_pool.elastic](https://registry.terraform.io/providers/hashicorp/azurerm/2.99.0/docs/resources/kubernetes_cluster_node_pool) | resource |
| [azurerm_private_dns_a_record.kibana_ingress](https://registry.terraform.io/providers/hashicorp/azurerm/2.99.0/docs/resources/private_dns_a_record) | resource |
| [azurerm_resource_group.sec_rg](https://registry.terraform.io/providers/hashicorp/azurerm/2.99.0/docs/resources/resource_group) | resource |
| [helm_release.reloader](https://registry.terraform.io/providers/hashicorp/helm/2.5.1/docs/resources/release) | resource |
| [kubernetes_manifest.apm_manifest](https://registry.terraform.io/providers/hashicorp/kubernetes/2.11.0/docs/resources/manifest) | resource |
| [kubernetes_manifest.ingress_manifest](https://registry.terraform.io/providers/hashicorp/kubernetes/2.11.0/docs/resources/manifest) | resource |
| [kubernetes_manifest.kibana_manifest](https://registry.terraform.io/providers/hashicorp/kubernetes/2.11.0/docs/resources/manifest) | resource |
| [kubernetes_storage_class.kubernetes_storage_class_cold](https://registry.terraform.io/providers/hashicorp/kubernetes/2.11.0/docs/resources/storage_class) | resource |
| [kubernetes_storage_class.kubernetes_storage_class_hot](https://registry.terraform.io/providers/hashicorp/kubernetes/2.11.0/docs/resources/storage_class) | resource |
| [kubernetes_storage_class.kubernetes_storage_class_warm](https://registry.terraform.io/providers/hashicorp/kubernetes/2.11.0/docs/resources/storage_class) | resource |
| [local_file.elastic_file](https://registry.terraform.io/providers/hashicorp/local/latest/docs/resources/file) | resource |
| [azuread_group.adgroup_admin](https://registry.terraform.io/providers/hashicorp/azuread/2.21.0/docs/data-sources/group) | data source |
| [azuread_group.adgroup_developers](https://registry.terraform.io/providers/hashicorp/azuread/2.21.0/docs/data-sources/group) | data source |
| [azuread_group.adgroup_externals](https://registry.terraform.io/providers/hashicorp/azuread/2.21.0/docs/data-sources/group) | data source |
| [azuread_group.adgroup_security](https://registry.terraform.io/providers/hashicorp/azuread/2.21.0/docs/data-sources/group) | data source |
| [azuread_service_principal.iac_principal](https://registry.terraform.io/providers/hashicorp/azuread/2.21.0/docs/data-sources/service_principal) | data source |
| [azurerm_application_insights.application_insights](https://registry.terraform.io/providers/hashicorp/azurerm/2.99.0/docs/data-sources/application_insights) | data source |
| [azurerm_client_config.current](https://registry.terraform.io/providers/hashicorp/azurerm/2.99.0/docs/data-sources/client_config) | data source |
| [azurerm_kubernetes_cluster.aks](https://registry.terraform.io/providers/hashicorp/azurerm/2.99.0/docs/data-sources/kubernetes_cluster) | data source |
| [azurerm_log_analytics_workspace.log_analytics](https://registry.terraform.io/providers/hashicorp/azurerm/2.99.0/docs/data-sources/log_analytics_workspace) | data source |
| [azurerm_monitor_action_group.email](https://registry.terraform.io/providers/hashicorp/azurerm/2.99.0/docs/data-sources/monitor_action_group) | data source |
| [azurerm_monitor_action_group.slack](https://registry.terraform.io/providers/hashicorp/azurerm/2.99.0/docs/data-sources/monitor_action_group) | data source |
| [azurerm_private_dns_zone.internal](https://registry.terraform.io/providers/hashicorp/azurerm/2.99.0/docs/data-sources/private_dns_zone) | data source |
| [azurerm_resource_group.monitor_rg](https://registry.terraform.io/providers/hashicorp/azurerm/2.99.0/docs/data-sources/resource_group) | data source |
| [azurerm_subnet.aks_snet](https://registry.terraform.io/providers/hashicorp/azurerm/2.99.0/docs/data-sources/subnet) | data source |
| [azurerm_subscription.current](https://registry.terraform.io/providers/hashicorp/azurerm/2.99.0/docs/data-sources/subscription) | data source |
| [azurerm_virtual_network.vnet](https://registry.terraform.io/providers/hashicorp/azurerm/2.99.0/docs/data-sources/virtual_network) | data source |
| [kubernetes_namespace.namespace](https://registry.terraform.io/providers/hashicorp/kubernetes/2.11.0/docs/data-sources/namespace) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_apim_dns_zone_prefix"></a> [apim\_dns\_zone\_prefix](#input\_apim\_dns\_zone\_prefix) | The dns subdomain for apim. | `string` | `null` | no |
| <a name="input_dns_zone_internal_prefix"></a> [dns\_zone\_internal\_prefix](#input\_dns\_zone\_internal\_prefix) | The dns subdomain. | `string` | `null` | no |
| <a name="input_domain"></a> [domain](#input\_domain) | n/a | `string` | n/a | yes |
| <a name="input_elastic_cluster_config"></a> [elastic\_cluster\_config](#input\_elastic\_cluster\_config) | n/a | <pre>object({<br>    num_node_balancer     = string<br>    num_node_master       = string<br>    num_node_hot          = string<br>    num_node_warm         = string<br>    num_node_cold         = string<br>    storage_size_balancer = string<br>    storage_size_master   = string<br>    storage_size_hot      = string<br>    storage_size_warm     = string<br>    storage_size_cold     = string<br>  })</pre> | n/a | yes |
| <a name="input_elastic_cold_storage"></a> [elastic\_cold\_storage](#input\_elastic\_cold\_storage) | n/a | <pre>object({<br>    storage_type           = string,<br>    allow_volume_expansion = bool,<br>    initialStorageSize     = string<br>  })</pre> | n/a | yes |
| <a name="input_elastic_hot_storage"></a> [elastic\_hot\_storage](#input\_elastic\_hot\_storage) | n/a | <pre>object({<br>    storage_type           = string,<br>    allow_volume_expansion = bool,<br>    initialStorageSize     = string<br>  })</pre> | n/a | yes |
| <a name="input_elastic_node_pool"></a> [elastic\_node\_pool](#input\_elastic\_node\_pool) | AKS node pool user configuration | <pre>object({<br>    enabled               = bool,<br>    name                  = string,<br>    vm_size               = string,<br>    os_disk_type          = string,<br>    os_disk_size_gb       = string,<br>    node_count_min        = number,<br>    node_count_max        = number,<br>    node_labels           = map(any),<br>    node_taints           = list(string),<br>    node_tags             = map(any),<br>    elastic_pool_max_pods = number,<br>  })</pre> | n/a | yes |
| <a name="input_elastic_warm_storage"></a> [elastic\_warm\_storage](#input\_elastic\_warm\_storage) | n/a | <pre>object({<br>    storage_type           = string,<br>    allow_volume_expansion = bool,<br>    initialStorageSize     = string<br>  })</pre> | n/a | yes |
| <a name="input_enable_iac_pipeline"></a> [enable\_iac\_pipeline](#input\_enable\_iac\_pipeline) | If true create the key vault policy to allow used by azure devops iac pipelines. | `bool` | `false` | no |
| <a name="input_env"></a> [env](#input\_env) | n/a | `string` | n/a | yes |
| <a name="input_env_short"></a> [env\_short](#input\_env\_short) | n/a | `string` | n/a | yes |
| <a name="input_external_domain"></a> [external\_domain](#input\_external\_domain) | Domain for delegation | `string` | `null` | no |
| <a name="input_ingress_load_balancer_ip"></a> [ingress\_load\_balancer\_ip](#input\_ingress\_load\_balancer\_ip) | n/a | `string` | n/a | yes |
| <a name="input_instance"></a> [instance](#input\_instance) | One of beta, prod01, prod02 | `string` | n/a | yes |
| <a name="input_k8s_kube_config_path_prefix"></a> [k8s\_kube\_config\_path\_prefix](#input\_k8s\_kube\_config\_path\_prefix) | n/a | `string` | `"~/.kube"` | no |
| <a name="input_location"></a> [location](#input\_location) | One of westeurope, northeurope | `string` | n/a | yes |
| <a name="input_location_short"></a> [location\_short](#input\_location\_short) | One of wue, neu | `string` | n/a | yes |
| <a name="input_location_string"></a> [location\_string](#input\_location\_string) | One of West Europe, North Europe | `string` | n/a | yes |
| <a name="input_log_analytics_workspace_name"></a> [log\_analytics\_workspace\_name](#input\_log\_analytics\_workspace\_name) | Specifies the name of the Log Analytics Workspace. | `string` | n/a | yes |
| <a name="input_log_analytics_workspace_resource_group_name"></a> [log\_analytics\_workspace\_resource\_group\_name](#input\_log\_analytics\_workspace\_resource\_group\_name) | The name of the resource group in which the Log Analytics workspace is located in. | `string` | n/a | yes |
| <a name="input_monitor_resource_group_name"></a> [monitor\_resource\_group\_name](#input\_monitor\_resource\_group\_name) | Monitor resource group name | `string` | n/a | yes |
| <a name="input_prefix"></a> [prefix](#input\_prefix) | n/a | `string` | n/a | yes |
| <a name="input_subscription_name"></a> [subscription\_name](#input\_subscription\_name) | Subscription name | `string` | n/a | yes |
| <a name="input_tags"></a> [tags](#input\_tags) | n/a | `map(any)` | <pre>{<br>  "CreatedBy": "Terraform"<br>}</pre> | no |
| <a name="input_tls_cert_check_helm"></a> [tls\_cert\_check\_helm](#input\_tls\_cert\_check\_helm) | tls cert helm chart configuration | <pre>object({<br>    chart_version = string,<br>    image_name    = string,<br>    image_tag     = string<br>  })</pre> | n/a | yes |

## Outputs

No outputs.
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
