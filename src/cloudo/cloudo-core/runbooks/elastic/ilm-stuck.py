import json
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
    kv_uri = f"https://pagopa-{os.environ.get('CLOUDO_ENVIRONMENT_SHORT', 'p')}-itn-cloudo-kv.vault.azure.net"
    kv_client = SecretClient(vault_url=kv_uri, credential=azure_credentials)
    return {
     ELASTIC_API_KEY_SECRET_NAME : kv_client.get_secret(ELASTIC_API_KEY_SECRET_NAME).value,
     ELASTIC_BASE_URL_SECRET_NAME : kv_client.get_secret(ELASTIC_BASE_URL_SECRET_NAME).value,
    }

def main():
  azure_credential = azure_login()
  secrets = get_runbook_secrets(azure_credential)

  response = requests.get(f"{secrets.get(ELASTIC_BASE_URL_SECRET_NAME)}/_health_report/ilm", headers={"Authorization": f"ApiKey {secrets.get(ELASTIC_API_KEY_SECRET_NAME)}"})
  if response.status_code != 200:
    print(f"[ERROR] Cluster health report failed: {response.status_code} - {response.text}")
    exit(1)
  else:
    print(f"[INFO] Cluster health report: {response.text}")
    response_j = json.loads(response.text)
    ilm_status = response_j.get("indicators").get("ilm").get("status")
    if ilm_status == "yellow":
      # check stagnating indexes
      for diagnosis in response_j.get("indicators").get("ilm").get("diagnosis"):
        diagnosis_id = diagnosis.get("id")
        if "elasticsearch:health:ilm:diagnosis:stagnating_action" in diagnosis_id:
          print(f"[INFO] Found stagnating action: {diagnosis_id}")
          affected_idxs = diagnosis.get('affected_resources').get('indices')
          print(f"[INFO] Dffected idxs: {affected_idxs}")
          # set replica count to 0, to unlock the stagnation
          for idx in affected_idxs:
            print(f"[INFO] removing replica from {idx}")
            set_replica_response = requests.put(
              f"{secrets.get(ELASTIC_BASE_URL_SECRET_NAME)}/{idx}/_settings",
              headers={"Authorization": f"ApiKey {secrets.get(ELASTIC_API_KEY_SECRET_NAME)}"},
              json={"number_of_replicas": 0}
            )
            if set_replica_response.status_code != 200:
              print(f"[ERROR] set replica to 0 failed for index {idx} - {set_replica_response.status_code} - {set_replica_response.text}")
            else:
              print("[INFO] done")

if __name__ == "__main__":
  main()
