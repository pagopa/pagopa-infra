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
      "run_args": "pagopa-u-app-gw pagopa-u-vnet-rg",
      "worker": "generic",
      "oncall": "false",
      "tags": "application gateway,azure"
    }]
  },
  {
    "partition_key": "elastic",
    "entity": []
  }
]
