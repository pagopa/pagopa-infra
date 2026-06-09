
import os
from wsgiref.validate import header_re

from azure.storage.queue import QueueClient
from azure.identity import DefaultAzureCredential
from azure.keyvault.secrets import SecretClient
import json
import uuid
import requests
from urllib.parse import unquote
# from azure.keyvault.secrets import SecretClient
from typing import Optional
import time
from typing import Any, Dict
from datetime import datetime, timedelta
from zoneinfo import ZoneInfo
from slack_sdk.webhook import WebhookClient
from slack_sdk.errors import SlackApiError


SYNTHETICS_INBOUND_QUEUE_NAME = "inbound-queue"
SYNTHETICS_OUTBOUND_QUEUE_NAME = "outbound-queue"
STORAGE_ACCOUNT_NAME = f"pagopa{os.environ.get('CLOUDO_ENVIRONMENT_SHORT', 'd')}weusynthmon"
TEST_ID_TO_WATCH = ["nodo_checkPosition_appgw", "nodo_checkPosition_nexiPostgres", "nodo_verifyPaymentNoticeOnPartner_appgw", "nodo_verifyPaymentNoticeOnPartner_nexiPostgres"]

TESTS_TO_RUN = 3
WAIT_BETWEEN_TESTS = 60
WAIT_BEFORE_RESPONSE = 30
SWITCH_TO_NEXI = "toNexi"
SWITCH_TO_PAGOPA = "toPagopa"
NO_SWITCH = None
SLACK_WEBHOOK_URL = "ndp-dr-slack-webhook"
GOOGLE_TOKEN_API = "dip-pagamenti-google-token-api"
CALENDAR_ID = "dip-pagamenti-calendar-id"
WAR_ROOM_ATTENDEES = "ndp-dr-war-room-attendee"
SWITCH_SCHEMA_ID = "ndp-switch-execution"
CLOUDO_API_KEY = "ndp-dr-cloudo-api-key"
NDP_SYNTHETIC_APP_NAMES = ["nodo"]

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
    # get nexi tests
    nexi_tests = list(filter(lambda test: test.get("type", "") == "nexiPostgres", watched_tests))
    nexi_success = list(filter(is_success, nexi_tests))
    # get pagopa tests
    pagopa_tests = list(filter(lambda test: test.get("type", "") == "appgw", watched_tests))
    pagopa_success = list(filter(is_success, pagopa_tests))

    nexi_ok = len(nexi_success) == len(nexi_tests)
    pagopa_ok = len(pagopa_success) == len(pagopa_tests)
    print(f"Nexi ok: {len(nexi_success)}, Nexi ko: {len(nexi_tests) - len(nexi_success)}, Pagopa ok: {len(pagopa_success)}, Pagopa ko: {len(pagopa_tests) - len(pagopa_success)}")

    if nexi_ok and not pagopa_ok and len(pagopa_success) == 0:
      switch_suggestion = SWITCH_TO_NEXI
    elif pagopa_ok and not nexi_ok and len(nexi_success) == 0:
      switch_suggestion = SWITCH_TO_PAGOPA
    else:
      switch_suggestion = NO_SWITCH

    print(f"switch_suggestion: {switch_suggestion}")
    return switch_suggestion
  else:
    print("NDP tests failed")
    exit(1)



# Retrieve secrets from keyvault
def get_runbook_secrets(azure_credentials):
    kv_uri = f"https://pagopa-{os.environ.get('CLOUDO_ENVIRONMENT_SHORT', 'd')}-itn-cloudo-kv.vault.azure.net"
    kv_client = SecretClient(vault_url=kv_uri, credential=azure_credentials)
    return {
     SLACK_WEBHOOK_URL : kv_client.get_secret("ndp-dr-slack-webhook").value,
     GOOGLE_TOKEN_API : kv_client.get_secret("dip-pagamenti-google-token-api").value,
     CALENDAR_ID : kv_client.get_secret("dip-pagamenti-calendar-id").value,
     WAR_ROOM_ATTENDEES : kv_client.get_secret("ndp-dr-war-room-attendee").value.split(","),
     CLOUDO_API_KEY : kv_client.get_secret("ndp-dr-cloudo-api-key").value
    }

def create_slack_message(suggested_switch: str, hangout_url: str):
    return {
        "blocks":
            [
                {
                    "type" : "header",
                    "text": {
                        "type": "plain_text",
                        "text": "DR NdP - switch consigliato"
                    }
                },
                {
                    "type": "section",
                    "text": {
                        "type": "mrkdwn",
                        "text": f"Il Nodo dei Pagamenti sta riscontrando problemi, si consiglia di eseguire lo switch *{suggested_switch}*"
                    }
                },
                {
                  "type": "divider"
                },
                {
                  "type": "section",
                  "text": {
                    "type": "mrkdwn",
                    "text": ":phone: Nel calendario del dipartimento pagamenti trovi la war room dedicata"
                  },
                  "accessory": {
                    "type": "button",
                    "text": {
                      "type": "plain_text",
                      "text": "Unisciti",
                    },
                    "value": "join_wr",
                    "url": f"{hangout_url}",
                    "action_id": "button-action"
                  }
                }
            ]
        }

