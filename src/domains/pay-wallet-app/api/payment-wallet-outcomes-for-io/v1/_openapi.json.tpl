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
    "/transactions/{transactionId}/wallets/{walletId}/outcomes": {
      "get": {
        "tags": [
          "wallets"
        ],
        "operationId": "getOnboardingwithTransactionOutcome",
        "parameters": [
          {
            "in": "path",
            "name": "walletId",
            "schema": {
              "type": "string",
              "format": "uuid"
            },
            "required": true,
            "description": "created payment wallet unique id"
          },
          {
            "in": "path",
            "name": "transactionId",
            "schema": {
              "type": "string"
            },
            "required": true,
            "description": "activated eCommerce transaction associated to the created wallet id"
          },
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
          }
        ],
        "summary": "Redirection URL for onboarding with transaction  outcome",
        "description": "Return onboarding outcome related to eCommerce transaction result as `outcome` query parameter",
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