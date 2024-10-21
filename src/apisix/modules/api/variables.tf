variable "enabled" {
  type    = bool
  default = true
}

variable "apisix_admin_base_path" {
  type = string
}

variable "admin_token" {
  type = string
}

variable "services" {
  type = map(object({
    name      = string
    base_path = string
    nodes     = optional(map(number), {})
    scheme    = optional(string, "https")
    plugins   = optional(string, "{}") # json
  }))
  default = {}
}

variable "routes" {
  type = list(object({
    name     = string
    uris     = list(string)
    methods  = list(string)
    service  = string
    # desc     = optional(string)
    # vars     = optional(list(any))
    # priority = optional(number)
    plugins   = optional(string) # json
  }))
  default = []
}
