terraform {
  required_version = ">= 1.9.0"
}


module "__v4__" {
  # v10.46.0
  source = "git::https://github.com/pagopa/terraform-azurerm-v4?ref=588ea917b4c495e1b6af2b955a154d2de6d94a43"
}

