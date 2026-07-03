
import os
from wsgiref.validate import header_re

from azure.storage.queue import QueueClient
from azure.identity import DefaultAzureCredential
from azure.keyvault.secrets import SecretClient
import json
import uuid
import requests
from azure.keyvault.secrets import SecretClient
from typing import Optional
import time
from typing import Any, Dict
from slack_sdk.webhook import WebhookClient
from slack_sdk.errors import SlackApiError


SYNTHETICS_INBOUND_QUEUE_NAME = "inbound-queue"
SYNTHETICS_OUTBOUND_QUEUE_NAME = "outbound-queue"
STORAGE_ACCOUNT_NAME = f"pagopa{os.environ.get('CLOUDO_ENVIRONMENT_SHORT', 'd')}weusynthmon"
TEST_ID_TO_WATCH = ["fe_checkout_cdn", "fe_checkout_appgw"]



TESTS_TO_RUN = 3
WAIT_BETWEEN_TESTS = 60
WAIT_BEFORE_RESPONSE = 30
SWITCH_TO_APIM = "toApim"
NO_SWITCH = "noSwitch"
UNCLEAR_SWITCH = "unclear"

SWITCH_SCHEMA_ID = "cdn-apim-switch"
CLOUDO_API_KEY = "ndp-dr-cloudo-api-key"
SYNTHETIC_APP_NAMES = ["fe"]

def azure_login():
  try:
    credential = DefaultAzureCredential()
    return credential
  except Exception as e:
    print(f"Error during login: {str(e)}")
    exit(1)

def storage_account_queue_url(account_name: str) -> str:
  return f"https://{account_name}.queue.core.windows.net"


def receive_message_from_queue(
  queue_name: str,
  expected_alarm_id: str,
  account_name: str,
  azure_credentials: Any,
  visibility_timeout: int = 30,
  max_messages: int = 1,
  timeout: int = 300,

) -> Optional[Dict[str, Any]]:
  try:
    queue_client = QueueClient(
      account_url=storage_account_queue_url(account_name),
      queue_name=queue_name,
      credential=azure_credentials
    )

    start_time = time.time()

    while time.time() - start_time < timeout:
      # Retrieve messages from the queue
      messages = queue_client.receive_messages(
        messages_per_page=max_messages,
        visibility_timeout=visibility_timeout
      )

      for msg in messages:
        try:
          # Deserialize the message content
          message_content = json.loads(msg.content)

          # Check if the alarmId matches
          if message_content.get("alarmId") == expected_alarm_id:
            print(f"Message found with alarmId: {expected_alarm_id}")
            print(f"Message ID: {msg.id}")
            print(f"Success: {message_content.get('success')}")

            # Delete the message from the queue
            queue_client.delete_message(msg.id, msg.pop_receipt)
            print(f"Message removed from the queue")

            return message_content
          else:
            # The alarmId does not match, leave the message in the queue
            print(f"Message with alarmId '{message_content.get('alarmId')}' "
                  f"does not match '{expected_alarm_id}'. Left in queue.")
            # The message will become visible again after visibility_timeout seconds

        except json.JSONDecodeError as e:
          print(f"Error parsing message: {e}")
          # Leave the message in the queue
          continue
        except KeyError as e:
          print(f"Message with invalid structure: {e}")
          # Leave the message in the queue
          continue

      # Wait before retrying
      time.sleep(5)

    print(
      f"Timeout reached ({timeout}s). No message with alarmId '{expected_alarm_id}' found.")
    exit(1)

  except Exception as e:
    print(f"Error receiving message: {str(e)}")
    exit(1)


def send_message_to_queue(
  queue_name: str,
  message: dict,
  azure_credentials: Any,
  storage_account_name: str = None,
) -> bool:
  try:
    queue_client = QueueClient(
      account_url=storage_account_queue_url(storage_account_name),
      queue_name=queue_name,
      credential=azure_credentials
    )

    message_str = json.dumps(message)

    # Send the message
    response = queue_client.send_message(message_str)

    print(f"Message sent successfully. Message ID: {response.id}")
    return True

  except Exception as e:
    print(f"Error sending message: {str(e)}")
    exit(1)


def is_test_to_watch(test):
  return test.get("testId") in TEST_ID_TO_WATCH


def is_success(test):
  return test.get("apiMetrics", {"success": True}).get("success", False) and test.get("certMetrics", {"success": True}).get("success", False)


