env_short      = "d"
env            = "dev"
location       = "italynorth"
location_short = "itn"



external_domain          = "pagopa.it"
dns_zone_internal_prefix = "internal.dev.platform"

alert_use_opsgenie = false

redis_idh_resource_tier = "balanced_0_5gb"

cosmos_idh_resource_tier = "cosmos_mongo6"

cosmos_mongo_db_params = {
  capabilities = ["EnableMongo"]
}

cosmos_mongo_db_pos_gateway_params = {
  enable_autoscaling = true
  enable_serverless  = true
  max_throughput     = 2000
  throughput         = 2000
}

servicebus_queues = [
  {
    name                = "posgw.cmd.ecommerce.sync"
    max_delivery_count  = 10
    duplicate_detection = true
    keys = [
      {
        #used by transaction-handler -> perm: RW
        name   = "posgw-th-ecommerce-sync"
        listen = true
        send   = true
        manage = false
      }
    ]
  },
  {
    name                = "posgw.cmd.ecommerce.sync.retry"
    max_delivery_count  = 10
    duplicate_detection = true
    keys = [
      {
        #used by transaction-handler -> perm: RW
        name   = "posgw-th-ecommerce-sync-retry"
        listen = true
        send   = true
        manage = false
      }
    ]
  },
  {
    name                = "posgw.cmd.gec.sync"
    max_delivery_count  = 10
    duplicate_detection = true
    keys = [
      {
        #used by transaction-handler -> perm: RW
        name   = "posgw-th-gec-sync"
        listen = true
        send   = true
        manage = false
      }
    ]
  },
  {
    name                = "posgw.cmd.gec.sync.retry"
    max_delivery_count  = 10
    duplicate_detection = true
    keys = [
      {
        #used by transaction-handler -> perm: RW
        name   = "posgw-th-gec-sync-retry"
        listen = true
        send   = true
        manage = false
      }
    ]
  },
  {
    name                = "posgw.cmd.session.poll"
    max_delivery_count  = 10
    duplicate_detection = true
    keys = [
      {
        #used by transaction-handler -> perm: RW
        name   = "posgw-th-session-poll"
        listen = true
        send   = true
        manage = false
      }
    ]
  },
  {
    name                = "posgw.cmd.session.expire"
    max_delivery_count  = 10
    duplicate_detection = true
    keys = [
      {
        #used by transaction-handler -> perm: RW
        name   = "posgw-th-session-expire"
        listen = true
        send   = true
        manage = false
      }
    ]
  }
]

servicebus_topics = [
  {

    name = "posgw.evt.session.lifecycle"
    keys = [
      {
        #used by cdc-engine (producer) -> perm: W 
        name   = "posgw-session-lifecycle-tx"
        listen = false
        send   = true
        manage = false
      },
      {
        #used by session-view-consumer component (async view update) -> perm: R
        name   = "posgw-session-view-rx"
        listen = true
        send   = false
        manage = false
      },
      {
        #used by compensation-consumer component (listen to failure events to perform compensations) -> perm: R
        name   = "posgw-compensation-rx"
        listen = true
        send   = false
        manage = false
      },
      {
        #used by telemetry-consumer component (listen to all events for telemetry purposes) -> perm: R
        name   = "posgw-telemetry-lifecycle-rx"
        listen = true
        send   = false
        manage = false
      }
    ]
    subscriptions = [
      {
        name                = "posgw.sub.session.view_update"
        max_delivery_count  = 10
        duplicate_detection = true
      },
      {
        name                = "posgw.sub.session.compensation"
        max_delivery_count  = 10
        duplicate_detection = true
        rules = [
          {
            name        = "status-compensation"
            filter_type = "SqlFilter"
            #catch only events with status 'EXPIRED' or 'FAILED'
            sql_filter = "status IN ('EXPIRED', 'FAILED')"
          }
        ]
      },
      {
        name                = "posgw.sub.telemetry.elastic_ingest.lifecycle"
        max_delivery_count  = 10
        duplicate_detection = true
      }
    ]
  },
  {
    name = "posgw.evt.sys.telemetry"
    keys = [
      {
        #used by all component to send telemetry data (p.e. custom spans etc) -> perm: W 
        name   = "posgw-th-telemetry-tx"
        listen = false
        send   = true
        manage = false
      },
      {
        #used by telemetry-consumer component (p.e. ingest telemetry data in elastic) -> perm: R 
        name   = "posgw-telemetry-rx"
        listen = true
        send   = false
        manage = false
      }
    ]
    subscriptions = [
      {
        name                = "posgw.sub.telemetry.elastic_ingest.telemetry"
        max_delivery_count  = 10
        duplicate_detection = true
      }
    ]
  }
]
