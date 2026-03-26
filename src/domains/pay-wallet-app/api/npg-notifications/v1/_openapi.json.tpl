{
  "openapi": "3.0.3",
  "info": {
    "version": "0.0.1,",
    "title": "wallet pagoPA - NPG notifications API",
    "description": "Notification API to implement callback providing order status updates after wallet creation on Nexi's NPG",
    "contact": {
      "name": "pagoPA - Touchpoints team"
    }
  },
  "tags": [
    {
      "name": "walletNotifications",
      "description": "Api's to handle npg notifications",
      "externalDocs": {
        "url": "https://pagopa.atlassian.net/wiki/spaces/WA/overview?homepageId=622658099",
        "description": "Documentation"
      }
    }
  ],
  "externalDocs": {
    "description": "Nexi API to handle onboarding",
    "url": "https://developer.nexi.it/it/api/notifica"
  },
  "servers": [
    {
      "url": "https://${hostname}"
    }
  ],
  "paths": {
    "/wallets/{walletId}/sessions/{orderId}/notifications": {
      "post": {
        "tags": [
          "walletNotifications"
        ],
        "summary": "Update Wallet on NPG onboarding authorization response",
        "description": "Update Wallet on NPG onboarding authorization response",
        "operationId": "notifyWallet",
        "parameters": [
          {
            "in": "path",
            "name": "walletId",
            "schema": {
              "type": "string",
              "format": "uuid"
            },
            "required": true,
            "description": "Unique identifier of the wallet"
          },
          {
            "in": "path",
            "name": "orderId",
            "schema": {
              "type": "string"
            },
            "required": true,
            "description": "Unique identifier of the npg session"
          }
        ],
        "requestBody": {
          "description": "Notify wallet",
          "content": {
            "application/json": {
              "schema": {
                "$ref": "#/components/schemas/NotificationRequest"
              }
            }
          },
          "required": true
        },
        "responses": {
          "200": {
            "description": "Notification handled successfully"
          },
          "400": {
            "description": "Invalid input",
            "content": {
              "application/json": {
                "schema": {
                  "$ref": "#/components/schemas/ProblemJson"
                },
                "example": {
                  "type": "https://example.com/problem/",
                  "title": "string",
                  "status": 400,
                  "detail": "Invalid input"
                }
              }
            }
          },
          "401": {
            "description": "Unauthorized",
            "content": {
              "application/json": {
                "schema": {
                  "$ref": "#/components/schemas/ProblemJson"
                },
                "example": {
                  "type": "https://example.com/problem/",
                  "title": "string",
                  "status": 401,
                  "detail": "Unauthorized"
                }
              }
            }
          },
          "500": {
            "description": "Internal server error",
            "content": {
              "application/json": {
                "schema": {
                  "$ref": "#/components/schemas/ProblemJson"
                },
                "example": {
                  "type": "https://example.com/problem/",
                  "title": "string",
                  "status": 500,
                  "detail": "Internal server error"
                }
              }
            }
          }
        }
      }
    },
    "/transactions/{transactionId}/wallets/{walletId}/sessions/{orderId}/notifications": {
      "post": {
        "operationId": "notifyContextualOnboardingWallet",
        "summary": "NPG notification webhook for wallet contextual onboard with transaction",
        "parameters": [
          {
            "in": "path",
            "name": "transactionId",
            "required": true,
            "schema": {
              "type": "string"
            }
          },
          {
            "in": "path",
            "name": "walletId",
            "schema": {
              "type": "string",
              "format": "uuid"
            },
            "required": true,
            "description": "Unique identifier of the wallet"
          },
          {
            "in": "path",
            "name": "orderId",
            "schema": {
              "type": "string"
            },
            "required": true,
            "description": "Unique identifier of the npg session"
          }
        ],
        "requestBody": {
          "description": "Notify wallet",
          "content": {
            "application/json": {
              "schema": {
                "$ref": "#/components/schemas/NotificationRequest"
              }
            }
          },
          "required": true
        },
        "responses": {
          "200": {
            "description": "Notification handled successfully"
          },
          "400": {
            "description": "Invalid input",
            "content": {
              "application/json": {
                "schema": {
                  "$ref": "#/components/schemas/ProblemJson"
                },
                "example": {
                  "type": "https://example.com/problem/",
                  "title": "string",
                  "status": 400,
                  "detail": "Invalid input"
                }
              }
            }
          },
          "401": {
            "description": "Unauthorized",
            "content": {
              "application/json": {
                "schema": {
                  "$ref": "#/components/schemas/ProblemJson"
                },
                "example": {
                  "type": "https://example.com/problem/",
                  "title": "string",
                  "status": 401,
                  "detail": "Unauthorized"
                }
              }
            }
          },
          "500": {
            "description": "Internal server error",
            "content": {
              "application/json": {
                "schema": {
                  "$ref": "#/components/schemas/ProblemJson"
                },
                "example": {
                  "type": "https://example.com/problem/",
                  "title": "string",
                  "status": 500,
                  "detail": "Internal server error"
                }
              }
            }
          }
        }
      }
    }
  },
  "components": {
    "schemas": {
      "NotificationRequest": {
        "type": "object",
        "properties": {
          "eventId": {
            "type": "string",
            "description": "Event identifier"
          },
          "eventTime": {
            "type": "string",
            "description": "Event timestamp in ISO 8601 format"
          },
          "securityToken": {
            "type": "string",
            "description": "Token received in the payment initialization phase. Used to detect the notification comes from the payment gateway."
          },
          "operation": {
            "$ref": "#/components/schemas/Operation"
          }
        },
        "required": [
          "securityToken",
          "operation"
        ]
      },
      "Operation": {
        "type": "object",
        "properties": {
          "orderId": {
            "maxLength": 27,
            "type": "string",
            "description": "Merchant order id, unique in the merchant domain",
            "example": "btid2384983"
          },
          "operationId": {
            "type": "string",
            "example": "3470744"
          },
          "channel": {
            "$ref": "#/components/schemas/ChannelType"
          },
          "operationType": {
            "$ref": "#/components/schemas/OperationType"
          },
          "operationResult": {
            "$ref": "#/components/schemas/OperationResult"
          },
          "operationTime": {
            "type": "string",
            "description": "Operation time in ISO 8601 format",
            "example": "2022-09-01T01:20:00.001Z"
          },
          "paymentMethod": {
            "$ref": "#/components/schemas/PaymentMethod"
          },
          "paymentCircuit": {
            "$ref": "#/components/schemas/PaymentCircuit"
          },
          "paymentInstrumentInfo": {
            "type": "string",
            "description": "Payment instrument information",
            "example": "***6152"
          },
          "paymentEndToEndId": {
            "maxLength": 35,
            "type": "string",
            "description": "It is defined by the circuit to uniquely identify the transaction. Required for circuid reconciliation purposes.",
            "example": "e723hedsdew"
          },
          "cancelledOperationId": {
            "type": "string",
            "description": "Operation id to be undone",
            "example": ""
          },
          "operationAmount": {
            "type": "string",
            "description": "Operation amount in the payment currency",
            "example": "3545"
          },
          "operationCurrency": {
            "type": "string",
            "description": "Payment currency",
            "example": "EUR"
          },
          "customerInfo": {
            "$ref": "#/components/schemas/CustomerInfo"
          },
          "warnings": {
            "$ref": "#/components/schemas/Warnings"
          },
          "paymentLinkId": {
            "type": "string",
            "description": "PayByLink id used for correlating this operation with the original link.",
            "example": "234244353"
          },
          "additionalData": {
            "type": "object",
            "additionalProperties": {},
            "description": "Map of additional fields specific to the chosen payment method",
            "example": {
              "authorizationCode": "647189",
              "cardCountry": "ITA",
              "threeDS": "FULL_SECURE",
              "schemaTID": "MCS01198U",
              "multiCurrencyConversion": {
                "amount": "2662",
                "currency": "JPY",
                "exchangeRate": "0.007510523"
              }
            }
          }
        },
        "required": [
          "operationResult"
        ]
      },
      "ChannelType": {
        "type": "string",
        "description": "It indicates the originating channel:\n* ECOMMERCE - carholder initiated operation through an online channel.\n* POS - carholder initiated operation through a physical POS.      \n* BACKOFFICE - merchant initiated operation. It includes post operations and MIT.\n",
        "example": "ECOMMERCE",
        "enum": [
          "ECOMMERCE",
          "POS",
          "BACKOFFICE"
        ]
      },
      "OperationType": {
        "type": "string",
        "description": "It indicates the purpose of the request:\n* AUTHORIZATION - any authorization with explicit capture\n* CAPTURE - a captured authorization or an implicit captured payment\n* VOID - reversal of an authorization\n* REFUND - refund of a captured amount\n* CANCEL - the rollback of an capture, refund.      \n",
        "example": "CAPTURE",
        "enum": [
          "AUTHORIZATION",
          "CAPTURE",
          "VOID",
          "REFUND",
          "CANCEL"
        ]
      },
      "OperationResult": {
        "type": "string",
        "description": "Transaction output:\n* AUTHORIZED - Payment authorized\n* EXECUTED - Payment confirmed, verification successfully executed\n* DECLINED - Declined by the Issuer during the authorization phase\n* DENIED_BY_RISK - Negative outcome of the transaction risk analysis\n* THREEDS_VALIDATED - 3DS authentication OK or 3DS skipped (non-secure payment)  \n* THREEDS_FAILED - cancellation or authentication failure during 3DS\n* PENDING - Payment ongoing. Follow up notifications are expected\n* CANCELED - Canceled by the cardholder\n* VOIDED - Online reversal of the full authorized amount\n* REFUNDED - Full or partial amount refunded\n* FAILED - Payment failed due to technical reasons\n",
        "example": "AUTHORIZED",
        "enum": [
          "AUTHORIZED",
          "EXECUTED",
          "DECLINED",
          "DENIED_BY_RISK",
          "THREEDS_VALIDATED",
          "THREEDS_FAILED",
          "PENDING",
          "CANCELED",
          "VOIDED",
          "REFUNDED",
          "FAILED"
        ]
      },
      "PaymentMethod": {
        "type": "string",
        "description": "* CARD - Any card circuit\n* APM - Alternative payment method\n",
        "example": "CARD",
        "enum": [
          "CARD",
          "APM"
        ]
      },
      "PaymentCircuit": {
        "type": "string",
        "description": "one of the payment circuit values returned by the GET payment_methods web service. The list may include (but not limited to) VISA, MC, AMEX, DINERS, GOOGLE_PAY, APPLE_PAY, PAYPAL, BANCONTACT, BANCOMAT_PAY, MYBANK, PIS, AMAZON_PAY, ALIPAY.\"\n",
        "example": "VISA"
      },
      "Warnings": {
        "type": "array",
        "items": {
          "$ref": "#/components/schemas/Warnings_inner"
        }
      },
      "Warnings_inner": {
        "type": "object",
        "properties": {
          "code": {
            "type": "string",
            "example": "TRA001"
          },
          "description": {
            "type": "string",
            "example": "3DS warning"
          }
        }
      },
      "CustomerInfo": {
        "type": "object",
        "properties": {
          "cardHolderName": {
            "maxLength": 255,
            "type": "string",
            "example": "Mauro Morandi"
          },
          "cardHolderEmail": {
            "maxLength": 255,
            "type": "string",
            "example": "mauro.morandi@nexi.it"
          },
          "billingAddress": {
            "$ref": "#/components/schemas/Address"
          },
          "shippingAddress": {
            "$ref": "#/components/schemas/Address"
          },
          "mobilePhoneCountryCode": {
            "maxLength": 4,
            "type": "string",
            "example": "39"
          },
          "mobilePhone": {
            "maxLength": 15,
            "type": "string",
            "example": "3280987654"
          },
          "homePhone": {
            "maxLength": 19,
            "type": "string",
            "description": "The home phone number provided by the Cardholder.",
            "example": 391231234567
          },
          "workPhone": {
            "maxLength": 19,
            "type": "string",
            "description": "The work phone number provided by the Cardholder.",
            "example": 391231234567
          },
          "cardHolderAcctInfo": {
            "$ref": "#/components/schemas/CardHolderAccountInfo"
          },
          "merchantRiskIndicator": {
            "$ref": "#/components/schemas/MerchantRiskIndicator"
          }
        }
      },
      "Address": {
        "type": "object",
        "properties": {
          "name": {
            "maxLength": 50,
            "type": "string",
            "example": "Mario Rossi"
          },
          "street": {
            "maxLength": 50,
            "type": "string",
            "example": "Piazza Maggiore, 1"
          },
          "additionalInfo": {
            "maxLength": 50,
            "type": "string",
            "example": "Quinto Piano, Scala B"
          },
          "city": {
            "maxLength": 50,
            "type": "string",
            "example": "Bologna"
          },
          "postCode": {
            "maxLength": 16,
            "type": "string",
            "example": "40124"
          },
          "province": {
            "maxLength": 3,
            "type": "string",
            "example": "BO"
          },
          "country": {
            "type": "string",
            "description": "ISO 3166-1 alpha-3",
            "example": "ITA"
          }
        }
      },
      "CardHolderAccountInfo": {
        "type": "object",
        "properties": {
          "chAccDate": {
            "type": "string",
            "description": "Date that the cardholder opened the account with the 3DS Requestor. ISO 8601 format",
            "example": "2019-02-11T00:00:00.000Z"
          },
          "chAccAgeIndicator": {
            "type": "string",
            "description": "Length of time that the cardholder has had the account with the 3DS Requestor.",
            "example": "01"
          },
          "chAccChangeDate": {
            "type": "string",
            "description": "Date that the cardholder's account with the 3DS Requestor was last changed, including Billing or Shipping address, new payment account, or new user(s) added. ISO 8601 format",
            "example": "2019-02-11T00:00:00.000Z"
          },
          "chAccChangeIndicator": {
            "type": "string",
            "description": "Length of time since the cardholder's account information with the 3DS Requestor was last changed, including Billing or Shipping address, new payment account, or new user(s) added.",
            "example": "01"
          },
          "chAccPwChangeDate": {
            "type": "string",
            "description": "Date that cardholder's account with the 3DS Requestor had a password change or account reset. ISO 8601 format",
            "example": "2019-02-11T00:00:00.000Z"
          },
          "chAccPwChangeIndicator": {
            "type": "string",
            "description": "Indicates the length of time since the cardholder's account with the 3DS Requestor had a password change or account reset.",
            "example": "01"
          },
          "nbPurchaseAccount": {
            "type": "number",
            "description": "Number of purchases with this cardholder account during the previous six months.",
            "example": 0
          },
          "destinationAddressUsageDate": {
            "type": "string",
            "description": "Date when the shipping address used for this transaction was first used with the 3DS Requestor. ISO 8601 format",
            "example": "2019-02-11T00:00:00.000Z"
          },
          "destinationAddressUsageIndicator": {
            "type": "string",
            "description": "Indicates when the shipping address used for this transaction was first used with the 3DS Requestor.",
            "example": "01"
          },
          "destinationNameIndicator": {
            "type": "string",
            "description": "Indicates if the Cardholder Name on the account is identical to the shipping Name used for this transaction.",
            "example": "01"
          },
          "txnActivityDay": {
            "type": "number",
            "description": "Number of transactions (successful and abandoned) for this cardholder account with the 3DS Requestor across all payment accounts in the previous 24 hours.",
            "example": 0
          },
          "txnActivityYear": {
            "type": "number",
            "description": "Number of transactions (successful and abandoned) for this cardholder account with the 3DS Requestor across all payment accounts in the previous year.",
            "example": 0
          },
          "provisionAttemptsDay": {
            "type": "number",
            "description": "Number of Add Card attempts in the last 24 hours.",
            "example": 0
          },
          "suspiciousAccActivity": {
            "type": "string",
            "description": "Indicates whether the 3DS Requestor has experienced suspicious activity (including previous fraud) on the cardholder account.",
            "example": "01"
          },
          "paymentAccAgeDate": {
            "type": "string",
            "description": "Date that the payment account was enrolled in the cardholder's account with the 3DS Requestor. ISO 8601 format",
            "example": "2019-02-11T00:00:00.000Z"
          },
          "paymentAccIndicator": {
            "type": "string",
            "description": "Indicates the length of time that the payment account was enrolled in the cardholder's account with the 3DS Requestor.",
            "example": "0"
          }
        }
      },
      "MerchantRiskIndicator": {
        "type": "object",
        "properties": {
          "deliveryEmail": {
            "type": "string",
            "description": "For Electronic delivery, the email address to which the merchandise was delivered.",
            "example": "john.doe@email.com"
          },
          "deliveryTimeframe": {
            "type": "string",
            "description": "Indicates the merchandise delivery timeframe.",
            "example": "01"
          },
          "giftCardAmount": {
            "$ref": "#/components/schemas/MerchantRiskIndicator_giftCardAmount"
          },
          "giftCardCount": {
            "type": "number",
            "description": "For prepaid or gift card purchase, total count of individual prepaid or gift cards/codes purchased.",
            "example": 0
          },
          "preOrderDate": {
            "type": "string",
            "description": "For a pre-ordered purchase, the expected date that the merchandise will be available. ISO 8601 format",
            "example": "2019-02-11T00:00:00.000Z"
          },
          "preOrderPurchaseIndicator": {
            "type": "string",
            "description": "Indicates whether Cardholder is placing an order for merchandise with a future availability or release date.",
            "example": "01"
          },
          "reorderItemsIndicator": {
            "type": "string",
            "description": "Indicates whether the cardholder is reordering previously purchased merchandise.",
            "example": "01"
          },
          "shipIndicator": {
            "type": "string",
            "description": "Indicates shipping method chosen for the transaction.",
            "example": "01"
          }
        }
      },
      "MerchantRiskIndicator_giftCardAmount": {
        "type": "object",
        "properties": {
          "value": {
            "type": "number",
            "description": "For prepaid or gift card purchase, the purchase amount total of prepaid or gift card(s) in major units (for example, USD 123.45 is 123).",
            "example": 100
          },
          "currency": {
            "type": "string",
            "description": "For prepaid or gift card purchase, the currency code of the card as defined in ISO 4217.",
            "example": "EUR"
          }
        },
        "example": {
          "value": 100,
          "currency": "EUR"
        }
      },
      "ProblemJson": {
        "description": "Body definition for error responses containing failure details",
        "type": "object",
        "properties": {
          "type": {
            "type": "string",
            "format": "uri",
            "description": "An absolute URI that identifies the problem type. When dereferenced,\nit SHOULD provide human-readable documentation for the problem type\n(e.g., using HTML).",
            "default": "about:blank",
            "example": "https://example.com/problem/constraint-violation"
          },
          "title": {
            "type": "string",
            "description": "A short, summary of the problem type. Written in english and readable\nfor engineers (usually not suited for non technical stakeholders and\nnot localized); example: Service Unavailable"
          },
          "status": {
            "$ref": "#/components/schemas/HttpStatusCode"
          },
          "detail": {
            "type": "string",
            "description": "A human readable explanation specific to this occurrence of the\nproblem.",
            "example": "There was an error processing the request"
          },
          "instance": {
            "type": "string",
            "format": "uri",
            "description": "An absolute URI that identifies the specific occurrence of the problem.\nIt may or may not yield further information if dereferenced."
          }
        }
      },
      "HttpStatusCode": {
        "type": "integer",
        "format": "int32",
        "description": "The HTTP status code generated by the origin server for this occurrence\nof the problem.",
        "minimum": 100,
        "maximum": 600,
        "exclusiveMaximum": true,
        "example": 502
      }
    }
  }
}