[
  {
    "partition_key": "generic",
    "entity": []
  },
  {
    "partition_key": "infra",
    "entity": [
      {
        "id": "pagopa-d-appgw-total-request-info",
        "name": "total request pagopa-app-gw",
        "description": "Get Total request from pagopa appgw!",
        "runbook": "azure/application_gateway_info.sh",
        "run_args": "pagopa-d-app-gw pagopa-d-vnet-rg",
        "worker": "generic",
        "oncall": false,
        "require_approval": false,
        "tags": "application gateway,azure"
      },
      {
        "id": "availability-fe-checkout-cdn",
        "name": "Checkout CDN switch",
        "description": "Switch checkout provider from CDN to APIM",
        "runbook": "azure/checkout_cdn_switch.sh",
        "require_approval": "true",
        "run_args": "",
        "worker": "generic",
        "oncall": false,
        "require_approval": true,
        "tags": "checkout,azure"
      }
    ]
  },
  {
    "partition_key": "alert",
    "entity": [
    {
      "id": "12345678-1234-1234-1234-1234567890ab",
      "name": "Test action group ClouDO",
      "description": "",
      "runbook": "test.py",
      "run_args": "-n 1000 --repeats 1000",
      "worker": "generic",
      "oncall": false,
      "require_approval": false,
      "tags": ""
    }]
  },
  {
    "partition_key": "elastic",
    "entity": []
  }
]
