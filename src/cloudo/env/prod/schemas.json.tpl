[
  {
    "partition_key": "generic",
    "entity": []
  },
  {
    "partition_key": "infra",
    "entity": [
    {
      "id": "pagopa-p-appgw-total-request-info",
      "name": "total request pagopa-app-gw",
      "description": "Get Total request from pagopa appgw!",
      "runbook": "azure/application_gateway_info.sh",
      "run_args": "pagopa-p-app-gw pagopa-p-vnet-rg",
      "worker": "generic",
      "oncall": false,
      "require_approval": false,
      "tags": "application gateway,azure"
    }]
  },
  {
    "partition_key": "elastic",
    "entity": []
  }
]
