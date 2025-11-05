# pagoPA-infrastructure

[![Static Analysis](https://github.com/pagopa/pagopa-infra/actions/workflows/static_analysis.yml/badge.svg?branch=main&event=push)](https://github.com/pagopa/pagopa-infra/actions/workflows/static_analysis.yml)

pagoPA project infrastructure

## Requirements

### 1. terraform

In order to manage the suitable version of terraform it is strongly recommended to install the following tool:

- [tfenv](https://github.com/tfutils/tfenv): **Terraform** version manager inspired by rbenv.

Once these tools have been installed, install the terraform version shown in:

- .terraform-version

After installation install terraform:

```sh
tfenv install
```

## Environment management

In order to properly populate terraform variables for each environment, a script located at `src/core/terraform.sh` is provided.

Terraform invocations described here where environent parameters are required can be replaced with invocations to `terraform.sh` by passing an environment specification. For example:

```sh
./terraform.sh plan dev -target=module.api_config
```

**NOTE**: `terraform.sh` must be run from the `src/core` folder.

## Terraform modules

As PagoPA we build our standard Terraform modules, check available modules:

- [PagoPA Terraform modules](https://github.com/search?q=topic%3Aterraform-modules+org%3Apagopa&type=repositories)

## Apply changes

To apply changes follow the standard terraform lifecycle once the code in this repository has been changed:

```sh
terraform init

terraform plan

terraform apply
```

## Terraform lock.hcl

We have both developers who work with your Terraform configuration on their Linux, macOS or Windows workstations and automated systems that apply the configuration while running on Linux.
<https://www.terraform.io/docs/cli/commands/providers/lock.html#specifying-target-platforms>

So we need to specify this in terraform lock providers:

```sh
terraform init

rm .terraform.lock.hcl

terraform providers lock \
  -platform=linux_arm64 \
  -platform=linux_amd64 \
  -platform=darwin_amd64 \
  -platform=darwin_arm64 \
  -platform=windows_amd64
```

## Precommit checks

Check your code before commit.

<https://github.com/antonbabenko/pre-commit-terraform#how-to-install>

```sh
pre-commit run -a
```

## Terraform docs

Autogenerate Terraform documentation

<https://github.com/terraform-docs/terraform-docs#installation>

```sh
terraform-docs markdown . --sort-by required > README.md
```

## Utils

1. Extract cidr subnet from AZ vnet:

`az network vnet subnet list -g pagopa-d-vnet-rg --vnet-name pagopa-d-vnet | grep "\"addressPrefix\"" | xargs -n2 | sort`

<!-- markdownlint-disable -->
<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->

2. Sops MAC mismatch. File has 

To resolve it typing : 

```
sops --ignore-mac ./secret/weu-<ENV>/noedit_secret_enc.json
```

change some stuff into file and save it.

## Requirements

No requirements.

## Modules

No modules.

## Resources

No resources.

## Inputs

No inputs.

## Outputs

No outputs.
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
