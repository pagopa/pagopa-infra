variable "location" {
  type    = string
  default = "westeurope"
}

variable "prefix" {
  type    = string
  default = "prefix_template"
}

variable "env_short" {
  type = string
}

variable "tags" {
  type = map(any)
  default = {
    CreatedBy = "Terraform"
  }
}
variable "app_service_certificate_name" {
  type        = string
  description = "Name of the SSL/TLS certificate for the App Service"
}
