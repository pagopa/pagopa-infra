{
  "openapi": "3.0.0",
  "info": {
    "version": "0.0.1",
    "title": "Pagopa eCommerce services for app IO outcomes",
    "description": "API's exposed from eCommerce services to app IO to handle pagoPA payment outcomes.\n\nThe payment workflow ends with a outcome returned as query params in a webview, for example \n \n - /outcomes?outcome=0. \n\nThe possible outcome are:\n- SUCCESS(0) → payment completed successfully\n- GENERIC_ERROR(1),\n- AUTH_ERROR(2) → authorization denied\n- INVALID_DATA(3) → incorrect data\n- TIMEOUT(4) → timeout \n- CIRCUIT_ERROR(5) → Unsupported circuit (should never happen)\n- MISSING_FIELDS(6) → missing data (should never happen) \n- INVALID_CARD(7) → expired card (or similar)\n- CANCELED_BY_USER(8) → canceled by the user\n- DUPLICATE_ORDER(9) → Double transaction (should never happen)\n- EXCESSIVE_AMOUNT(10) → Excess of availability \n- ORDER_NOT_PRESENT(11) → (should never happen)\n- INVALID_METHOD(12) → (should never happen)\n- KO_RETRIABLE(13) → transaction failed, but the transaction is theoretically recoverable. For the user it is a KO\n- INVALID_SESSION(14)\n- TAKEN_IN_CHARGE(17) → Waiting for outcome \n- PSP_ERROR(25) → Error from psp\n- BE_KO(99) → Backend Error\n- BALANCE_NOT_AVAILABLE(116) → Balance not available\n- CVV_ERROR(117) → Security code error\n- LIMIT_EXCEDEED(121) → Limit excedeed",
    "contact": {
      "name": "pagoPA - Touchpoints team"
    }
  },
  "servers": [
    {
      "url": "https://${hostname}"
    }
  ],
  "paths": {
    "/transactions/{transactionId}/outcomes": {
      "get": {
        "tags": [
          "ecommerce-transactions"
        ],
        "operationId": "getTransactionOutcome",
        "parameters": [
          {
            "in": "path",
            "name": "transactionId",
            "schema": {
              "type": "string"
            },
            "required": true,
            "description": "Transaction ID"
          },
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
                "14",
                "17",
                "25",
                "99",
                "116",
                "117",
                "121"
              ]
            },
            "description": "`0` - Success `1` - Generic error `2` - Authorization error `3` - Invalid data `4` - Timeout `5` - Unsupported circuit `6` - Missing data `7` - Invalid card: expired card etc `8` - Canceled by the user `9` - Double transaction `10` - Excessive amount `11` - Order not present `12` - Invalid method `13` - Retriable KO `14` - Invalid session `17` - Taken in charge `25` - PSP Error `99` - Backend Error `116` - Balance not available `117` - CVV Error `121` - Limit exceeded\n",
            "required": true
          }
        ],
        "summary": "Redirection URL for transaction outcome",
        "description": "Return transaction outcome result as `outcome` query parameter",
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
    "/transactions/{transactionId}/cards/outcomes": {
      "get": {
        "tags": [
          "ecommerce-transactions"
        ],
        "summary": "Redirection URL for transaction outcome related to cards flows without onboarding",
        "description": "Return transaction outcome result as `outcome` query parameter together with the orderId",
        "operationId": "getTransactionOutcomeCardNoOnboard",
        "parameters": [
          {
            "in": "path",
            "name": "transactionId",
            "schema": {
              "type": "string"
            },
            "required": true,
            "description": "Transaction ID"
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
            "description": "`0` - Success `1` - Generic error",
            "required": true
          },
          {
            "in": "query",
            "name": "orderId",
            "schema": {
              "type": "string",
              
            },
            "description": "Order ID related to NPG",
            "required": true
          }
        ],
        "responses": {
          "302": {
            "description": "Payment - without onboarding - outcome available (see outcome query parameter)",
            "headers": {
              "Location": {
                "description": "URI with iowallet:// used by client to show result outcome and NPG orderId in query parameter",
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
