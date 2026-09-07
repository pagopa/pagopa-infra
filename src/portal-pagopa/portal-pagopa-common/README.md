# portal-pagopa-core

Base Terraform per deploy di:
- Linux App Service Plan
- Linux Web App container-based con Managed Identity
- Role assignment `AcrPull` su ACR
- PostgreSQL Flexible Server + database
- App settings della Web App con Key Vault references

## Prerequisiti

- Secret applicativi gia presenti nel Key Vault di `portal-pagopa-secrets`
- Secret DB admin presenti nel Key Vault:
  - `db-administrator-login`
  - `db-administrator-login-password`
- Immagine container disponibile su ACR

## Deploy rapido

```bash
cd /Users/fabio.felici/work/pagopa-infra/src/portal-pagopa/portal-pagopa-core
terraform init -backend-config=env/dev/backend.tfvars
terraform plan -var-file=env/dev/terraform.tfvars
terraform apply -var-file=env/dev/terraform.tfvars
```

## Note

- I secret applicativi non vengono messi in chiaro nel Terraform state: la Web App usa Key Vault references.
- Se il nome dei secret non coincide, aggiorna `app_secret_names` nel `terraform.tfvars` dell'ambiente.

