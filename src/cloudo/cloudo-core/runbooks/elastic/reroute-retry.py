
import os

from azure.identity import DefaultAzureCredential
from azure.keyvault.secrets import SecretClient
import requests



ELASTIC_API_KEY_SECRET_NAME = "elastic-api-key"
ELASTIC_BASE_URL_SECRET_NAME = "elastic-base-url"

def azure_login():
  try:
    credential = DefaultAzureCredential()
    return credential
  except Exception as e:
    print(f"Error during login: {str(e)}")
    exit(1)


# Retrieve secrets from keyvault
def get_runbook_secrets(azure_credentials):
    kv_uri = f"https://pagopa-{os.environ.get('CLOUDO_ENVIRONMENT_SHORT', 'd')}-itn-cloudo-kv.vault.azure.net"
    kv_client = SecretClient(vault_url=kv_uri, credential=azure_credentials)
    return {
     ELASTIC_API_KEY_SECRET_NAME : kv_client.get_secret(ELASTIC_API_KEY_SECRET_NAME).value,
     ELASTIC_BASE_URL_SECRET_NAME : kv_client.get_secret(ELASTIC_BASE_URL_SECRET_NAME).value,
    }

def main():
  azure_credential = azure_login()
  secrets = get_runbook_secrets(azure_credential)

  response = requests.post(f"{secrets['ELASTIC_BASE_URL_SECRET_NAME']}/_cluster/reroute?retry_failed&metric=none", headers={"Authorization": f"ApiKey {secrets['ELASTIC_API_KEY_SECRET_NAME']}"})
  if response.status_code != 200:
    print(f"Error during allocation retry: {response.status_code} - {response.text}")
    exit(1)
  else:
    print("Allocation retry triggered successfully.")
    exit(0)



if __name__ == "__main__":
  main()
