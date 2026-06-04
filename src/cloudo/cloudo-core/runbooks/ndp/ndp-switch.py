
import os
from wsgiref.validate import header_re

from azure.identity import DefaultAzureCredential
from azure.keyvault.secrets import SecretClient
from azure.mgmt.apimanagement import ApiManagementClient
from azure.mgmt.apimanagement.models import NamedValueCreateContract
import json
from slack_sdk.webhook import WebhookClient
from slack_sdk.errors import SlackApiError



SUBSCRIPTION_ID = "YOUR_SUBSCRIPTION_ID"
APIM_RG_NAME = "YOUR_RESOURCE_GROUP"
APIM_NAME = "YOUR_APIM_SERVICE_NAME"

SWITCH_TO_NEXI = "toNexi"
SWITCH_TO_PAGOPA = "toPagopa"
NO_SWITCH = None

NEXI_PUBLIC_CONFIGURATION = {
  "dev": {
    "node_id": "NDP004IT",
    "address": "https://test.nexi.ndp.pagopa.it/nodo-p-sit.nexigroup.com"
  },
  "uat": {
    "node_id": "NDP004UAT",
    "address": "https://test.nexi.ndp.pagopa.it"

  },
  "prod": {
    "node_id": "NDP004PROD",
    "address": "https://nexi.ndp.pagopa.it"

  }
}

PAGOPA_PUBLIC_CONFIGURATION = {
  "dev": {
    "node_id": "NDP001DEV",
    "address": "https://weudev.nodo.internal.dev.platform.pagopa.it/nodo"
  },
  "uat": {
    "node_id": "NDP001UAT",
    "address": "https://weuuat.nodo.internal.uat.platform.pagopa.it/nodo"

  },
  "prod": {
    "node_id": "NDP001PROD",
    "address": "https://weuprod.nodo.internal.platform.pagopa.it/nodo"

  }
}


SWITCH = {
  "toNexi" : {
    "enable-nm3-decoupler-switch": False,
    "enable-routing-decoupler-switch": False,
    "default-nodo-id": NEXI_PUBLIC_CONFIGURATION.get(os.environ.get("CLOUDO_ENVIRONMENT").lower()).get("node_id"),
    "default-nodo-backend": NEXI_PUBLIC_CONFIGURATION.get(os.environ.get("CLOUDO_ENVIRONMENT").lower()).get("address"),
    "schema-ip-nexi": NEXI_PUBLIC_CONFIGURATION.get(os.environ.get("CLOUDO_ENVIRONMENT").lower()).get("address"), # same as default-nodo-backend
    # added only in uat environment
    **({"default-nodo-backend-prf": NEXI_PUBLIC_CONFIGURATION.get(os.environ.get("CLOUDO_ENVIRONMENT").lower()).get("address")} if os.environ.get("CLOUDO_ENVIRONMENT").lower() ==  "uat" else {})  # same as default-nodo-backend
  },
  "toPagopa": {
    "enable-nm3-decoupler-switch": False,
    "enable-routing-decoupler-switch": False,
    "default-nodo-id": PAGOPA_PUBLIC_CONFIGURATION.get(os.environ.get("CLOUDO_ENVIRONMENT").lower()).get("node_id"),
    "default-nodo-backend": PAGOPA_PUBLIC_CONFIGURATION.get(os.environ.get("CLOUDO_ENVIRONMENT").lower()).get("address"),
    # added only in uat environment
    **({"default-nodo-backend-prf": PAGOPA_PUBLIC_CONFIGURATION.get(os.environ.get("CLOUDO_ENVIRONMENT").lower()).get("address")} if os.environ.get("CLOUDO_ENVIRONMENT").lower() ==  "uat" else {})  # same as default-nodo-backend
  }

}

def build_apim_client():
  try:
    credential = DefaultAzureCredential()
    client = ApiManagementClient(credential, SUBSCRIPTION_ID)
    return client
  except Exception as e:
    print(f"Error during login: {str(e)}")
    exit(1)



def get_apim_named_values(client, names):
  print("print values")
  return [
    {nv.display_name: nv.value}
    for name in names
    for nv in [client.named_value.get(
      resource_group_name=APIM_RG_NAME,
      service_name=APIM_NAME,
      named_value_id=name
    )]
  ]

def update_apim_named_values(client, values: dict):
  print("update values")

def main():
  payload = os.environ.get('CLOUDO_PAYLOAD')
  if not payload:
    print("No payload found in environment variable 'CLOUDO_PAYLOAD'")
    exit(1)

  payload_j = json.loads(payload)
  print(f"received payload: {payload_j}")
  # switch = payload_j.get("switch")
  #
  # apim_client = build_apim_client()
  #
  # values = get_apim_named_values(apim_client, SWITCH.get(switch).keys())
  # print(f"current values: {values}")
  #
  # update_apim_named_values(apim_client, SWITCH.get(switch))

if __name__ == "__main__":
  main()
