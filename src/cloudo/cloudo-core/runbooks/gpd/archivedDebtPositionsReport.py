import sys
from datetime import datetime, timedelta
from zoneinfo import ZoneInfo

from azure.identity import DefaultAzureCredential
from azure.monitor.query import LogsQueryClient, LogsQueryStatus
from azure.core.exceptions import HttpResponseError
from azure.keyvault.secrets import SecretClient
from azure.mgmt.subscription import SubscriptionClient
from azure.mgmt.resource import ResourceManagementClient

from slack_sdk import WebClient
from slack_sdk.errors import SlackApiError

# Set azure credentials
credential = DefaultAzureCredential()

# Set app-insight query
query = 'customEvents | where name == "ADF_DebtPositionsArchived" | extend debtPositionsArchived = parse_json(customDimensions).DebtPositionsArchived | summarize TotalArchivedDebtPositions=sum(toint(debtPositionsArchived))'

# Set query interval
end_time = datetime.now(ZoneInfo("Europe/Rome"))
start_time = end_time - timedelta(days=7)
date_time_format = "%d/%m/%Y %H:%M:%S"

# Set slack report webhook secret name
slack_webhook_secret_name = "pagopa-platform-reporter-oauth-token"

# Define global variables
def def_global_vars(input):
    global env_short
    global env_upper
    match input:
        case "dev":
            env_short = "d"
            env_upper = "DEV"
        case "uat":
            env_short = "u"
            env_upper = "UAT"
        case "prod":
            env_short = "p"
            env_upper = "PROD"
        case _:
            print("Wrong input environment")
            exit()

# Get resource id
def get_resource_id():
    sub_id = None
    subs = SubscriptionClient(credential)
    for element in subs.subscriptions.list():
        if element.display_name == f"{env_upper}-pagoPA":
            sub_id = element.subscription_id

    resource_client = ResourceManagementClient(credential, sub_id)
    resource = resource_client.resources.get(
        resource_group_name=f"pagopa-{env_short}-monitor-rg",
        resource_provider_namespace="Microsoft.Insights",
        parent_resource_path="",
        resource_type="components",
        resource_name=f"pagopa-{env_short}-appinsights",
        api_version="2020-02-02"
    )
    return resource.id

# App-insight query logic
def query_app_insights(app_insight_id: str):
    try:
        logs_query_client = LogsQueryClient(credential)
        response = logs_query_client.query_resource(app_insight_id, query, timespan=(start_time, end_time))
        if response.status == LogsQueryStatus.SUCCESS:
            data = response.tables[0]
            for row in data.rows:
                total_archived_debt_positions = row["TotalArchivedDebtPositions"]
            return total_archived_debt_positions
        else:
            error = response.partial_error
            data = response.partial_data
            print(error)

    except HttpResponseError as err:
        print("something fatal happened")
        print(err)

# Retrieve slack secret from keyvault
def get_slack_report_secret():
    kv_uri = f"https://pagopa-{env_short}-gps-kv.vault.azure.net"
    kv_client = SecretClient(vault_url=kv_uri, credential=credential)
    return kv_client.get_secret(slack_webhook_secret_name)

# Create slack message
def create_slack_message(total_archived_debt_positions: int, start_time: datetime, end_time: datetime):
    return {
        "text": "Archiviazione posizioni debitorie",
        "blocks":
            [
                {
                    "type" : "header",
                    "text": {
                        "type": "plain_text",
                        "text": "Archiviazione posizioni debitorie"
                    }
                },
                {
                    "type": "section",
                    "text": {
                        "type": "mrkdwn",
                        "text": f"*:recycle: Intervallo: {start_time.strftime(date_time_format)} - {end_time.strftime(date_time_format)} *\n*:moneybag: Posizioni debitorie archiviate: {total_archived_debt_positions}*"
                    }
                }
            ]
        }

# Create slack message
def send_slack_message(payload, slack_channel_id):
    client = WebClient(token=get_slack_report_secret().value)
    print("Slack client initialized.")
    try:
        response = client.chat_postMessage(
            channel=slack_channel_id,
            **payload
        )
        print(f"Success! Message sent to {slack_channel_id} at {response['ts']}")
        return response
    except SlackApiError as e:
        print(f"❌ Error sending Slack notification: {e.response['error']}")
    except Exception as e:
        print(f"❌ An unexpected error occurred: {e}")

# To launch this script: python3 archivedDebtPositionsReport.py <dev|uat|prod> <slack_channel_id>
if __name__ == "__main__":
    def_global_vars(sys.argv[1])
    app_insights_id = get_resource_id()
    total_archived_debt_positions = query_app_insights(app_insights_id)
    slack_report_webhook = get_slack_report_secret()
    payload = create_slack_message(total_archived_debt_positions, start_time, end_time)
    send_slack_message(payload, sys.argv[2])
