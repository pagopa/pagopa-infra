<!-- markdownlint-disable -->
<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_azuread"></a> [azuread](#requirement\_azuread) | = 2.21.0 |
| <a name="requirement_azurerm"></a> [azurerm](#requirement\_azurerm) | = 2.99.0 |
| <a name="requirement_helm"></a> [helm](#requirement\_helm) | = 2.5.1 |
| <a name="requirement_kubernetes"></a> [kubernetes](#requirement\_kubernetes) | = 2.11.0 |
| <a name="requirement_null"></a> [null](#requirement\_null) | = 3.1.1 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_azuread"></a> [azuread](#provider\_azuread) | 2.21.0 |
| <a name="provider_azurerm"></a> [azurerm](#provider\_azurerm) | 2.99.0 |
| <a name="provider_helm"></a> [helm](#provider\_helm) | 2.5.1 |
| <a name="provider_kubernetes"></a> [kubernetes](#provider\_kubernetes) | 2.11.0 |
| <a name="provider_null"></a> [null](#provider\_null) | 3.1.1 |
| <a name="provider_terraform"></a> [terraform](#provider\_terraform) | n/a |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_aks"></a> [aks](#module\_aks) | git::https://github.com/pagopa/azurerm.git//kubernetes_cluster | v2.13.1 |
| <a name="module_aks_snet"></a> [aks\_snet](#module\_aks\_snet) | git::https://github.com/pagopa/azurerm.git//subnet | v2.12.0 |
| <a name="module_keda_pod_identity"></a> [keda\_pod\_identity](#module\_keda\_pod\_identity) | git::https://github.com/pagopa/azurerm.git//kubernetes_pod_identity | v2.13.1 |
| <a name="module_nginx_ingress"></a> [nginx\_ingress](#module\_nginx\_ingress) | terraform-module/release/helm | 2.7.0 |

## Resources

| Name | Type |
|------|------|
| [azurerm_public_ip.aks_outbound](https://registry.terraform.io/providers/hashicorp/azurerm/2.99.0/docs/resources/public_ip) | resource |
| [azurerm_resource_group.aks_rg](https://registry.terraform.io/providers/hashicorp/azurerm/2.99.0/docs/resources/resource_group) | resource |
| [azurerm_role_assignment.aks_to_acr](https://registry.terraform.io/providers/hashicorp/azurerm/2.99.0/docs/resources/role_assignment) | resource |
| [azurerm_role_assignment.keda_monitoring_reader](https://registry.terraform.io/providers/hashicorp/azurerm/2.99.0/docs/resources/role_assignment) | resource |
| [helm_release.keda](https://registry.terraform.io/providers/hashicorp/helm/2.5.1/docs/resources/release) | resource |
| [kubernetes_cluster_role.cluster_deployer](https://registry.terraform.io/providers/hashicorp/kubernetes/2.11.0/docs/resources/cluster_role) | resource |
| [kubernetes_namespace.ingress](https://registry.terraform.io/providers/hashicorp/kubernetes/2.11.0/docs/resources/namespace) | resource |
| [kubernetes_namespace.keda](https://registry.terraform.io/providers/hashicorp/kubernetes/2.11.0/docs/resources/namespace) | resource |
| [null_resource.create_vnet_commmon_aks_link](https://registry.terraform.io/providers/hashicorp/null/3.1.1/docs/resources/resource) | resource |
| [azuread_group.adgroup_admin](https://registry.terraform.io/providers/hashicorp/azuread/2.21.0/docs/data-sources/group) | data source |
| [azuread_group.adgroup_developers](https://registry.terraform.io/providers/hashicorp/azuread/2.21.0/docs/data-sources/group) | data source |
| [azuread_group.adgroup_externals](https://registry.terraform.io/providers/hashicorp/azuread/2.21.0/docs/data-sources/group) | data source |
| [azuread_group.adgroup_security](https://registry.terraform.io/providers/hashicorp/azuread/2.21.0/docs/data-sources/group) | data source |
| [azurerm_client_config.current](https://registry.terraform.io/providers/hashicorp/azurerm/2.99.0/docs/data-sources/client_config) | data source |
| [azurerm_container_registry.acr](https://registry.terraform.io/providers/hashicorp/azurerm/2.99.0/docs/data-sources/container_registry) | data source |
| [azurerm_log_analytics_workspace.log_analytics](https://registry.terraform.io/providers/hashicorp/azurerm/2.99.0/docs/data-sources/log_analytics_workspace) | data source |
| [azurerm_monitor_action_group.email](https://registry.terraform.io/providers/hashicorp/azurerm/2.99.0/docs/data-sources/monitor_action_group) | data source |
| [azurerm_monitor_action_group.slack](https://registry.terraform.io/providers/hashicorp/azurerm/2.99.0/docs/data-sources/monitor_action_group) | data source |
| [azurerm_resource_group.monitor_rg](https://registry.terraform.io/providers/hashicorp/azurerm/2.99.0/docs/data-sources/resource_group) | data source |
| [azurerm_subscription.current](https://registry.terraform.io/providers/hashicorp/azurerm/2.99.0/docs/data-sources/subscription) | data source |
| [azurerm_virtual_network.vnet](https://registry.terraform.io/providers/hashicorp/azurerm/2.99.0/docs/data-sources/virtual_network) | data source |
| [azurerm_virtual_network.vnet_common](https://registry.terraform.io/providers/hashicorp/azurerm/2.99.0/docs/data-sources/virtual_network) | data source |
| [terraform_remote_state.core](https://registry.terraform.io/providers/hashicorp/terraform/latest/docs/data-sources/remote_state) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_aks_cidr_subnet"></a> [aks\_cidr\_subnet](#input\_aks\_cidr\_subnet) | Aks network address space. | `list(string)` | n/a | yes |
| <a name="input_aks_kubernetes_version"></a> [aks\_kubernetes\_version](#input\_aks\_kubernetes\_version) | Kubernetes version specified when creating the AKS managed cluster. | `string` | `"1.22.6"` | no |
| <a name="input_aks_num_outbound_ips"></a> [aks\_num\_outbound\_ips](#input\_aks\_num\_outbound\_ips) | How many outbound ips allocate for AKS cluster | `number` | `1` | no |
| <a name="input_aks_sku_tier"></a> [aks\_sku\_tier](#input\_aks\_sku\_tier) | The SKU Tier that should be used for this Kubernetes Cluster. Possible values are Free and Paid (which includes the Uptime SLA). | `string` | n/a | yes |
| <a name="input_aks_system_node_pool"></a> [aks\_system\_node\_pool](#input\_aks\_system\_node\_pool) | AKS node pool system configuration | <pre>object({<br>    name                         = string,<br>    vm_size                      = string,<br>    os_disk_type                 = string,<br>    os_disk_size_gb              = string,<br>    node_count_min               = number,<br>    node_count_max               = number,<br>    only_critical_addons_enabled = bool,<br>    node_labels                  = map(any),<br>    node_tags                    = map(any)<br>  })</pre> | n/a | yes |
| <a name="input_aks_user_node_pool"></a> [aks\_user\_node\_pool](#input\_aks\_user\_node\_pool) | AKS node pool user configuration | <pre>object({<br>    enabled         = bool,<br>    name            = string,<br>    vm_size         = string,<br>    os_disk_type    = string,<br>    os_disk_size_gb = string,<br>    node_count_min  = number,<br>    node_count_max  = number,<br>    node_labels     = map(any),<br>    node_taints     = list(string),<br>    node_tags       = map(any)<br>  })</pre> | n/a | yes |
| <a name="input_domain"></a> [domain](#input\_domain) | n/a | `string` | n/a | yes |
| <a name="input_env"></a> [env](#input\_env) | n/a | `string` | n/a | yes |
| <a name="input_env_short"></a> [env\_short](#input\_env\_short) | n/a | `string` | n/a | yes |
| <a name="input_ingress_load_balancer_ip"></a> [ingress\_load\_balancer\_ip](#input\_ingress\_load\_balancer\_ip) | n/a | `string` | n/a | yes |
| <a name="input_ingress_replica_count"></a> [ingress\_replica\_count](#input\_ingress\_replica\_count) | n/a | `string` | n/a | yes |
| <a name="input_k8s_kube_config_path_prefix"></a> [k8s\_kube\_config\_path\_prefix](#input\_k8s\_kube\_config\_path\_prefix) | n/a | `string` | `"~/.kube"` | no |
| <a name="input_keda_helm_version"></a> [keda\_helm\_version](#input\_keda\_helm\_version) | n/a | `string` | n/a | yes |
| <a name="input_location"></a> [location](#input\_location) | One of westeurope, northeurope | `string` | n/a | yes |
| <a name="input_location_short"></a> [location\_short](#input\_location\_short) | One of wue, neu | `string` | n/a | yes |
| <a name="input_lock_enable"></a> [lock\_enable](#input\_lock\_enable) | Apply locks to block accedentaly deletions. | `bool` | `false` | no |
| <a name="input_log_analytics_workspace_name"></a> [log\_analytics\_workspace\_name](#input\_log\_analytics\_workspace\_name) | Specifies the name of the Log Analytics Workspace. | `string` | n/a | yes |
| <a name="input_log_analytics_workspace_resource_group_name"></a> [log\_analytics\_workspace\_resource\_group\_name](#input\_log\_analytics\_workspace\_resource\_group\_name) | The name of the resource group in which the Log Analytics workspace is located in. | `string` | n/a | yes |
| <a name="input_monitor_resource_group_name"></a> [monitor\_resource\_group\_name](#input\_monitor\_resource\_group\_name) | Monitor resource group name | `string` | n/a | yes |
| <a name="input_nginx_helm_version"></a> [nginx\_helm\_version](#input\_nginx\_helm\_version) | n/a | `string` | n/a | yes |
| <a name="input_prefix"></a> [prefix](#input\_prefix) | n/a | `string` | n/a | yes |
| <a name="input_tags"></a> [tags](#input\_tags) | n/a | `map(any)` | <pre>{<br>  "CreatedBy": "Terraform"<br>}</pre> | no |
| <a name="input_terraform_remote_state_core"></a> [terraform\_remote\_state\_core](#input\_terraform\_remote\_state\_core) | n/a | <pre>object({<br>    resource_group_name  = string,<br>    storage_account_name = string,<br>    container_name       = string,<br>    key                  = string<br>  })</pre> | n/a | yes |

## Outputs

No outputs.
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
