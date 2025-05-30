locals {
  cwd_split       = split("/", path.cwd)
  src_idx         = index(local.cwd_split, "src")
  relative_folder = join("/", slice(local.cwd_split, local.src_idx + 1, length(local.cwd_split)))
  tags = {
    CreatedBy   = "Terraform"
    Environment = title(var.environment)
    Owner       = "pagoPA"
    Source      = "https://github.com/pagopa/pagopa-infra/tree/main/src/${local.relative_folder}"
    # isolates the module working folder, removing the absolute path leading to the cwd and the leading slash
    Folder     = local.relative_folder
    CostCenter = "TS310 - PAGAMENTI & SERVIZI"
    domain     = var.domain
  }
}
