variable "env_short" {
  type = string
  validation {
    condition = (
      length(var.env_short) == 1
    )
    error_message = "Length must be 1 chars."
  }
}

variable "env" {
  type = string
}

variable "location_short" {
  type = string
  validation {
    condition = (
      length(var.location_short) == 3
    )
    error_message = "Length must be 3 chars."
  }
  description = "One of wue, neu"
}

variable "location" {
  type    = string
  default = "italynorth"
}

variable "tags" {
  type        = map(string)
  description = "Audit Log Solution"
  default = {
    CreatedBy   = "Terraform"
    Description = "Test with object replication"
  }
}

variable "prefix" {
  description = "Resorce prefix"
  type        = string
  default     = "adl-t-itn"
}
