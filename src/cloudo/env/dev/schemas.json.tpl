[
  {
    "partition_key": "generic",
    "entity": [
    {
      "id": "000-0000-0e0e00ww-wqesd",
      "name": "pippo",
      "description": "Hello Pippo V1!",
      "runbook": "check_sys.sh",
      "worker": "generic",
      "oncall": "false",
      "require_approval": "true"
    },
    {
      "id": "000-0000-0e0e00wa-wqesd",
      "name": "pippo",
      "description": "Hello Pippo V2!",
      "runbook": "check_sys.sh",
      "worker": "generic",
      "oncall": "false",
      "run_args": "",
      "require_approval": "false"
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
    },
     {
      "id": "scale-pagopa-d-aks-user01-nodepool",
      "name": "scale the user01 nodepool on DEV",
      "description": "",
      "runbook": "aks/aks-scale-node-pool.sh",
      "run_args": "user01",
      "worker": "generic",
      "oncall": "true"
    },
    {
      "id": "aks-info-dev",
      "name": "Aks info on DEV",
      "description": "Get aks namespace information.",
      "runbook": "aks/aks-info.py",
      "run_args": "",
      "worker": "generic",
      "oncall": "false"
    },
          {
      "id": "aks-info-dev-fixed-ns",
      "name": "[DEMO] Aks info on DEV fixed ns",
      "description": "[DEMO] Get aks namespace information with fixed NS.",
      "runbook": "demo/aks-info-fixed-ns.py",
      "run_args": "",
      "worker": "generic",
      "oncall": "false"
    },
    {
      "id": "restart-pod",
      "name": "[DEV] restart api config dev pod",
      "description": "This runbook restart api config postgres pod",
      "runbook": "aks/aks-deployments-rollout.sh",
      "run_args": "cache-postgresql",
      "worker": "generic",
      "oncall": "false"
    }]
  },
  {
    "partition_key": "alert",
    "entity": [
    {
      "id": "12345678-1234-1234-1234-1234567890ab",
      "name": "smart-alert",
      "description": "SMART!",
      "runbook": "check_sys.sh",
      "run_args": "",
      "worker": "generic",
      "oncall": "false"
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
