<!-- markdownlint-disable -->
<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_azuread"></a> [azuread](#requirement\_azuread) | <= 2.47.0 |
| <a name="requirement_azurerm"></a> [azurerm](#requirement\_azurerm) | <= 3.110.0 |
| <a name="requirement_helm"></a> [helm](#requirement\_helm) | <= 2.12.1 |
| <a name="requirement_kubernetes"></a> [kubernetes](#requirement\_kubernetes) | <= 2.30 |
| <a name="requirement_local"></a> [local](#requirement\_local) | <= 2.2.3 |
| <a name="requirement_null"></a> [null](#requirement\_null) | <= 3.2.1 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_aks"></a> [aks](#module\_aks) | git::https://github.com/pagopa/terraform-azurerm-v3.git//kubernetes_cluster | v8.90.0 |
| <a name="module_aks_snet"></a> [aks\_snet](#module\_aks\_snet) | git::https://github.com/pagopa/terraform-azurerm-v3.git//subnet | v8.53.0 |
| <a name="module_keda_pod_identity"></a> [keda\_pod\_identity](#module\_keda\_pod\_identity) | git::https://github.com/pagopa/terraform-azurerm-v3.git//kubernetes_pod_identity | v8.53.0 |
| <a name="module_monitoring_pod_identity"></a> [monitoring\_pod\_identity](#module\_monitoring\_pod\_identity) | git::https://github.com/pagopa/terraform-azurerm-v3.git//kubernetes_pod_identity | v8.53.0 |
| <a name="module_nginx_ingress"></a> [nginx\_ingress](#module\_nginx\_ingress) | terraform-module/release/helm | 2.8.0 |
| <a name="module_opencosts"></a> [opencosts](#module\_opencosts) | git::https://github.com/pagopa/terraform-azurerm-v3.git//kubernetes_opencosts | v8.71.0 |
| <a name="module_prometheus_managed_addon"></a> [prometheus\_managed\_addon](#module\_prometheus\_managed\_addon) | git::https://github.com/pagopa/terraform-azurerm-v3.git//kubernetes_prometheus_managed | v8.97.0 |
| <a name="module_tag_config"></a> [tag\_config](#module\_tag\_config) | ../tag_config | n/a |
| <a name="module_tls_checker"></a> [tls\_checker](#module\_tls\_checker) | git::https://github.com/pagopa/terraform-azurerm-v3.git//tls_checker | v8.54.0 |
| <a name="module_tls_checker_workload_identity_configuration"></a> [tls\_checker\_workload\_identity\_configuration](#module\_tls\_checker\_workload\_identity\_configuration) | git::https://github.com/pagopa/terraform-azurerm-v3.git//kubernetes_workload_identity_configuration | v8.54.0 |
| <a name="module_tls_checker_workload_identity_init"></a> [tls\_checker\_workload\_identity\_init](#module\_tls\_checker\_workload\_identity\_init) | git::https://github.com/pagopa/terraform-azurerm-v3.git//kubernetes_workload_identity_init | v8.54.0 |

## Resources

| Name | Type |
|------|------|
| [azurerm_public_ip.aks_outbound](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/public_ip) | resource |
| [azurerm_resource_group.aks_rg](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/resource_group) | resource |
| [azurerm_role_assignment.aks_to_acr](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/role_assignment) | resource |
| [azurerm_role_assignment.keda_monitoring_reader](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/role_assignment) | resource |
| [helm_release.keda](https://registry.terraform.io/providers/hashicorp/helm/latest/docs/resources/release) | resource |
| [helm_release.kube_prometheus_stack](https://registry.terraform.io/providers/hashicorp/helm/latest/docs/resources/release) | resource |
| [helm_release.monitoring_reloader](https://registry.terraform.io/providers/hashicorp/helm/latest/docs/resources/release) | resource |
| [kubernetes_cluster_role.cluster_deployer](https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/resources/cluster_role) | resource |
| [kubernetes_cluster_role.edit_extra](https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/resources/cluster_role) | resource |
| [kubernetes_cluster_role.kube_system_reader](https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/resources/cluster_role) | resource |
| [kubernetes_cluster_role.system_cluster_deployer](https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/resources/cluster_role) | resource |
| [kubernetes_cluster_role.view_extra](https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/resources/cluster_role) | resource |
| [kubernetes_cluster_role_binding.edit_binding](https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/resources/cluster_role_binding) | resource |
| [kubernetes_cluster_role_binding.edit_extra_binding](https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/resources/cluster_role_binding) | resource |
| [kubernetes_cluster_role_binding.view_binding](https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/resources/cluster_role_binding) | resource |
| [kubernetes_cluster_role_binding.view_extra_binding](https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/resources/cluster_role_binding) | resource |
| [kubernetes_manifest.service_monitor](https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/resources/manifest) | resource |
| [kubernetes_namespace.ingress](https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/resources/namespace) | resource |
| [kubernetes_namespace.keda](https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/resources/namespace) | resource |
| [kubernetes_namespace.monitoring](https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/resources/namespace) | resource |
| [kubernetes_secret_v1.prometheus_basic_auth](https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/resources/secret_v1) | resource |
| [azuread_group.adgroup_admin](https://registry.terraform.io/providers/hashicorp/azuread/latest/docs/data-sources/group) | data source |
| [azuread_group.adgroup_developers](https://registry.terraform.io/providers/hashicorp/azuread/latest/docs/data-sources/group) | data source |
| [azuread_group.adgroup_externals](https://registry.terraform.io/providers/hashicorp/azuread/latest/docs/data-sources/group) | data source |
| [azuread_group.adgroup_operations](https://registry.terraform.io/providers/hashicorp/azuread/latest/docs/data-sources/group) | data source |
| [azuread_group.adgroup_security](https://registry.terraform.io/providers/hashicorp/azuread/latest/docs/data-sources/group) | data source |
| [azuread_group.adgroup_technical_project_managers](https://registry.terraform.io/providers/hashicorp/azuread/latest/docs/data-sources/group) | data source |
| [azurerm_application_insights.application_insights](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/application_insights) | data source |
| [azurerm_client_config.current](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/client_config) | data source |
| [azurerm_container_registry.acr](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/container_registry) | data source |
| [azurerm_key_vault.kv](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/key_vault) | data source |
| [azurerm_log_analytics_workspace.log_analytics](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/log_analytics_workspace) | data source |
| [azurerm_monitor_action_group.email](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/monitor_action_group) | data source |
| [azurerm_monitor_action_group.opsgenie](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/monitor_action_group) | data source |
| [azurerm_monitor_action_group.slack](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/monitor_action_group) | data source |
| [azurerm_monitor_workspace.workspace](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/monitor_workspace) | data source |
| [azurerm_resource_group.monitor_rg](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/resource_group) | data source |
| [azurerm_resource_group.vnet_core_rg](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/resource_group) | data source |
| [azurerm_resource_group.vnet_integration_rg](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/resource_group) | data source |
| [azurerm_subscription.current](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/subscription) | data source |
| [azurerm_virtual_network.vnet](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/virtual_network) | data source |
| [azurerm_virtual_network.vnet_integration](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/virtual_network) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_aks_alerts_enabled"></a> [aks\_alerts\_enabled](#input\_aks\_alerts\_enabled) | AKS alerts enabled? | `bool` | `false` | no |
| <a name="input_aks_cidr_subnet"></a> [aks\_cidr\_subnet](#input\_aks\_cidr\_subnet) | Aks network address space. | `list(string)` | n/a | yes |
| <a name="input_aks_enable_workload_identity"></a> [aks\_enable\_workload\_identity](#input\_aks\_enable\_workload\_identity) | n/a | `bool` | `false` | no |
| <a name="input_aks_kubernetes_version"></a> [aks\_kubernetes\_version](#input\_aks\_kubernetes\_version) | Kubernetes version specified when creating the AKS managed cluster. | `string` | `"1.22.6"` | no |
| <a name="input_aks_num_outbound_ips"></a> [aks\_num\_outbound\_ips](#input\_aks\_num\_outbound\_ips) | How many outbound ips allocate for AKS cluster | `number` | `1` | no |
| <a name="input_aks_private_cluster_is_enabled"></a> [aks\_private\_cluster\_is\_enabled](#input\_aks\_private\_cluster\_is\_enabled) | Allow to configure the AKS, to be setup as a private cluster. To reach it, you need to use an internal VM or VPN | `bool` | `true` | no |
| <a name="input_aks_sku_tier"></a> [aks\_sku\_tier](#input\_aks\_sku\_tier) | The SKU Tier that should be used for this Kubernetes Cluster. Possible values are Free and Paid (which includes the Uptime SLA). | `string` | n/a | yes |
| <a name="input_aks_system_node_pool"></a> [aks\_system\_node\_pool](#input\_aks\_system\_node\_pool) | AKS node pool system configuration | <pre>object({<br/>    name                         = string,<br/>    vm_size                      = string,<br/>    os_disk_type                 = string,<br/>    os_disk_size_gb              = string,<br/>    node_count_min               = number,<br/>    node_count_max               = number,<br/>    only_critical_addons_enabled = bool,<br/>    node_labels                  = map(any),<br/>    node_tags                    = map(any)<br/>  })</pre> | n/a | yes |
| <a name="input_aks_user_node_pool"></a> [aks\_user\_node\_pool](#input\_aks\_user\_node\_pool) | AKS node pool user configuration | <pre>object({<br/>    enabled         = bool,<br/>    name            = string,<br/>    vm_size         = string,<br/>    os_disk_type    = string,<br/>    os_disk_size_gb = string,<br/>    node_count_min  = number,<br/>    node_count_max  = number,<br/>    node_labels     = map(any),<br/>    node_taints     = list(string),<br/>    node_tags       = map(any)<br/>  })</pre> | n/a | yes |
| <a name="input_domain"></a> [domain](#input\_domain) | n/a | `string` | n/a | yes |
| <a name="input_env"></a> [env](#input\_env) | n/a | `string` | n/a | yes |
| <a name="input_env_short"></a> [env\_short](#input\_env\_short) | n/a | `string` | n/a | yes |
| <a name="input_ingress_load_balancer_ip"></a> [ingress\_load\_balancer\_ip](#input\_ingress\_load\_balancer\_ip) | n/a | `string` | n/a | yes |
| <a name="input_ingress_max_replica_count"></a> [ingress\_max\_replica\_count](#input\_ingress\_max\_replica\_count) | n/a | `string` | n/a | yes |
| <a name="input_ingress_min_replica_count"></a> [ingress\_min\_replica\_count](#input\_ingress\_min\_replica\_count) | n/a | `string` | n/a | yes |
| <a name="input_k8s_kube_config_path_prefix"></a> [k8s\_kube\_config\_path\_prefix](#input\_k8s\_kube\_config\_path\_prefix) | n/a | `string` | `"~/.kube"` | no |
| <a name="input_keda_helm"></a> [keda\_helm](#input\_keda\_helm) | keda helm chart configuration | <pre>object({<br/>    chart_version = string,<br/>    keda = object({<br/>      image_name = string,<br/>      image_tag  = string,<br/>    }),<br/>    metrics_api_server = object({<br/>      image_name = string,<br/>      image_tag  = string,<br/>    }),<br/>  })</pre> | n/a | yes |
| <a name="input_kube_prometheus_stack_helm"></a> [kube\_prometheus\_stack\_helm](#input\_kube\_prometheus\_stack\_helm) | kube-prometheus-stack helm chart configuration | <pre>object({<br/>    chart_version = string,<br/>    values_file   = string<br/>  })</pre> | n/a | yes |
| <a name="input_location"></a> [location](#input\_location) | One of westeurope, northeurope | `string` | n/a | yes |
| <a name="input_location_short"></a> [location\_short](#input\_location\_short) | One of wue, neu | `string` | n/a | yes |
| <a name="input_location_string"></a> [location\_string](#input\_location\_string) | One of West Europe, North Europe | `string` | n/a | yes |
| <a name="input_lock_enable"></a> [lock\_enable](#input\_lock\_enable) | Apply locks to block accedentaly deletions. | `bool` | `false` | no |
| <a name="input_log_analytics_workspace_name"></a> [log\_analytics\_workspace\_name](#input\_log\_analytics\_workspace\_name) | Specifies the name of the Log Analytics Workspace. | `string` | n/a | yes |
| <a name="input_log_analytics_workspace_resource_group_name"></a> [log\_analytics\_workspace\_resource\_group\_name](#input\_log\_analytics\_workspace\_resource\_group\_name) | The name of the resource group in which the Log Analytics workspace is located in. | `string` | n/a | yes |
| <a name="input_monitor_resource_group_name"></a> [monitor\_resource\_group\_name](#input\_monitor\_resource\_group\_name) | Monitor resource group name | `string` | n/a | yes |
| <a name="input_nginx_helm"></a> [nginx\_helm](#input\_nginx\_helm) | nginx ingress helm chart configuration | <pre>object({<br/>    version = string,<br/>    controller = object({<br/>      image = object({<br/>        registry     = string,<br/>        image        = string,<br/>        tag          = string,<br/>        digest       = string,<br/>        digestchroot = string,<br/>      }),<br/>      resources = object({<br/>        requests = object({<br/>          memory : string<br/>        })<br/>      }),<br/>      config = object({<br/>        proxy-body-size : string<br/>      })<br/>    })<br/>  })</pre> | n/a | yes |
| <a name="input_prefix"></a> [prefix](#input\_prefix) | n/a | `string` | n/a | yes |
| <a name="input_prometheus_basic_auth_file"></a> [prometheus\_basic\_auth\_file](#input\_prometheus\_basic\_auth\_file) | n/a | `string` | n/a | yes |
| <a name="input_reloader_helm"></a> [reloader\_helm](#input\_reloader\_helm) | reloader helm chart configuration | <pre>object({<br/>    chart_version = string,<br/>    image_name    = string,<br/>    image_tag     = string<br/>  })</pre> | n/a | yes |
| <a name="input_skip_metric_validation"></a> [skip\_metric\_validation](#input\_skip\_metric\_validation) | (Optional) Skip the metric validation to allow creating an alert rule on a custom metric that isn't yet emitted? Defaults to false. | `bool` | `false` | no |
| <a name="input_subnet_private_endpoint_network_policies_enabled"></a> [subnet\_private\_endpoint\_network\_policies\_enabled](#input\_subnet\_private\_endpoint\_network\_policies\_enabled) | (Optional) Enable or Disable network policies for the private endpoint on the subnet. Setting this to true will Enable the policy and setting this to false will Disable the policy. Defaults to false. | `bool` | `false` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | n/a | `map(any)` | <pre>{<br/>  "CreatedBy": "Terraform"<br/>}</pre> | no |
| <a name="input_tls_checker_https_endpoints_to_check"></a> [tls\_checker\_https\_endpoints\_to\_check](#input\_tls\_checker\_https\_endpoints\_to\_check) | List of https endpoint to check ssl certificate and his alert name | <pre>list(object({<br/>    https_endpoint = string<br/>    # max 53 chars, alfanumeric and '-', and lower case<br/>    alert_name    = string<br/>    alert_enabled = bool<br/>    helm_present  = bool<br/>  }))</pre> | `[]` | no |

## Outputs

No outputs.
<!-- END_TF_DOCS -->
