[
  {
    "partition_key": "generic",
    "entity": [
    {
      "id": "000-0000-0e0e00ww-wqesd",
      "name": "pippo-v1",
      "description": "Hello Pippo V1!",
      "runbook": "check_sys.sh",
      "worker": "generic",
      "oncall": "false",
      "require_approval": "true"
    }]
  },
  {
    "partition_key": "infra",
    "entity": [
    {
      "id": "000-0000-0e0e00ww-wasdsa",
      "name": "infra-pippo",
      "description": "Hello Pippo INFRA!",
      "runbook": "test.py",
      "run_args": "-n 1000 --repeats 1000",
      "worker": "generic",
      "oncall": "false"
    },
    {
      "id": "pagopa-d-appgw-total-request-info",
      "name": "total request pagopa-app-gw",
      "description": "Get Total request from pagopa appgw!",
      "runbook": "azure/application_gateway_info.sh",
      "run_args": "pagopa-d-app-gw pagopa-d-vnet-rg",
      "worker": "generic",
      "oncall": "false"
    }]
  },
  {
    "partition_key": "alert",
    "entity": [
    {
      "id": "12345678-1234-1234-1234-1234567890ab",
      "name": "pippo",
      "description": "pippo demo!",
      "runbook": "test.py",
      "run_args": "-n 1000 --repeats 1000",
      "worker": "generic",
      "oncall": "true"
    }]
  },
  {
    "partition_key": "elastic",
    "entity": [
    {
      "id": "test-marco",
      "name": "marco",
      "description": "marco fa i test!",
      "runbook": "check_sys.sh",
      "worker": "generic",
      "oncall": "false"
    }]
  }
]