def send_slack_message(payload, webhook_url):
    client = WebhookClient(webhook_url)
    print("Slack client initialized.")
    try:
        response = client.send(
            **payload
        )

        print(f"Slack API response: {response.status_code}")
        if response.status_code == 200:
          print(f"Success! Slack message sent ")

        return
    except SlackApiError as e:
        print(f"Error sending Slack notification: {e.response['error']}")
    except Exception as e:
        print(f"An unexpected error occurred: {e}")

def get_google_token(google_token_api):
  response = requests.get(google_token_api)
  if response.ok:
    return unquote(response.headers.get("tokengoogle"))
  else:
    raise Exception(f"Failed to retrieve Google token: {response.status_code} - {response.text}")


def google_oauth(token: str):
  response = requests.post("https://oauth2.googleapis.com/token", headers={"Content-Type": "application/x-www-form-urlencoded"}, data={"grant_type": "urn:ietf:params:oauth:grant-type:jwt-bearer", "assertion": f"{token}"})
  if response.ok:
    return response.json().get("access_token")
  else:
    raise Exception(f"Failed to retrieve Google access token: {response.status_code} - {response.text} - {response}")


def create_google_calendar_event(auth_token: str, switch: str, calendar_id: str, attendees: list[str] ):
  tz = ZoneInfo("Europe/Rome")
  now = datetime.now(tz)
  end = now + timedelta(hours=2)
  event = {
    "summary": "TEST - [ NdP DR ] War room",
    "location": "OnCall",
    "description": f"War room creata automaticamente. Valutare lo switch consigliato {switch} e partecipare alla war room",
    "start": {
      "dateTime": now.isoformat(),
      "timeZone": "Europe/Rome"
    },
    "end": {
      "dateTime": end.isoformat(),
      "timeZone": "Europe/Rome"
    },
    "conferenceData": {
      "createRequest": {
        "requestId": "Always Regenerate",
        "conferenceSolutionKey": {"type": "HangoutsMeet"}
      }
    },
    "attendees": [{"email": a} for a in attendees]
  }

  response = requests.post(f"https://www.googleapis.com/calendar/v3/calendars/{calendar_id}@group.calendar.google.com/events?conferenceDataVersion=1", headers={"Authorization": f"Bearer {auth_token}", "Content-Type": "application/json"}, json=event)

  if response.ok:
    print("Google Calendar event created successfully.")
    return response.json()
  else:
    raise Exception(f"Failed to create Google Calendar event: {response.status_code} - {response.text}")

def create_war_room(switch: str, secrets: dict):
  token = get_google_token(secrets.get(GOOGLE_TOKEN_API))
  auth = google_oauth(token)
  event = create_google_calendar_event(auth, switch, secrets.get(CALENDAR_ID), secrets.get(WAR_ROOM_ATTENDEES))
  return event.get("hangoutLink")


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
                    "switch": switch
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
  print(f"secrets: {secrets}")
  trigger_cloudo_switch(switch_to_perform, secrets.get(CLOUDO_API_KEY))

  try:
    wr_link = create_war_room(switch_to_perform, secrets)
    # send message to pagopainfra with war room link
    message = create_slack_message(switch_to_perform, wr_link)
    send_slack_message(message, secrets.get(SLACK_WEBHOOK_URL))
  except Exception as e:
    print(f"An unexpected error occurred: {e}")

def main():
  azure_credential = azure_login()

  switch_to_perform = []

  for i in range(TESTS_TO_RUN):
    print(f"test run #{i}")
    message_uuid = str(uuid.uuid4())
    queue_message = {
        "alarmId": message_uuid,
        "appNames": NDP_SYNTHETIC_APP_NAMES
    }

    send_message_to_queue(queue_name=SYNTHETICS_INBOUND_QUEUE_NAME, message=queue_message, azure_credentials=azure_credential, storage_account_name=STORAGE_ACCOUNT_NAME)

    # wait 30 seconds before checking test results
    time.sleep(WAIT_BEFORE_RESPONSE)

    response_message = receive_message_from_queue(queue_name=SYNTHETICS_OUTBOUND_QUEUE_NAME, expected_alarm_id=message_uuid, account_name=STORAGE_ACCOUNT_NAME, azure_credentials=azure_credential, timeout=360)
    switch_to_perform.append(evaluate_test_results(response_message))

    time.sleep(WAIT_BETWEEN_TESTS)

  print(f"switch suggestion collected: {switch_to_perform}")
  # convert to set, implicit check if all elements are equals
  if len(set(switch_to_perform)) == 1 and NO_SWITCH not in switch_to_perform:
    trigger_switch(switch_to_perform[0], azure_credential)
    exit(0)
  else:
    print(f"no clear switch identified; switch identified: {switch_to_perform}")
    exit(1)




if __name__ == "__main__":
  main()