def evaluate_test_results(test_results: dict) -> str:
  if test_results["success"]:
    # keep only watched tests
    watched_tests = list(filter(is_test_to_watch, test_results.get("tests", [])))
    print(f"watched tests: {watched_tests}")

    # get cdn tests
    cdn_tests = list(filter(lambda test: test.get("type", "") == "cdn", watched_tests))
    cdn_success = list(filter(is_success, cdn_tests))
    # get appgw tests
    appgw_tests = list(filter(lambda test: test.get("type", "") == "appgw", watched_tests))
    appgw_success = list(filter(is_success, appgw_tests))

    cdn_ok = len(cdn_success) == len(cdn_tests)
    appgw_ok = len(appgw_success) == len(appgw_tests)
    print(f"cdn ok: {len(cdn_success)}, cdn ko: {len(cdn_tests) - len(cdn_success)}, appgw ok: {len(appgw_success)}, appgw ko: {len(appgw_tests) - len(appgw_success)}")
    if cdn_ok and appgw_ok:
      switch_suggestion = NO_SWITCH
    elif appgw_ok and not cdn_ok and len(cdn_success) == 0:
      switch_suggestion = SWITCH_TO_APIM
    else:
      switch_suggestion = UNCLEAR_SWITCH

    print(f"switch_suggestion: {switch_suggestion}")
    return switch_suggestion
  else:
    print("Checkout cdn tests failed")
    exit(1)



# Retrieve secrets from keyvault
def get_runbook_secrets(azure_credentials):
    kv_uri = f"https://pagopa-{os.environ.get('CLOUDO_ENVIRONMENT_SHORT', 'd')}-itn-cloudo-kv.vault.azure.net"
    kv_client = SecretClient(vault_url=kv_uri, credential=azure_credentials)
    return {
     CLOUDO_API_KEY : kv_client.get_secret("ndp-dr-cloudo-api-key").value
    }

def trigger_cloudo_switch(switch: str, cloudo_api_key: str):
  print("Triggering cloudo switch runbook")
  response = requests.post(f"https://pagopa-{os.environ.get('CLOUDO_ENVIRONMENT_SHORT', 'd')}-cloudo-orchestrator.azurewebsites.net/api/Trigger/infra",
                headers={"Content-Type": "application/json", "x-cloudo-key": cloudo_api_key},
                json={
                  "source": "cloudo",
                  "severity": "Sev1",
                  "monitorCondition": "Fired",
                  "rule": SWITCH_SCHEMA_ID,
                  "payload": {
                    "zoneName": f"{os.environ.get('CLOUDO_ENVIRONMENT', 'dev')}.checkout.pagopa.it" if os.environ.get('CLOUDO_ENVIRONMENT', 'dev') != "prod" else "checkout.pagopa.it"
                  }
                })

  if not response.ok:
    print(f"Failed to trigger cloudo switch: {response.status_code} - {response.text}")
    exit(1)

  print(f"cloudo trigger response code: {response.status_code}")
  print(f"cloudo trigger response : {response.text}")



def trigger_switch(switch_to_perform: str, azure_credentials: Any) -> None:
  print(f"triggering switch: {switch_to_perform}")

  secrets = get_runbook_secrets(azure_credentials)
  trigger_cloudo_switch(switch_to_perform, secrets.get(CLOUDO_API_KEY))


def main():
  azure_credential = azure_login()

  switch_to_perform = []

  for i in range(TESTS_TO_RUN):
    print(f"test run #{i}")
    message_uuid = str(uuid.uuid4())
    queue_message = {
        "alarmId": message_uuid,
        "appNames": SYNTHETIC_APP_NAMES
    }

    send_message_to_queue(queue_name=SYNTHETICS_INBOUND_QUEUE_NAME, message=queue_message, azure_credentials=azure_credential, storage_account_name=STORAGE_ACCOUNT_NAME)

    # wait 30 seconds before checking test results
    time.sleep(WAIT_BEFORE_RESPONSE)

    response_message = receive_message_from_queue(queue_name=SYNTHETICS_OUTBOUND_QUEUE_NAME, expected_alarm_id=message_uuid, account_name=STORAGE_ACCOUNT_NAME, azure_credentials=azure_credential, timeout=360)
    switch_to_perform.append(evaluate_test_results(response_message))

    time.sleep(WAIT_BETWEEN_TESTS)

  print(f"switch suggestion collected: {switch_to_perform}")

  # convert to set, implicit check if all elements are equals
  switch_set = set(switch_to_perform)

  if len(switch_set) > 1:
    print(f"no clear switch identified; switch suggestions identified: {switch_to_perform}")
    exit(1)
  else:
    if NO_SWITCH in switch_set:
      print(f"Switch not necessary, all system are good")
      exit(0)
    elif UNCLEAR_SWITCH in switch_set:
      print(f"Systems partially good, manual check required")
      exit(1)
    if UNCLEAR_SWITCH not in switch_set:
      print(f"Switch identified: {switch_to_perform[0]}")
      trigger_switch(switch_to_perform[0], azure_credential)
      exit(0)


if __name__ == "__main__":
  main()
