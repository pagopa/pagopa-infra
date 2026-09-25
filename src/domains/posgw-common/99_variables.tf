variable "env" {
  type = string
}

variable "env_short" {
  type = string
  validation {
    condition = (
      length(var.env_short) == 1
    )
    error_message = "Length must be 1 chars."
  }
}

variable "location" {
  type        = string
  description = "One of westeurope, northeurope"
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
  default     = "itn"
}

variable "dns_zone_internal_prefix" {
  type        = string
  default     = null
  description = "The dns subdomain."
}

variable "external_domain" {
  type        = string
  default     = null
  description = "Domain for delegation"
}

variable "alert_use_opsgenie" {
  type        = bool
  default     = true
  description = "Use opsgenie for alerts"
}

variable "redis_idh_resource_tier" {
  type        = string
  description = "The IDH resource tier for the Redis cache."
}


variable "cosmos_idh_resource_tier" {
  type        = string
  description = "The IDH resource tier for the cosmosdb "
}

variable "cosmos_mongo_db_params" {
  type = object({
    capabilities = list(string)
  })
}

variable "cosmos_mongo_db_pos_gateway_params" {
  type = object({
    enable_autoscaling = bool
    enable_serverless  = bool
    throughput         = number
    max_throughput     = number
  })
}

variable "servicebus_queues" {
  description = "A list of Service Bus Queues to add to the shared namespace."
  type = list(object({
    name                                    = string
    auto_delete_on_idle                     = optional(string)
    batched_operations_enabled              = optional(bool)
    dead_lettering_on_message_expiration    = optional(bool)
    default_message_ttl                     = optional(string)
    duplicate_detection_history_time_window = optional(string)
    express_enabled                         = optional(bool)
    forward_dead_lettered_messages_to       = optional(string)
    forward_to                              = optional(string)
    lock_duration                           = optional(string)
    max_delivery_count                      = optional(number)
    max_message_size_in_kilobytes           = optional(number)
    max_size_in_megabytes                   = optional(number)
    partitioning_enabled                    = optional(bool)
    requires_duplicate_detection            = optional(bool)
    requires_session                        = optional(bool)
    status                                  = optional(string)
    keys = list(object({
      name   = string
      listen = optional(bool)
      send   = optional(bool)
      manage = optional(bool)
    }))
  }))
  default = []
}

variable "servicebus_topics" {
  description = "A list of Service Bus Topics to add to the shared namespace."
  type = list(object({
    name                                    = string
    status                                  = optional(string)
    auto_delete_on_idle                     = optional(string)
    default_message_ttl                     = optional(string)
    duplicate_detection_history_time_window = optional(string)
    batched_operations_enabled              = optional(bool)
    express_enabled                         = optional(bool)
    partitioning_enabled                    = optional(bool)
    max_message_size_in_kilobytes           = optional(number)
    max_size_in_megabytes                   = optional(number)
    requires_duplicate_detection            = optional(bool)
    support_ordering                        = optional(bool)
    subscriptions = optional(list(object({
      name                                      = string
      max_delivery_count                        = number
      auto_delete_on_idle                       = optional(string)
      default_message_ttl                       = optional(string)
      lock_duration                             = optional(string)
      dead_lettering_on_message_expiration      = optional(bool)
      dead_lettering_on_filter_evaluation_error = optional(bool)
      batched_operations_enabled                = optional(bool)
      requires_session                          = optional(bool)
      forward_to                                = optional(string)
      forward_dead_lettered_messages_to         = optional(string)
      status                                    = optional(string)
      client_scoped_subscription_enabled        = optional(bool)
      client_scoped_subscription = optional(object({
        client_id                               = optional(string)
        is_client_scoped_subscription_shareable = optional(bool)
        is_client_scoped_subscription_durable   = optional(bool)
      }))
      rules = optional(list(object({
        name        = string
        filter_type = string
        sql_filter  = optional(string)
        action      = optional(string)
        correlation_filter = optional(object({
          content_type        = optional(string)
          correlation_id      = optional(string)
          label               = optional(string)
          message_id          = optional(string)
          reply_to            = optional(string)
          reply_to_session_id = optional(string)
          session_id          = optional(string)
          to                  = optional(string)
          properties          = optional(map(string), {})
        }))
      })), [])
    })), [])
    keys = list(object({
      name   = string
      listen = optional(bool)
      send   = optional(bool)
      manage = optional(bool)
    }))
  }))
  default = []
}
