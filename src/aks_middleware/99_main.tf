terraform {
  required_version = ">= 1.9.0"
}


module "__v4__" {
  # v8.83.1
  source = "git::https://github.com/pagopa/terraform-azurerm-v4?ref=PAYMCLOUD-1358_aks_middleware_refactor"
}

