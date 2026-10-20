## Integration test runner PostgreSQL to ADX synchronization

The `pagopa-platform-integration-test` self-hosted runner runs in a Container Apps
Job named `pagopa-<env_short>-qa-int-test-ca-job`, in `pagopa-<env_short>-identity-rg`.
Only its system-assigned managed identity receives Kusto **Database Admin** on
database `re`, via `azurerm_kusto_database_principal_assignment` with role `Admin`
and principal type `App`. This is a data-plane role, not Azure IAM Contributor
or Owner. No cluster-wide roles or Azure IAM privileges are added, and the
shared GitHub OIDC deployment identity is not modified.

Configure `qa_integration_runner_adx_ingestion` in each environment's tfvars with
`enabled = true`. Terraform looks up the job's service principal in Entra ID by
its display name (`pagopa-<env_short>-qa-int-test-ca-job`) and uses its object ID
for the ADX database role assignment. The lookup requires the AzureAD provider
identity to have permission to read service principals in the tenant. The flag
enables both staging provisioning and Database Admin access.

| Environment | Job display name | Status |
|-------------|------------------|--------|
| dev | `pagopa-d-qa-int-test-ca-job` | Enabled |
| uat | `pagopa-u-qa-int-test-ca-job` | Enabled |
| prod | `pagopa-p-qa-int-test-ca-job` | Explicitly disabled |

The assignment uses the authenticated tenant from `azurerm_client_config.current`.

### Staging and publication

The separate staging script runs after the existing final-table script and
creates these empty tables using `.create table ... based-on ... ifnotexists`:

| Staging table | Schema source |
|---------------|---------------|
| `QA_NRT_TEST_SUITES_STAGING` | `QA_NRT_TEST_SUITES` |
| `QA_NRT_TEST_RUNS_STAGING` | `QA_NRT_TEST_RUNS` |
| `QA_NRT_TEST_EXECUTIONS_STAGING` | `QA_NRT_TEST_EXECUTIONS` |

This copies the actual source schema, including column names, types, and order,
without copying rows or modifying the final tables. Kusto does not copy update
policies or authorized principals with `based-on`. No automatic publication
policy is introduced. Existing staging tables and their data are left unchanged:
compare schemas before synchronization if they already exist or final schemas
change later; this creation script does not reconcile existing staging schemas.

The workflow owns staging ingestion and cleanup, count checks, `.replace extents`,
`.move extents`, and temporal `.delete table ... records` operations. Provisioning
does not execute these data-changing commands.

The workflow's ingestion client must explicitly authenticate with the job's
system-assigned managed identity, for example using the Kusto SDK's managed
identity authentication. A GitHub OIDC login to the shared deployment identity
does not authenticate as the job identity. No client secret is required.
For queued ingestion, verify connectivity to the ingestion endpoint and the
staging resources used by the ingestion SDK, not only the query endpoint.

### Migration from Table Ingestor

The previous `integration_runner_table_ingestors` Terraform script resource is
removed. If it is in state, the plan will delete the ARM script resource, **not**
its existing grants. If it was never applied, there is no script to delete.
Database Admin supersedes the runner's three Table Ingestor grants.

After the approved environment's Admin assignment is applied and verified, an
authorized operator must explicitly run the following commands in database `re`,
replacing `<principal_id>` with the object ID returned by the AzureAD lookup for
that environment:

```kusto
.drop table QA_NRT_TEST_SUITES ingestors ('aadapp=<principal_id>;7788edaf-0346-4068-9d79-c868aed15b3d')
.drop table QA_NRT_TEST_RUNS ingestors ('aadapp=<principal_id>;7788edaf-0346-4068-9d79-c868aed15b3d')
.drop table QA_NRT_TEST_EXECUTIONS ingestors ('aadapp=<principal_id>;7788edaf-0346-4068-9d79-c868aed15b3d')
```

These commands revoke only the named principal's redundant grants; they neither
delete tables/records nor modify grants belonging to other principals. They are
a required migration step if the old grants exist, not an effect of deleting
the script. ARM Kusto scripts do not support `.drop` commands, so this cleanup
is deliberately not hidden in a provisioning script or a local-exec provisioner.
No revocation commands are executed as part of preparing the plan.

