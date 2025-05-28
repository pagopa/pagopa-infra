locals {
  tags = {
    CreatedBy   = "Terraform"
    Environment = title(var.environment)
    Owner       = "pagoPA"
    Source      = "https://github.com/pagopa/pagopa-infra"
    # isolates the module working folder, removing the absolute path leading to the cwd and the leading slash
    Folder     = trimprefix(replace(path.cwd, dirname(path.cwd), ""), "/")
    CostCenter = "TS310 - PAGAMENTI & SERVIZI"
    domain     = var.domain
  }
}
