{
  "openapi": "3.0.3",
  "info": {
    "title": "pagoPA Payment Wallet Outcome API",
    "version": "0.0.1",
    "description": "API to handle payment wallets outcome in onboarding phase. API return a response code to the IO App for decoding the wallet onboarding result.",
    "termsOfService": "https://pagopa.it/terms/"
  },
  "tags": [
    {
      "name": "wallets",
      "description": "Api's to handle a wallet",
      "externalDocs": {
        "url": "https://pagopa.atlassian.net/wiki/spaces/WA/overview?homepageId=622658099",
        "description": "Documentation"
      }
    }
  ],
  "servers": [
    {
      "url": "https://${hostname}"
    }
  ],
  "paths": {
    "/wallets/outcomes": {
      "get": {
        "tags": [
          "wallets"
        ],
        "operationId": "getOnboardingOutcome",
        "parameters": [
          {
            "in": "query",
            "name": "outcome",
            "schema": {
              "type": "string",
              "enum": [
                "0",
                "1",
                "2",
                "3",
                "4",
                "5",
                "6",
                "7",
                "8",
                "9",
                "10",
                "11",
                "12",
                "13",
                "14"
              ]
            },
            "description": "`0` - Success `1` - Generic error `2` - Authorization error `3` - Invalid data `4` - Timeout `5` - Unsupported circuit `6` - Missing data `7` - Invalid card: expired card etc `8` - Canceled by the user `9` - Double transaction `10` - Excessive amount `11` - Order not present `12` - Invalid method `13` - Retriable KO `14` - Invalid session\n",
            "required": true
          }
        ],
        "summary": "Redirection URL for onboarding outcome",
        "description": "Return onboarding outcome result as `outcome` query parameter",
        "responses": {
          "302": {
            "description": "Onboarding outcome available (see outcome query parameter)",
            "headers": {
              "Location": {
                "description": "URI with iowallet:// used by client to show result given outocome in query parameter",
                "schema": {
                  "type": "string"
                }
              }
            }
          }
        }
      }
    },
    "/transactions/wallets/contextual-onboard/outcomes": {
      "get": {
        "tags": [
          "wallets"
        ],
        "operationId": "transactionsWithContextualOnboarding",
        "parameters": [
          {
            "in": "query",
            "name": "outcome",
            "schema": {
              "type": "string",
              "enum": [
                "0",
                "1"
              ]
            },
            "required": true,
            "description": "`0` - Success `1` - Generic error\n"
          },
          {
            "in": "query",
            "name": "faultCodeCategory",
            "schema": {
              "type": "string"
            },
            "description": "Fault code categorization for the PagoPA ActivatePaymentNotice operation. \nex: PAYMENT_EXPIRED\nThis field have the same semantic of the same field returned by eCommerce transactions-service in POST /transactions error responses and is valued only in case of errors in payment notice activation processing\n",
            "required": false
          },
          {
            "in": "query",
            "name": "faultCodeDetail",
            "schema": {
              "type": "string"
            },
            "description": "Details for the fault code obtained in ActivatePaymentNotice operation. \nex: PPT_STAZIONE_INT_PA_TIMEOUT\nThis field have the same semantic of the same field returned by eCommerce transactions-service in POST /transactions error responses and is valued only in case of errors in payment notice activation processing\n",
            "required": false
          },
          {
            "in": "query",
            "name": "walletId",
            "schema": {
              "type": "string",
              "format": "uuid"
            },
            "description": "id of the created wallet",
            "required": false
          },
          {
            "in": "query",
            "name": "transactionId",
            "schema": {
              "type": "string"
            },
            "description": "id of the activated transaction eCommerce side",
            "required": false
          }
        ],
        "summary": "Redirection URL for payment with contextual onboarding flow",
        "description": "Return onboarding outcome related to eCommerce transaction result as `outcome` query parameter and payment with contextual onboarding operation result data",
        "responses": {
          "302": {
            "description": "Onboarding outcome available (see outcome query parameter)",
            "headers": {
              "Location": {
                "description": "URI with iowallet:// used by client to show result given outocome in query parameter",
                "schema": {
                  "type": "string"
                }
              }
            }
          }
        }
      }
    }
  }
}