### Identity lifecycle and verification

If the runner job is recreated, re-read its system-assigned identity's object ID
and tenant, update the environment's tfvars, and review a new plan. Terraform
replaces its managed Database Admin assignment when the object ID changes,
removing the old assignment. Also explicitly revoke any old table grants using
the commands above with the **old** principal ID; check for manually granted
database/cluster roles before considering the old identity fully revoked.
Disabling the configuration removes the managed Admin assignment, but does not
drop staging tables or revoke historical script-created grants.

Run `terraform validate` and plan from this domain directory, with the correct
environment's backend and subscription. In this phase plan **dev only**; neither
apply dev nor plan/apply UAT without the required approval. Prod stays disabled.
Review that the final-table script/content is unchanged, only the new staging
script and database-scoped assignment are added, and only the retired permissions
script may be deleted. Do not apply unrelated changes.

After rollout, use read-only `.show database re principals`,
`.show table <table_name> principals`, and `.show table <table_name> schema as json`
to verify the intended principal and matching final/staging schemas. Coordinate
any functional synchronization tests separately; do not test extent replacement
or soft delete against existing data during infrastructure validation.

The previous test expecting ingestion into an unrelated table in `re` to be
denied is **no longer valid**: Database Admin intentionally grants access to the
entire database, including reads, ingestion, schema administration, extent
operations, and soft delete. This configuration grants no rights on other databases.

### Preparation results (2026-10-15)

- `terraform fmt -check -diff` on the changed Terraform files: passed.
- `git diff --check`: passed.
- `terraform validate` from this directory: passed.
- Full dev plan: failed because the private PostgreSQL hostname used by Superset
  could not be resolved from the current environment. It also detected an unrelated
  Web App image change from tag `298129` to `latest`; do not apply that change here.
- Dev plan targeting `azurerm_kusto_script.create_staging_tables[0]` and
  `azurerm_kusto_database_principal_assignment.integration_runner_admin[0]`:
  passed, **2 to add, 0 to change, 0 to destroy**. The final-table script is unchanged.
  The saved plan was also checked for the exact staging commands, dev object ID,
  tenant, database, and Admin role. This is an exceptional, partial plan, not a
  successful full-domain plan; it does not cover retirement of an old permissions
  script if one exists outside its dependency graph.
- No apply, UAT plan, grant revocation, or data-changing tests were executed.
  A complete plan must be rerun from an environment with private PostgreSQL DNS
  and connectivity before a full-domain rollout.

References: [Kusto managed identity authentication](https://learn.microsoft.com/en-us/kusto/api/get-started/app-authentication-methods?view=azure-data-explorer)
and [table security roles](https://learn.microsoft.com/en-us/kusto/management/manage-table-security-roles?view=azure-data-explorer),
[empty table cloning](https://learn.microsoft.com/en-us/kusto/management/create-table-based-on-command?view=azure-data-explorer),
and [ARM Kusto script limitations](https://learn.microsoft.com/en-us/azure/data-explorer/database-script).

## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.6.0 |
| <a name="requirement_azuread"></a> [azuread](#requirement\_azuread) | ~> 3.1.0 |
| <a name="requirement_azurerm"></a> [azurerm](#requirement\_azurerm) | ~> 4.16 |
| <a name="requirement_helm"></a> [helm](#requirement\_helm) | ~> 2.16 |
| <a name="requirement_kubernetes"></a> [kubernetes](#requirement\_kubernetes) | ~> 2.33 |
| <a name="requirement_null"></a> [null](#requirement\_null) | <= 3.2.3 |
| <a name="requirement_postgresql"></a> [postgresql](#requirement\_postgresql) | ~> 1.26 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_azurerm"></a> [azurerm](#provider\_azurerm) | 4.81.0 |
| <a name="provider_helm"></a> [helm](#provider\_helm) | 2.17.0 |
| <a name="provider_kubernetes"></a> [kubernetes](#provider\_kubernetes) | 2.38.0 |
| <a name="provider_postgresql"></a> [postgresql](#provider\_postgresql) | 1.27.0 |
| <a name="provider_random"></a> [random](#provider\_random) | 3.9.0 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module___v4__"></a> [\_\_v4\_\_](#module\_\_\_v4\_\_) | git::https://github.com/pagopa/terraform-azurerm-v4 | 0c7bdec9a6ec5bc89bff9f8ca2758ebfeebe6b9c |
| <a name="module_apim_mcp_server_api"></a> [apim\_mcp\_server\_api](#module\_apim\_mcp\_server\_api) | ./.terraform/modules/__v4__/api_management_api | n/a |
| <a name="module_apim_mcp_server_product"></a> [apim\_mcp\_server\_product](#module\_apim\_mcp\_server\_product) | ./.terraform/modules/__v4__/api_management_product | n/a |
| <a name="module_apim_qa_central_hub_api"></a> [apim\_qa\_central\_hub\_api](#module\_apim\_qa\_central\_hub\_api) | ./.terraform/modules/__v4__/api_management_api | n/a |
| <a name="module_apim_qa_central_hub_product"></a> [apim\_qa\_central\_hub\_product](#module\_apim\_qa\_central\_hub\_product) | ./.terraform/modules/__v4__/api_management_product | n/a |
| <a name="module_cert_mounter"></a> [cert\_mounter](#module\_cert\_mounter) | ./.terraform/modules/__v4__/cert_mounter | n/a |
| <a name="module_cert_mounter_mcp_server"></a> [cert\_mounter\_mcp\_server](#module\_cert\_mounter\_mcp\_server) | ./.terraform/modules/__v4__/cert_mounter | n/a |
| <a name="module_cert_mounter_qa_central_hub"></a> [cert\_mounter\_qa\_central\_hub](#module\_cert\_mounter\_qa\_central\_hub) | ./.terraform/modules/__v4__/cert_mounter | n/a |
| <a name="module_gh_runner_job"></a> [gh\_runner\_job](#module\_gh\_runner\_job) | ./.terraform/modules/__v4__/gh_runner_container_app_job_domain_setup | n/a |
| <a name="module_kubernetes_service_account"></a> [kubernetes\_service\_account](#module\_kubernetes\_service\_account) | ./.terraform/modules/__v4__/kubernetes_service_account | n/a |
| <a name="module_qa_hub_app_service"></a> [qa\_hub\_app\_service](#module\_qa\_hub\_app\_service) | ./.terraform/modules/__v4__/IDH/app_service_webapp | n/a |
| <a name="module_tag_config"></a> [tag\_config](#module\_tag\_config) | ../../tag_config | n/a |
| <a name="module_workload_identity"></a> [workload\_identity](#module\_workload\_identity) | ./.terraform/modules/__v4__/kubernetes_workload_identity_configuration | n/a |

## Resources

| Name | Type |
|------|------|
| [azurerm_api_management_api_version_set.mcp_server_api](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/api_management_api_version_set) | resource |
| [azurerm_api_management_api_version_set.qa_central_hub_api](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/api_management_api_version_set) | resource |
| [azurerm_api_management_backend.mcp_server](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/api_management_backend) | resource |
| [azurerm_api_management_backend.qa_central_hub](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/api_management_backend) | resource |
| [azurerm_key_vault_certificate.mcp_server_ingress](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/key_vault_certificate) | resource |
| [azurerm_key_vault_certificate.qa_central_hub_ingress](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/key_vault_certificate) | resource |
| [azurerm_key_vault_secret.aks_apiserver_url](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/key_vault_secret) | resource |
| [azurerm_key_vault_secret.application_insights_connection_string](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/key_vault_secret) | resource |
| [azurerm_key_vault_secret.azure_devops_sa_cacrt](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/key_vault_secret) | resource |
| [azurerm_key_vault_secret.azure_devops_sa_token](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/key_vault_secret) | resource |
| [azurerm_key_vault_secret.tenant_id](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/key_vault_secret) | resource |
| [azurerm_postgresql_flexible_server_database.superset](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/postgresql_flexible_server_database) | resource |
| [azurerm_private_dns_a_record.ingress](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/private_dns_a_record) | resource |
| [azurerm_private_dns_a_record.ingress_superset](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/private_dns_a_record) | resource |
| [azurerm_private_dns_a_record.mcp_server_ingress](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/private_dns_a_record) | resource |
| [azurerm_resource_group.qa_hub_rg](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/resource_group) | resource |
| [azurerm_role_assignment.qa_hub_app_service_acr_pull](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/role_assignment) | resource |
| [helm_release.reloader](https://registry.terraform.io/providers/hashicorp/helm/latest/docs/resources/release) | resource |
| [kubernetes_namespace.namespace](https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/resources/namespace) | resource |
| [kubernetes_namespace.namespace_system](https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/resources/namespace) | resource |
| [kubernetes_pod_disruption_budget_v1.qa_pdb](https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/resources/pod_disruption_budget_v1) | resource |
| [kubernetes_role_binding.deployer_binding](https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/resources/role_binding) | resource |
| [kubernetes_role_binding.system_deployer_binding](https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/resources/role_binding) | resource |
| [kubernetes_secret.superset](https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/resources/secret) | resource |
| [postgresql_grant.superset_user_grant](https://registry.terraform.io/providers/cyrilgdn/postgresql/latest/docs/resources/grant) | resource |
| [postgresql_grant.superset_user_grant_on_db](https://registry.terraform.io/providers/cyrilgdn/postgresql/latest/docs/resources/grant) | resource |
| [postgresql_grant.superset_user_grant_on_tables](https://registry.terraform.io/providers/cyrilgdn/postgresql/latest/docs/resources/grant) | resource |
| [postgresql_role.superset_user](https://registry.terraform.io/providers/cyrilgdn/postgresql/latest/docs/resources/role) | resource |
| [random_password.db_user_superset_psw](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/password) | resource |
| [random_password.superset_admin_user_psw](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/password) | resource |
| [random_password.superset_random_key](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/password) | resource |
| [azurerm_api_management.apim](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/api_management) | data source |
| [azurerm_application_insights.application_insights](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/application_insights) | data source |
| [azurerm_client_config.current](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/client_config) | data source |
| [azurerm_container_registry.qa_hub_acr](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/container_registry) | data source |
| [azurerm_key_vault.key_vault](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/key_vault) | data source |
| [azurerm_key_vault_secret.pgres_flex_admin_login](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/key_vault_secret) | data source |
| [azurerm_key_vault_secret.pgres_flex_admin_pwd](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/key_vault_secret) | data source |
| [azurerm_key_vault_secret.qa_hub_google_client_id](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/key_vault_secret) | data source |
| [azurerm_key_vault_secret.qa_hub_google_client_secret](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/key_vault_secret) | data source |
| [azurerm_key_vault_secret.qa_hub_nextauth_secret](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/key_vault_secret) | data source |
| [azurerm_kubernetes_cluster.aks](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/kubernetes_cluster) | data source |
| [azurerm_log_analytics_workspace.log_analytics_workspace](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/log_analytics_workspace) | data source |
| [azurerm_managed_redis.qa_redis](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/managed_redis) | data source |
| [azurerm_monitor_action_group.email](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/monitor_action_group) | data source |
| [azurerm_monitor_action_group.slack](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/monitor_action_group) | data source |
| [azurerm_postgresql_flexible_server.qa_postgresql](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/postgresql_flexible_server) | data source |
| [azurerm_private_dns_zone.azurewebsites](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/private_dns_zone) | data source |
| [azurerm_private_dns_zone.internal](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/private_dns_zone) | data source |
| [azurerm_resource_group.identity_rg](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/resource_group) | data source |
| [azurerm_resource_group.monitor_rg](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/resource_group) | data source |
| [azurerm_subscription.current](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/subscription) | data source |
| [azurerm_virtual_network.hub_vnet](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/virtual_network) | data source |
| [azurerm_virtual_network.spoke_compute_vnet](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/virtual_network) | data source |
| [azurerm_virtual_network.spoke_data_vnet](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/virtual_network) | data source |
| [azurerm_virtual_network.spoke_security_vnet](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/virtual_network) | data source |
| [azurerm_virtual_network.spoke_streaming_vnet](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/virtual_network) | data source |
| [azurerm_virtual_network.spoke_tools_vnet](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/virtual_network) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_env"></a> [env](#input\_env) | n/a | `string` | n/a | yes |
| <a name="input_env_short"></a> [env\_short](#input\_env\_short) | n/a | `string` | n/a | yes |
| <a name="input_ingress_load_balancer_ip"></a> [ingress\_load\_balancer\_ip](#input\_ingress\_load\_balancer\_ip) | The AKS internal ingress load balancer IP. | `string` | n/a | yes |
| <a name="input_location"></a> [location](#input\_location) | One of .. | `string` | n/a | yes |
| <a name="input_location_short"></a> [location\_short](#input\_location\_short) | One of ... | `string` | n/a | yes |
| <a name="input_qa_hub_autoscale_settings"></a> [qa\_hub\_autoscale\_settings](#input\_qa\_hub\_autoscale\_settings) | Autoscale settings for qa-hub | <pre>object({<br/>    max_capacity                       = number                 # maximum capacity for this app service<br/>    scale_up_requests_threshold        = optional(number, null) # request count threshold which triggers scale up<br/>    scale_down_requests_threshold      = optional(number, null) # request count threshold which triggers scale down<br/>    scale_up_response_time_threshold   = optional(number, null) # response time threshold which triggers scale up<br/>    scale_down_response_time_threshold = optional(number, null) # response time threshold which triggers scale down<br/>    scale_up_cpu_threshold             = optional(number, null) # cpu threshold which triggers scale up<br/>    scale_down_cpu_threshold           = optional(number, null) # cpu threshold which triggers scale down<br/>  })</pre> | n/a | yes |
| <a name="input_qa_hub_image"></a> [qa\_hub\_image](#input\_qa\_hub\_image) | Docker image settings for qa-hub | <pre>object({<br/>    docker_image        = string<br/>    docker_image_tag    = string<br/>    docker_registry_url = string<br/>  })</pre> | n/a | yes |
| <a name="input_qa_hub_next_auth_url"></a> [qa\_hub\_next\_auth\_url](#input\_qa\_hub\_next\_auth\_url) | n/a | `string` | n/a | yes |
| <a name="input_qa_hub_plan_idh_tier"></a> [qa\_hub\_plan\_idh\_tier](#input\_qa\_hub\_plan\_idh\_tier) | The IDH resource tier for qa-hub | `string` | n/a | yes |
| <a name="input_qa_hub_public_api_url"></a> [qa\_hub\_public\_api\_url](#input\_qa\_hub\_public\_api\_url) | n/a | `string` | n/a | yes |
| <a name="input_apim_dns_zone_prefix"></a> [apim\_dns\_zone\_prefix](#input\_apim\_dns\_zone\_prefix) | The dns subdomain for apim. | `string` | `null` | no |
| <a name="input_dns_zone_internal_prefix"></a> [dns\_zone\_internal\_prefix](#input\_dns\_zone\_internal\_prefix) | The dns subdomain. | `string` | `null` | no |
| <a name="input_dns_zone_prefix"></a> [dns\_zone\_prefix](#input\_dns\_zone\_prefix) | The wallet dns subdomain. | `string` | `null` | no |
| <a name="input_enabled_superset"></a> [enabled\_superset](#input\_enabled\_superset) | Enable Superset deployment | `bool` | `false` | no |
| <a name="input_external_domain"></a> [external\_domain](#input\_external\_domain) | Domain for delegation | `string` | `null` | no |
| <a name="input_k8s_kube_config_path_prefix"></a> [k8s\_kube\_config\_path\_prefix](#input\_k8s\_kube\_config\_path\_prefix) | n/a | `string` | `"~/.kube"` | no |
| <a name="input_pod_disruption_budgets"></a> [pod\_disruption\_budgets](#input\_pod\_disruption\_budgets) | Pod disruption budget for domain namespace | <pre>map(object({<br/>    name         = optional(string, null)<br/>    minAvailable = optional(number, null)<br/>    matchLabels  = optional(map(any), {})<br/>  }))</pre> | `{}` | no |
| <a name="input_qa_hub_always_on"></a> [qa\_hub\_always\_on](#input\_qa\_hub\_always\_on) | Specifies whether the Web App is in Always On mode. Default is false. | `bool` | `true` | no |

## Outputs

No outputs.
